import logging
import math
from pathlib import Path
from typing import Dict, Iterator, List, NamedTuple

import yaml
from flask import Flask, json, request

from track.wpm.open_project import OpenProjectClient, WorkPackageSpec

# Configuration constants
API_KEY = Path('api_key.txt').read_text().strip()
assert len(API_KEY) > 40, "API key seems invalid, too short"
CONFIG_FILE = 'config.yml'
SUCCESS_RESPONSE = json.dumps({'success': True})
ORDER_TYPE_ID = 1
PRODUCTION_ORDER_TYPE_ID = 4
CONFIRMED_STATUS_ID = 4
ORDER_PROJECT_ID = 3
PRODUCTION_ORDER_PROJECT_ID = 5
FACE_SHIELD_FRAMES_FIELD_ID = 'customField7'
VISORS_FIELD_ID = 'customField8'
EAR_SAVERS_FIELD_ID = 'customField9'
CONTACT_NAME_FIELD_ID = 'customField4'
CONTACT_PHONE_FIELD_ID = 'customField5'
FACILITY_TYPE_FIELD_ID = 'customField2'
URGENCY_FIELD_ID = 'customField6'
FACILITY_NAME_FIELD_ID = 'customField1'
FACILITY_ADDRESS_FIELD_ID = 'customField3'
REGION_FIELD_ID = 'customField16'
FACILITY_TYPE_OPTION_IDS = dict(map(reversed, enumerate([
    'Primary Care',
    'Nursing Home',
    'Specialist',
    'Hospital',
    'Health Authority / Other Organization',
    'Pharmacy',
    'Other'
], 1)))
URGENCY_OPTION_IDS = {
    1: 8,
    2: 9,
    3: 10
}


class BatchedField(NamedTuple):
    name: str
    open_project_key: str
    batch_size: int


class Order(NamedTuple):
    subject: str
    region: str
    quantities: Dict[str, int]


class HCPSubmission(NamedTuple):
    facilityName: str
    facilityAddress: str
    contactName: str
    contactPhone: str

    requestFaceShieldFrames: int
    requestVisors: int
    requestEarSavers: int

    # 1 means "Staff are working without face shields", 3 means "Still have adequate stock available"
    requestUrgency: int

    # Must be one of:
    #   | Primary Care
    #   | Nursing Home
    #   | Specialist
    #   | Hospital
    #   | Health Authority / Other Organization
    #   | Pharmacy
    #   | Other
    facilityType: str


logging.basicConfig(level=logging.INFO,
                    format='%(asctime)s - %(name)s - %(levelname)s - %(message)s')

with open(CONFIG_FILE, 'r') as config_file_handle:
    config = yaml.safe_load(config_file_handle)

openproject = OpenProjectClient(url=config['openProjectUrl'], api_key=API_KEY)

batched_fields = [BatchedField(**d) for d in config['fields']['batched']]
logging.info('found batched fields {}'.format(batched_fields))

app = Flask(__name__)


def submit_hcp_order(d: HCPSubmission):
    total_items = d.requestFaceShieldFrames + d.requestVisors + d.requestEarSavers
    spec = WorkPackageSpec(
        type_id=ORDER_TYPE_ID,
        subject='{} items for {}'.format(total_items, d.facilityName),
        project_id=ORDER_PROJECT_ID,
        extra_fields={
            FACE_SHIELD_FRAMES_FIELD_ID: d.requestFaceShieldFrames,
            VISORS_FIELD_ID: d.requestVisors,
            EAR_SAVERS_FIELD_ID: d.requestEarSavers,
            CONTACT_NAME_FIELD_ID: d.contactName,
            CONTACT_PHONE_FIELD_ID: d.contactPhone,
            FACILITY_ADDRESS_FIELD_ID: {
                'raw': d.facilityAddress
            },
            FACILITY_NAME_FIELD_ID: d.facilityName
        },
        extra_links={
            URGENCY_FIELD_ID: "custom_options/{}".format(URGENCY_OPTION_IDS[d.requestUrgency]),
            FACILITY_TYPE_FIELD_ID: "custom_options/{}".format(
                FACILITY_TYPE_OPTION_IDS[d.facilityType])
        }
    )
    return openproject.create_work_package(spec)


def create_batched_sub_orders(super_order: Order, existing_sub_orders: List[Order]) -> Iterator[Order]:
    all_keys = {f.open_project_key for f in batched_fields}
    default_quantities = dict.fromkeys(all_keys, 0)
    for batched_field in batched_fields:
        key = batched_field.open_project_key
        batch_size = batched_field.batch_size
        required = super_order.quantities[key]
        existing = sum([existing.quantities[key]
                        for existing in existing_sub_orders])
        new_batches = math.ceil(
            max(0, required - existing) / batched_field.batch_size)
        subject = '{} - {} x{}'.format(super_order.subject,
                                       batched_field.name, batch_size)
        for _ in range(new_batches):
            yield Order(
                quantities={**default_quantities, key: batch_size},
                subject=subject,
                region=super_order.region
            )


def parse_order(order_dict) -> Order:
    return Order(
        quantities={field.open_project_key: order_dict[field.open_project_key] for field in batched_fields},
        subject=order_dict['subject'],
        region=order_dict[REGION_FIELD_ID]
    )


def create_production_order(parent_id: int, order: Order):
    spec = WorkPackageSpec(
        subject=order.subject,
        type_id=PRODUCTION_ORDER_TYPE_ID,
        project_id=PRODUCTION_ORDER_PROJECT_ID,
        parent_id=parent_id,
        extra_fields={
            **order.quantities,
            REGION_FIELD_ID: order.region
        }
    )
    return openproject.create_work_package(spec)


def update_work_package(work_package_id):
    logging.info('Updating work package id {}'.format(work_package_id))
    wp = openproject.get_work_package(work_package_id)
    linked_fields = wp['_embedded']
    if linked_fields['type']['id'] == ORDER_TYPE_ID and linked_fields['status']['id'] == CONFIRMED_STATUS_ID:
        wp_order = parse_order(wp)
        logging.info('{} is a confirmed order: {}'.format(
            work_package_id, wp_order))
        existing_children = openproject.get_children(wp)
        existing_orders = [parse_order(child) for child in existing_children]
        logging.info('found existing batches: {}'.format(existing_orders))
        new_batches = list(create_batched_sub_orders(
            wp_order, existing_orders))
        logging.info('new batches required: {}'.format(new_batches))
        for order in new_batches:
            create_production_order(work_package_id, order)
    else:
        logging.info('no action required for {}'.format(work_package_id))


@app.route('/update', methods=['POST'])
def update():
    req_json = request.get_json()
    if 'work_package' in req_json:
        wp_id = int(req_json['work_package']['id'])
        update_work_package(wp_id)
    else:
        logging.warning('unrecognised request {}'.format(json.dumps(req_json)))
    return SUCCESS_RESPONSE


@app.route('/hcp/submit', methods=['POST'])
def hcp_submit():
    req_json = request.get_json()
    order = HCPSubmission(**req_json)
    logging.info('Received order: {}'.format(order))
    submit_hcp_order(order)
    return SUCCESS_RESPONSE


if __name__ == '__main__':
    app.run(host='0.0.0.0', port=config['server']['port'])

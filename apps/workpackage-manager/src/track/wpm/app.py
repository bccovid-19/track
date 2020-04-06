from flask import Flask, json, request
import logging
import yaml
from typing import NamedTuple, Dict, List, Iterator
import math
import os
from pathlib import Path

from track.wpm.open_project import OpenProjectClient, WorkPackageSpec

OPENPROJECT_URL = 'https://track.bcc3d.ca'
API_KEY = Path('api_key.txt').read_text().strip()
CONFIG_FILE = 'config.yml'
SUCCESS_RESPONSE = json.dumps({'success': True})
ORDER_TYPE_ID = 1
PRODUCTION_ORDER_TYPE_ID = 4
CONFIRMED_STATUS_ID = 4
PPE_PROJECT_ID = 3

assert len(API_KEY) > 40, "API key seems invalid, too short"


class BatchedField(NamedTuple):
    name: str
    open_project_key: str
    batch_size: int


class Order(NamedTuple):
    subject: str
    quantities: Dict[str, int]


logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(name)s - %(levelname)s - %(message)s')

with open(CONFIG_FILE, 'r') as f:
    config = yaml.safe_load(f)

openproject = OpenProjectClient(url=OPENPROJECT_URL, api_key=API_KEY)

batched_fields = [BatchedField(**d) for d in config['fields']['batched']]
logging.info('found batched fields {}'.format(batched_fields))

app = Flask(__name__)


def create_batched_sub_orders(super_order: Order, existing_sub_orders: List[Order]) -> Iterator[Order]:
    all_keys = {f.open_project_key for f in batched_fields}
    default_quantities = {k: 0 for k in all_keys}
    for batched_field in batched_fields:
        key = batched_field.open_project_key
        batch_size = batched_field.batch_size
        required = super_order.quantities[key]
        existing = sum([existing.quantities[key] for existing in existing_sub_orders])
        new_batches = math.ceil(max(0, required - existing) / batched_field.batch_size)
        subject = '{} - {} x{}'.format(super_order.subject, batched_field.name, batch_size)
        for _ in range(new_batches):
            yield Order(quantities={**default_quantities, key: batch_size}, subject=subject)


def parse_order(order_dict) -> Order:
    quantities = {}
    for batched_field in batched_fields:
        key = batched_field.open_project_key
        quantities[key] = order_dict[key]
    return Order(quantities=quantities, subject=order_dict['subject'])


def create_production_order(parent_id: int, order: Order):
    spec = WorkPackageSpec(
        subject=order.subject,
        type_id=PRODUCTION_ORDER_TYPE_ID,
        project_id=PPE_PROJECT_ID,
        parent_id=parent_id,
        extra_fields=order.quantities
    )
    return openproject.create_work_package(spec)


def update_work_package(work_package_id):
    logging.info('Updating work package id {}'.format(work_package_id))
    wp = openproject.get_work_package(work_package_id)
    linked_fields = wp['_embedded']
    if linked_fields['type']['id'] == ORDER_TYPE_ID and linked_fields['status']['id'] == CONFIRMED_STATUS_ID:
        wp_order = parse_order(wp)
        logging.info('{} is a confirmed order: {}'.format(work_package_id, wp_order))
        existing_children = openproject.get_children(wp)
        existing_orders = [parse_order(child) for child in existing_children]
        logging.info('found existing batches: {}'.format(existing_orders))
        new_batches = list(create_batched_sub_orders(wp_order, existing_orders))
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


if __name__ == '__main__':
    app.run(host='0.0.0.0', port=config['server']['port'])

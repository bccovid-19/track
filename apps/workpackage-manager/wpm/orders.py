import logging
import math
from typing import NamedTuple, Dict, List

from wpm.constants import *
from wpm.openproject import WorkPackageSpec, OpenProjectClient


class BatchedField(NamedTuple):
    name: str
    openproject_key: str
    batch_size: int

    @staticmethod
    def from_config(config) -> List['BatchedField']:
        return [BatchedField(**d) for d in config['fields']['batched']]


class Order(NamedTuple):
    subject: str
    region: str
    quantities: Dict[str, int]


def create_hcp_order_spec(hcp_request) -> WorkPackageSpec:
    items = hcp_request['items']
    facility = hcp_request['facility']
    contact = hcp_request['contact']
    total_items = items['faceShieldFrames'] + items['visors'] + items['earSavers']
    return WorkPackageSpec(
        type_id=ORDER_TYPE_ID,
        subject='{} items for {}'.format(total_items, facility['name']),
        project_id=ORDER_PROJECT_ID,
        extra_fields={
            FACE_SHIELD_FRAMES_FIELD_ID: items['faceShieldFrames'],
            VISORS_FIELD_ID: items['visors'],
            EAR_SAVERS_FIELD_ID: items['earSavers'],
            CONTACT_NAME_FIELD_ID: contact['name'],
            CONTACT_PHONE_FIELD_ID: contact['phone'],
            CONTACT_EMAIL_FIELD_ID: contact['email'],
            FACILITY_ADDRESS_FIELD_ID: {
                'raw': facility['address']
            },
            FACILITY_NAME_FIELD_ID: facility['name'],
            NOTES_FIELD_ID: {
                'raw': hcp_request['notes']
            },
        },
        extra_custom_options={
            URGENCY_FIELD_ID: URGENCY_OPTION_IDS[hcp_request['urgency']],
            FACILITY_TYPE_FIELD_ID: FACILITY_TYPE_OPTION_IDS[facility['type']],
            REGION_FIELD_ID: hcp_request['region']
        }
    )


def create_production_order_spec(parent_id: int, order: Order) -> WorkPackageSpec:
    return WorkPackageSpec(
        subject=order.subject,
        type_id=PRODUCTION_ORDER_TYPE_ID,
        project_id=PRODUCTION_ORDER_PROJECT_ID,
        parent_id=parent_id,
        extra_fields={
            **order.quantities,
            REGION_FIELD_ID: order.region
        }
    )


class OrderProcessor:
    batched_fields: List[BatchedField]

    def __init__(self, batched_fields: List[BatchedField]):
        self.batched_fields = batched_fields

    def parse_order(self, openproject_dict: Dict) -> Order:
        return Order(
            quantities={field.openproject_key: openproject_dict[field.openproject_key]
                        for field in self.batched_fields},
            subject=openproject_dict[SUBJECT_FIELD_ID],
            region=openproject_dict[REGION_FIELD_ID]
        )

    def create_batched_sub_orders(self, super_order: Order, existing_sub_orders: List[Order]) -> List[Order]:
        all_keys = {f.openproject_key for f in self.batched_fields}
        default_quantities = dict.fromkeys(all_keys, 0)
        result = []
        for batched_field in self.batched_fields:
            key = batched_field.openproject_key
            batch_size = batched_field.batch_size
            required = super_order.quantities[key]
            existing = sum([existing.quantities[key]
                            for existing in existing_sub_orders])
            new_batches = math.ceil(
                max(0, required - existing) / batched_field.batch_size)
            subject = '{} - {} x{}'.format(super_order.subject,
                                           batched_field.name, batch_size)
            for _ in range(new_batches):
                result.append(Order(
                    quantities={**default_quantities, key: batch_size},
                    subject=subject,
                    region=super_order.region
                ))
        return result

    def update_work_package(self, openproject_client: OpenProjectClient, work_package_id):
        logging.info('Updating work package id {}'.format(work_package_id))
        wp = openproject_client.get_work_package(work_package_id)
        linked_fields = wp['_embedded']
        if linked_fields['type']['id'] == ORDER_TYPE_ID and linked_fields['status']['id'] == CONFIRMED_STATUS_ID:
            wp_order = self.parse_order(wp)
            logging.info('{} is a confirmed order: {}'.format(
                work_package_id, wp_order))
            existing_children = openproject_client.get_children(wp)
            existing_orders = [self.parse_order(child) for child in existing_children]
            logging.info('found existing batches: {}'.format(existing_orders))
            new_batches = self.create_batched_sub_orders(wp_order, existing_orders)
            logging.info('new batches required: {}'.format(new_batches))
            for order in new_batches:
                new_spec = create_production_order_spec(work_package_id, order)
                openproject_client.create_work_package(new_spec)
        else:
            logging.info('no action required for {}'.format(work_package_id))

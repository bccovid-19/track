import unittest
import mock

from wpm.orders import *

batched_fields = [
    BatchedField(name='2 Field', open_project_key='2key', batch_size=2),
    BatchedField(name='5 Field', open_project_key='5key', batch_size=5)
]


def example_order(two_quantity: int, five_quantity: int) -> Order:
    return Order(subject='test subject', region='test region',
                 quantities={batched_fields[0].open_project_key: two_quantity,
                             batched_fields[1].open_project_key: five_quantity})


def remove_subject(orders):
    if isinstance(orders, list):
        return [remove_subject(o) for o in orders]
    else:
        d = orders._asdict()
        del d['subject']
        return Order(**d, subject='')


class TestOrderProcessing(unittest.TestCase):
    def test_order_parsing(self):
        orders = OrderProcessor(batched_fields)
        test_dict = {
            SUBJECT_FIELD_ID: 'test subject',
            REGION_FIELD_ID: 'test region',
            batched_fields[0].open_project_key: 11,
            batched_fields[1].open_project_key: 6,
            'ignored': 'test'
        }

        order = orders.parse_order(test_dict)
        self.assertEqual(example_order(11, 6), order)

        del test_dict[SUBJECT_FIELD_ID]
        self.assertRaises(Exception, lambda: orders.parse_order(test_dict))
        self.assertRaises(Exception, lambda: orders.parse_order({}))

    def assert_orders_equal(self, orders1, orders2):
        self.assertEqual(remove_subject(orders1), remove_subject(orders2))

    def test_batching(self):
        orders = OrderProcessor(batched_fields)
        empty1 = orders.create_batched_sub_orders(example_order(0, 0), [])
        self.assert_orders_equal([], empty1)

        empty2 = orders.create_batched_sub_orders(example_order(5, 5), [example_order(5, 0), example_order(0, 5)])
        self.assert_orders_equal([], empty2)

        batched1 = orders.create_batched_sub_orders(example_order(4, 6), [])
        self.assert_orders_equal([example_order(2, 0), example_order(2, 0), example_order(0, 5), example_order(0, 5)],
                                 batched1)

        batched2 = orders.create_batched_sub_orders(example_order(4, 5), [example_order(3, 0), example_order(0, 5)])
        self.assert_orders_equal([example_order(2, 0)], batched2)


if __name__ == '__main__':
    unittest.main()

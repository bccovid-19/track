from marshmallow import Schema
from marshmallow.fields import Str, Int, Nested
from marshmallow.validate import Range, OneOf

REQUESTED_ITEM_RANGE = Range(min=0, max=10000)
VALID_FACILITY_TYPES = OneOf([
    'Primary Care', 'Nursing Home', 'Specialist', 'Hospital',
    'Health Authority / Other Organization', 'Pharmacy', 'Other'
])


class FacilitySchema(Schema):
    name = Str()
    address = Str()
    type = Str(validate=VALID_FACILITY_TYPES)


class ContactSchema(Schema):
    name = Str()
    phone = Str()


class ItemsSchema(Schema):
    faceShieldFrames = Int(validate=REQUESTED_ITEM_RANGE)
    visors = Int(validate=REQUESTED_ITEM_RANGE)
    earSavers = Int(validate=REQUESTED_ITEM_RANGE)


class HCPRequestSchema(Schema):
    urgency = Int(validate=OneOf([1, 2, 3]))
    facility = Nested(FacilitySchema)
    contact = Nested(ContactSchema)
    items = Nested(ItemsSchema)

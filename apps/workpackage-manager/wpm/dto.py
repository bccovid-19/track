from marshmallow import Schema
from marshmallow.fields import Str, Int, Nested, Raw, List
from marshmallow.validate import Range, OneOf

from openproject import CustomFieldOption

REQUESTED_ITEM_RANGE = Range(min=0, max=10000)
VALID_FACILITY_TYPES = OneOf([
    'Primary Care', 'Nursing Home', 'Specialist', 'Hospital',
    'Health Authority / Other Organization', 'Pharmacy', 'Other'
])


class FacilitySchema(Schema):
    name = Str()
    address = Str()
    type = Str(validate=VALID_FACILITY_TYPES)


class ChoiceSchema(Schema):
    label = Str()
    id = Raw()

    @staticmethod
    def from_dto(choice: CustomFieldOption):
        return ChoiceSchema().dump(choice)


class ContactSchema(Schema):
    name = Str()
    phone = Str()
    email = Str()


class ItemsSchema(Schema):
    faceShieldFrames = Int(validate=REQUESTED_ITEM_RANGE)
    visors = Int(validate=REQUESTED_ITEM_RANGE)
    earSavers = Int(validate=REQUESTED_ITEM_RANGE)


class HCPRequestSchema(Schema):
    urgency = Int(validate=OneOf([1, 2, 3]))
    notes = Str()
    region = Int(description='Get region ids from /region')
    facility = Nested(FacilitySchema)
    contact = Nested(ContactSchema)
    items = Nested(ItemsSchema)


class RegionsResponseSchema(Schema):
    regions = List(Nested(ChoiceSchema))

    @staticmethod
    def from_options(choices):
        return RegionsResponseSchema().dump(dict(regions=[ChoiceSchema.from_dto(c) for c in choices]))

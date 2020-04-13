def field_key(field_id: int) -> str:
    return 'customField{}'.format(field_id)


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
CONTACT_EMAIL_FIELD_ID = 'customField17'
FACILITY_TYPE_FIELD_ID = 'customField2'
URGENCY_FIELD_ID = 'customField6'
FACILITY_NAME_FIELD_ID = 'customField1'
FACILITY_ADDRESS_FIELD_ID = 'customField3'
REGION_FIELD_ID_NUM = 19
REGION_FIELD_ID = field_key(REGION_FIELD_ID_NUM)
SUBJECT_FIELD_ID = 'subject'
NOTES_FIELD_ID = 'customField18'
FACILITY_TYPE_OPTION_IDS = {name: i for i, name in enumerate([
    'Primary Care',
    'Nursing Home',
    'Specialist',
    'Hospital',
    'Health Authority / Other Organization',
    'Pharmacy',
    'Other'
], 1)}
URGENCY_OPTION_IDS = {
    1: 8,
    2: 9,
    3: 10
}

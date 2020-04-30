import logging

import yaml
from apispec.ext.marshmallow import MarshmallowPlugin
from apispec_webframeworks.flask import FlaskPlugin
from flasgger import APISpec, Swagger
from flask import Flask, json, request, Blueprint

from wpm.dto import HCPRequestSchema, RegionsResponseSchema
from wpm.openproject import OpenProjectClient
from wpm.orders import OrderProcessor, BatchedField, create_hcp_order_spec, REGION_FIELD_ID_NUM

# Configuration constants
CONFIG_FILE = 'config.yml'
SUCCESS_RESPONSE = json.dumps({'success': True})

logging.basicConfig(level=logging.INFO,
                    format='%(asctime)s - %(name)s - %(levelname)s - %(message)s')

with open(CONFIG_FILE, 'r') as config_file_handle:
    config = yaml.safe_load(config_file_handle)

BASE_URL = config['server']['base_url']

openproject = OpenProjectClient(**config['openproject'])
orders = OrderProcessor(BatchedField.from_config(config))

app = Flask(__name__)

api = Blueprint('api', __name__, url_prefix=BASE_URL)


@api.route('/openproject/update', methods=['POST'])
def openproject_update():
    """
    Web-hook for OpenProject work-package updates
    """
    req_json = request.get_json()
    if 'work_package' in req_json:
        wp_id = int(req_json['work_package']['id'])
        orders.process_work_package_update(openproject, wp_id)
    else:
        logging.warning('unrecognised request {}'.format(json.dumps(req_json)))
    return SUCCESS_RESPONSE


@api.route('/hcp/request', methods=['POST'])
def hcp_request_post():
    """
    ---
    description: Submit a new request from an HCP
    parameters:
        - in: body
          name: body
          schema:
              $ref: '#/definitions/HCPRequest'
    responses:
        200:
            description: Success
    """
    req_json = request.get_json()
    order = HCPRequestSchema().dump(req_json)
    logging.info('Received order: {}'.format(order))
    new_spec = create_hcp_order_spec(order)
    openproject.create_work_package(new_spec)
    return SUCCESS_RESPONSE


@api.route('/region', methods=['GET'])
def regions_get():
    """
    ---
    description: List of all regions
    responses:
        200:
            description: List of all regions
            schema:
              $ref: '#/definitions/RegionsResponse'
    """
    options = openproject.get_custom_field_options(REGION_FIELD_ID_NUM)
    return RegionsResponseSchema.from_options(options)


# noinspection PyArgumentList
spec = APISpec(
    title='WorkPackage Manager',
    version='1.0',
    openapi_version='2.0',
    plugins=[
        FlaskPlugin(),
        MarshmallowPlugin(),
    ],
)

app.register_blueprint(api)

template = spec.to_flasgger(
    app,
    definitions=[
        HCPRequestSchema,
        RegionsResponseSchema],
    paths=[
        hcp_request_post,
        regions_get]
)

swagger_config = Swagger.DEFAULT_CONFIG.copy()
swagger_config['specs_route'] = '{}/apidocs/'.format(BASE_URL)
swag = Swagger(app, template=template, config=swagger_config)

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=config['server']['port'])

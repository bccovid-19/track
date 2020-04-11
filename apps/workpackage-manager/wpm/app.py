import logging
import math
from pathlib import Path

import yaml
from flasgger import APISpec, Swagger
from apispec.ext.marshmallow import MarshmallowPlugin
from apispec_webframeworks.flask import FlaskPlugin

from flask import Flask, json, request

from dto import HCPRequestSchema
from wpm.openproject import OpenProjectClient
from wpm.orders import OrderProcessor, BatchedField, create_hcp_order_spec

# Configuration constants

API_KEY = Path('api_key.txt').read_text().strip()
assert len(API_KEY) > 40, "API key seems invalid, too short"
CONFIG_FILE = 'config.yml'
SUCCESS_RESPONSE = json.dumps({'success': True})

logging.basicConfig(level=logging.INFO,
                    format='%(asctime)s - %(name)s - %(levelname)s - %(message)s')

with open(CONFIG_FILE, 'r') as config_file_handle:
    config = yaml.safe_load(config_file_handle)

openproject = OpenProjectClient(url=config['openProjectUrl'], api_key=API_KEY)
orders = OrderProcessor(BatchedField.from_config(config))

app = Flask(__name__)


@app.route('/openproject/update', methods=['POST'])
def openproject_update():
    """
    Webhook for OpenProject work-package updates
    """
    req_json = request.get_json()
    if 'work_package' in req_json:
        wp_id = int(req_json['work_package']['id'])
        orders.update_work_package(openproject, wp_id)
    else:
        logging.warning('unrecognised request {}'.format(json.dumps(req_json)))
    return SUCCESS_RESPONSE


@app.route('/hcp/request', methods=['POST'])
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


spec = APISpec(
    title='WorkPackage Manager',
    version='1.0',
    openapi_version='2.0',
    plugins=[
        FlaskPlugin(),
        MarshmallowPlugin(),
    ],
)

template = spec.to_flasgger(
    app,
    definitions=[HCPRequestSchema],
    paths=[hcp_request_post]
)


swag = Swagger(app, template=template)


if __name__ == '__main__':
    app.run(host='0.0.0.0', port=config['server']['port'])

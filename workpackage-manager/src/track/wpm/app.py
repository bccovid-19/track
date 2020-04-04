from flask import Flask, json, request
import logging
import yaml
from typing import NamedTuple

from track.wpm.open_project import OpenProjectClient

CONFIG_FILE = 'config.yml'
SUCCESS_RESPONSE = json.dumps({'success': True})


class ProductionField(NamedTuple):
    name: str
    openProjectKey: str
    batchSize: int


logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(name)s - %(levelname)s - %(message)s')

with open(CONFIG_FILE, 'r') as f:
    config = yaml.safe_load(f)

op_client = OpenProjectClient(config)

production_fields = {d['name']: ProductionField(**d) for d in config['productionFields']}

api = Flask(__name__)


@api.route('/update', methods=['POST'])
def update():
    req_json = request.get_json()
    logging.info(req_json)
    if 'work_package' in req_json:
        wp_id = int(req_json['work_package']['id'])
        logging.info(op_client.work_package(wp_id))
    return SUCCESS_RESPONSE


if __name__ == '__main__':
    api.run(host='0.0.0.0', port=config['server']['port'])

from flask import Flask, json, request
import logging
import yaml

CONFIG_FILE = 'config.yml'
SUCCESS_RESPONSE = json.dumps({'success': True})

logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(name)s - %(levelname)s - %(message)s')

with open(CONFIG_FILE, 'r') as f:
    config = yaml.safe_load(f)

api_key = config['openProjectApi']['key']
api_user = config['openProjectApi']['user']

api = Flask(__name__)


@api.route('/update', methods=['POST'])
def update():
    logging.info(request.get_json())
    return SUCCESS_RESPONSE


if __name__ == '__main__':
    print(api_key)
    api.run(host='0.0.0.0', port=config['server']['port'])

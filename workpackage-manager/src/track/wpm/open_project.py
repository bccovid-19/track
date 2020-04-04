import requests
from requests.auth import HTTPBasicAuth


class OpenProjectClient:
    auth: HTTPBasicAuth
    api_url: str

    def __init__(self, config):
        self.api_url = config['openProjectApi']['url'] + '/api/v3'

        api_key = config['openProjectApi']['key']
        self.auth = HTTPBasicAuth(username='apikey', password=api_key)

    def get(self, path: str):
        return requests.get('{}{}'.format(self.api_url, path), auth=self.auth)

    def work_package(self, id: int):
        return self.get('/work_packages/{}'.format(id)).json()

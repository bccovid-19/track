import json
import logging
from typing import NamedTuple, Dict, Any, Optional

import requests
from requests.auth import HTTPBasicAuth


class WorkPackageSpec(NamedTuple):
    type_id: int
    subject: str
    project_id: int
    description: str = ''
    extra_fields: Dict[str, Any] = {}
    status_id: Optional[int] = None
    parent_id: Optional[int] = None

    def as_openproject_object(self):
        return {
            'subject': self.subject,
            'description': {
                'raw': self.description
            },
            '_links': {
                'type': {
                    'href': '/api/v3/types/{}'.format(self.type_id)
                },
                'project': {
                    'href': '/api/v3/projects/{}'.format(self.project_id)
                },
                'status': {
                    'href': '/api/v3/statuses/{}'.format(self.status_id) if self.status_id else None
                },
                'parent': {
                    'href': '/api/v3/work_packages/{}'.format(self.parent_id) if self.parent_id else None
                }
            },
            **self.extra_fields
        }


class OpenProjectClient:
    auth: HTTPBasicAuth
    api_url: str

    def __init__(self, url: str, api_key: str):
        self.api_url = url
        self.auth = HTTPBasicAuth(username='apikey', password=api_key)

    def get(self, path: str):
        url = '{}{}'.format(self.api_url, path)
        logging.info('GET {}'.format(url))
        resp = requests.get(url, auth=self.auth)
        result = resp.json()
        logging.debug('response {}'.format(json.dumps(result)))
        resp.raise_for_status()
        return result

    def post(self, path: str, json_body):
        url = '{}{}'.format(self.api_url, path)
        logging.info('POST {} with {}'.format(url, json.dumps(json_body)))
        resp = requests.post(url=url, json=json_body, auth=self.auth)
        result = resp.json()
        logging.debug('response {}'.format(json.dumps(result)))
        resp.raise_for_status()
        return result

    def get_work_package(self, id: int):
        return self.get('/api/v3/work_packages/{}'.format(id))

    def get_children(self, work_package):
        if 'children' in work_package['_links']:
            children = work_package['_links']['children']
            return [self.get(child['href']) for child in children]
        else:
            return []

    def create_work_package(self, spec: WorkPackageSpec):
        return self.post('/api/v3/work_packages', spec.as_openproject_object())

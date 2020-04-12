import json
import logging
import re
from datetime import datetime, timedelta
from typing import Any, Dict, NamedTuple, Optional, List

import requests
from bs4 import BeautifulSoup

# I made this number up - it's not based on any OpenProject timeout logic
LOGIN_TIMEOUT = timedelta(minutes=10)


class CustomFieldOption(NamedTuple):
    label: str
    id: int


class WorkPackageSpec(NamedTuple):
    type_id: int
    subject: str
    project_id: int
    description: str = ''
    extra_fields: Dict[str, Any] = {}
    extra_links: Dict[str, str] = {}
    status_id: Optional[int] = None
    parent_id: Optional[int] = None

    def as_openproject_object(self):
        extra_links = {
            k: {'href': '/api/v3/' + v} for k, v in self.extra_links.items()
        }
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
                },
                **extra_links

            },
            **self.extra_fields
        }


class OpenProjectClient:
    url: str
    username: str
    password: str
    session: requests.Session
    logged_in_at: datetime
    testing: bool = False
    unsent_requests: List[Dict]

    def __init__(self, url: str, username: str, password: str):
        self.url = url
        self.username = username
        self.password = password
        self.session = requests.Session()
        self.logged_in_at = datetime(2000, 1, 1)
        self.unsent_requests = []

    def assert_logged_in(self):
        if (datetime.now() - self.logged_in_at) > LOGIN_TIMEOUT:
            self._do_login()

    def _do_login(self):
        """
        OpenProject API is missing several parts (don't trust the documentation).
        So, we have to parse the HTML responses. Which means we can't use API-KEY based basic-auth.
        This method will establish a session cookie for us.
        """
        logging.info('Refreshing login cookie')
        login_page = self.session.get('{}/login'.format(self.url))
        login_page.raise_for_status()
        csrf_token = BeautifulSoup(login_page.text, 'html.parser').find('meta', dict(name='csrf-token'))['content']
        login_resp = self.session.post('{}/login'.format(self.url),
                                       json=dict(authenticity_token=csrf_token, username=self.username,
                                                 password=self.password))
        login_resp.raise_for_status()
        self.logged_in_at = datetime.now()

    def get(self, path: str):
        url = '{}{}'.format(self.url, path)
        logging.info('GET {}'.format(url))
        self.assert_logged_in()
        resp = self.session.get(url)
        resp.raise_for_status()
        return resp

    def get_json(self, path: str):
        resp = self.get(path)
        result = resp.json()
        logging.debug('response {}'.format(json.dumps(result)))
        return result

    def get_soup(self, path: str):
        resp = self.get(path)
        return BeautifulSoup(resp.text, 'html.parser')

    def post(self, path: str, json_body):
        url = '{}{}'.format(self.url, path)
        logging.info('POST {} with {}'.format(url, json.dumps(json_body)))
        if self.testing:
            logging.info('Not actually sending POST since we are in testing mode')
            self.unsent_requests.append(json_body)
            return {}
        self.assert_logged_in()
        resp = self.session.post(url=url, json=json_body)
        result = resp.json()
        logging.debug('response {}'.format(json.dumps(result)))
        resp.raise_for_status()
        return result

    def get_work_package(self, id: int):
        return self.get_json('/api/v3/work_packages/{}'.format(id))

    def get_children(self, work_package):
        if 'children' in work_package['_links']:
            children = work_package['_links']['children']
            return [self.get_json(child['href']) for child in children]
        else:
            return []

    def create_work_package(self, spec: WorkPackageSpec):
        return self.post('/api/v3/work_packages', spec.as_openproject_object())

    def get_custom_field_options(self, field_id: int) -> List[CustomFieldOption]:
        edit_page = self.get_soup('/custom_fields/{}/edit'.format(field_id))
        value_input_regex = re.compile(r'custom_field_custom_options_attributes_(\d+)_value')
        id_input_regex = re.compile(r'custom_field_custom_options_attributes_(\d+)_id')
        value_inputs = edit_page.find_all('input', id=value_input_regex)
        id_inputs = edit_page.find_all('input', id=id_input_regex)
        values = {value_input_regex.match(i['id']).group(1): i['value'] for i in value_inputs}
        ids = {id_input_regex.match(i['id']).group(1): i['value'] for i in id_inputs}
        if set(values.keys()) != set(ids.keys()):
            logging.error('OpenProject soup parsing issue {} vs. {}'.format(values.keys(), ids.keys()))
        keys = set(values.keys()) & set(ids.keys())
        return [CustomFieldOption(label=values[k], id=ids[k]) for k in keys]

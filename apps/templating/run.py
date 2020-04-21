#!/usr/bin/python3
import oyaml as yaml
from jinja2 import Template, Environment, FileSystemLoader, StrictUndefined
from glob import glob
import os
from deepmerge import always_merger

TEMPLATE_DIR = 'templates'
TARGET_DIR = '.'

with open('defaults.yml') as f:
    defaults = yaml.safe_load(f)
with open('config.yml') as f:
    config = yaml.safe_load(f)

template_vars = always_merger.merge(defaults, config)
template_vars['projectRoot'] = os.path.abspath('.')

tmpl_env = Environment(
    loader=FileSystemLoader('.'),
    undefined=StrictUndefined)

for tmpl_file_name in glob('{}/**'.format(TEMPLATE_DIR), recursive=True):
    if os.path.isdir(tmpl_file_name):
        continue
    prefix, suffix = str(tmpl_file_name).split(TEMPLATE_DIR)
    suffix = suffix[1:]
    assert(len(prefix) == 0)
    target_file_name = os.path.join(TARGET_DIR, suffix)
    tmpl = tmpl_env.get_template(tmpl_file_name)
    print('Templating {} to {}'.format(tmpl_file_name, target_file_name), flush=True)
    os.makedirs(os.path.dirname(target_file_name), exist_ok=True)
    tmpl.stream(**template_vars).dump(target_file_name)

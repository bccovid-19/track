#!/usr/bin/env bash

set -e

cp ./systemd/* /etc/systemd/system/
systemctl daemon-reload
systemctl enable --now bcc3d-live
systemctl enable --now bcc3d-qa
systemctl enable --now bcc3d-ssl-termination

echo "systemd units installed and enabled"

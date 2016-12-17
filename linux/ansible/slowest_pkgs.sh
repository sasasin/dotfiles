#!/bin/bash -v
ansible-playbook -i localhost.inv slowest_pkgs.yml --connection=local

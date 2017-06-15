#!/bin/bash

if [[ ! -f /opt/cockroach/ca/ca.key ]];then
  echo "> No CA ('/opt/cockroach/ca/ca.key') found, skip..."
  exit 0
fi
for user in $(echo ${COCKROACH_USERS} |sed -e 's/,/ /g');do
  if [[ ! -f /opt/cockroach/certs/client.${user}.crt ]];then
    cockroach cert create-client ${user} --certs-dir=/opt/cockroach/certs/ --ca-key=/opt/cockroach/ca/ca.key
  fi
done

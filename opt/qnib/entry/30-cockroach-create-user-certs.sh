#!/bin/bash

for user in $(echo ${COCKROACH_USERS} |sed -e 's/,/ /g');do
  cockroach cert create-client ${user} --certs-dir=/opt/cockroach/certs/ --ca-key=/opt/cockroach/ca/ca.key
done

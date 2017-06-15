#!/bin/bash

if [[ ! -f /opt/cockroach/ca/ca.key ]];then
  echo "> No CA ('/opt/cockroach/ca/ca.key') found, skip..."
  exit 0
fi

if [[ ! -f /opt/cockroach/certs/node.crt ]];then
  gosu cockroach cockroach cert create-node localhost cockroach_node tasks.node $(hostname) \
                            --certs-dir=/opt/cockroach/certs/ \
                            --ca-key=/opt/cockroach/ca/ca.key
fi

#!/bin/bash

cockroach cert create-node $(hostname) --certs-dir=/opt/cockroach/certs/ --ca-key=/opt/cockroach/ca/ca.key
cockroach cert list --certs-dir=/opt/cockroach/certs/

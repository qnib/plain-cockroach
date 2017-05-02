#!/bin/bash

if [[ "X${COCKROACH_SERVER}" != "X" ]];then
    JOIN_CMD="--join=${COCKROACH_SERVER}"
fi

cockroach start --insecure ${JOIN_CMD}

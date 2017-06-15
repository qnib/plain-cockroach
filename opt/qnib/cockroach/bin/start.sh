#!/bin/bash
set -x

if [[ "X${COCKROACH_SERVER}" == "X" ]];then
  COCKROACH_SERVER=${SWARM_SERVICE_NAME}
fi
SEC_OPTS=--insecure
if [[ $(find /opt/cockroach/certs/ |wc -l) -gt 1 ]];then
  SEC_OPTS=--certs-dir=/opt/cockroach/certs/
fi
cockroach sql --host ${COCKROACH_SERVER} ${SEC_OPTS} -e 'SHOW DATABASES;' >> /dev/null
SQL_EC=$?
if [[ "X${SWARM_TASK_SLOT}" != "X1" ]] && [[ "X${COCKROACH_SERVER}" != "X" ]];then
    export JOIN_CMD="--join=${COCKROACH_SERVER}"
elif [[ "X${SWARM_TASK_SLOT}" == "X1" ]] && [[ ${TASK_FOUND} -eq 1 ]];then
  echo ">> Task.Slot is ${SWARM_TASK_SLOT} and not able to ping ${COCKROACH_SERVER} - must be the first to initialize the cluster!"
fi
cockroach start --certs-dir=/opt/cockroach/certs/ ${JOIN_CMD}

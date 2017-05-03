#!/bin/bash

if [[ "X${COCKROACH_SERVER}" == "X" ]];then
  COCKROACH_SERVER=${SWARM_SERVICE_NAME}
fi

cockroach sql --host ${COCKROACH_SERVER} --insecure -e 'SHOW DATABASES;' >> /dev/null
SQL_EC=$?
if [[ "X${SWARM_TASK_SLOT}" != "X1" ]] && [[ "X${COCKROACH_SERVER}" != "X" ]];then
    JOIN_CMD="--join=${COCKROACH_SERVER}"
elif [[ "X${SWARM_TASK_SLOT}" == "X1" ]] && [[ ${SQL_EC} -eq 1 ]];then
  echo ">> Task.Slot is ${SWARM_TASK_SLOT} and not able to ping ${COCKROACH_SERVER} - must be the first to initialize the cluster!"
fi

cockroach start --insecure ${JOIN_CMD}

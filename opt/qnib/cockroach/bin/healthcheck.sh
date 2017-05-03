#!/bin/bash

if [[ "X${COCKROACH_SERVER}" == "X" ]];then
  COCKROACH_SERVER=${SWARM_SERVICE_NAME}
fi

cockroach sql --host ${COCKROACH_SERVER} --insecure -e 'SHOW DATABASES;' >> /dev/null
SQL_EC=$?

if [[ "X${SWARM_TASK_SLOT}" == "X1" ]] && [[ ${SQL_EC} -ne 0 ]];then
  echo "My slot is 1 and the cockroach sql command on ${COCKROACH_SERVER} was failing. - INITILIZE by fakeing health"
  exit 0
else
  cockroach sql --insecure -e 'SHOW TIME ZONE;' --format records
fi

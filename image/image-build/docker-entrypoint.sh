#!/bin/sh
set -e
cp /locust/locustfile.py /script-home/
cd /script-home
LOCUST_MODE=${LOCUST_MODE:-standalone}
LOCUST_MASTER_BIND_PORT=${LOCUST_MASTER_BIND_PORT:-5557}
LOCUST_FILE=${LOCUST_FILE:-locustfile.py}

if [ -z ${ATTACKED_HOST+x} ] ; then
    echo "You need to set the URL of the host to be tested (ATTACKED_HOST)."
    exit 1
fi

LOCUST_OPTS="-f ${LOCUST_FILE} --host=${ATTACKED_HOST} --no-reset-stats $LOCUST_OPTS"

case `echo ${LOCUST_MODE} | tr 'a-z' 'A-Z'` in
"LOCUST-MASTER")
    LOCUST_OPTS="--master --master-bind-port=${LOCUST_MASTER_BIND_PORT} $LOCUST_OPTS"
    ;;

"LOCUST-SLAVE")
    LOCUST_OPTS="--slave --master-host=${LOCUST_MASTER} --master-port=${LOCUST_MASTER_BIND_PORT} $LOCUST_OPTS"
    if [ -z ${LOCUST_MASTER+x} ] ; then
        echo "You need to set LOCUST_MASTER."
        exit 1
    fi
    ;;
esac
locust ${LOCUST_OPTS}

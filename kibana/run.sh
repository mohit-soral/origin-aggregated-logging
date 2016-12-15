#!/bin/sh
set -euo pipefail

sed -i "s/es_host/$ES_HOST/" ${KIBANA_CONF}/kibana.yml
sed -i "s/es_port/$ES_PORT/" ${KIBANA_CONF}/kibana.yml

exec ${KIBANA_HOME}/bin/kibana

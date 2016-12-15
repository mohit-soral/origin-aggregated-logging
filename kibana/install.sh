#mkdir -p -m 755 ${KIBANA_HOME}/installedPlugins/origin-kibana
#cd ${KIBANA_HOME}/installedPlugins/origin-kibana
#wget -q ${AOP_KIBANA_PLUGIN_REPO}/releases/download/${AOP_KIBANA_PLUGIN_VER}/origin-kibana-${AOP_KIBANA_PLUGIN_VER}.tgz
#tar -xvzf origin-kibana-${AOP_KIBANA_PLUGIN_VER}.tgz
#rm origin-kibana-${AOP_KIBANA_PLUGIN_VER}.tgz

# Kibana starts up slowly because it tries to optimize and cache bundles
# so we start it up as part of install and then stop it
mv ${KIBANA_CONF}/kibana.yml ${KIBANA_CONF}/hidden_kibana.yml
touch ${KIBANA_CONF}/kibana.yml

${KIBANA_HOME}/bin/kibana > ${KIBANA_HOME}/kibana.out &
pid=$!

until [ -n "$(grep 'Optimization of bundles for kibana and statusPage complete' ${KIBANA_HOME}/kibana.out)" ]; do
  sleep 1
done
kill $pid

rm ${KIBANA_HOME}/kibana.out
rm ${KIBANA_CONF}/kibana.yml
mv ${KIBANA_CONF}/hidden_kibana.yml ${KIBANA_HOME}/config/kibana.yml
chmod -R og+w ${HOME}
chmod -R og+rw ${KIBANA_HOME}
chmod -R og+rw ${KIBANA_CONF}

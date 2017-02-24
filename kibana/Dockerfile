FROM openshift/base-centos7

MAINTAINER Mohit Soral <mohit.soral@siemens.com>

EXPOSE 5601

ENV KIBANA_VER=5.0.1 \
    ES_HOST=localhost \
    ES_PORT=9200 \
    HOME=/opt/app-root/src \
    KIBANA_CONF=/etc/kibana \
    KIBANA_HOME=/usr/share/kibana
    
LABEL io.k8s.description="Kibana container for querying Elasticsearch for aggregated logs" \
  io.k8s.display-name="Kibana" \
  io.openshift.expose-services="5601:http" \
  io.openshift.tags="logging,elk,kibana"

ADD kibana.repo /etc/yum.repos.d/kibana.repo
# install the RPMs in a separate step so it can be cached
#RUN rpm --import https://artifacts.elastic.co/GPG-KEY-elasticsearch && \
#    yum install -y --setopt=tsflags=nodocs \
#                kibana-${KIBANA_VER} && \
#    yum clean all

RUN rpm --import https://artifacts.elastic.co/GPG-KEY-elasticsearch && \
    wget https://artifacts.elastic.co/downloads/kibana/kibana-${KIBANA_VER}-x86_64.rpm \
    rpm --install kibana-${KIBANA_VER}-x86_64.rpm

COPY kibana.yml ${KIBANA_CONF}/kibana.yml
# install.sh just starts kibana and verifies that it runs. So I am ignoring it for now.
#COPY run.sh install.sh ${HOME}/
#RUN sh install.sh
COPY run.sh ${HOME}/

USER default

CMD ["sh", "run.sh"]

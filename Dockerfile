FROM centos:7.4.1708
LABEL MAINTAINER="unisp <cicero.gadelha@funceme.br | jonas.cavalcantineto@funceme.com>"

RUN yum update -y 
RUN yum install -y \
    vim \
    wget \
    epel-release.noarch \
    openssl 

RUN yum update -y
RUN yum install -y supervisor.noarch                 

#ENVIRONMENTS
ENV APISERVER_IP="127.0.0.1"
ENV KUBERNETES_CLUSTER_RANGE_IP="10.254.0.0/16"
ENV CLUSTER_NAME="cluster.local"
ENV CONTEXT_NAME="default"
ENV USER="admin"
ENV PATH_BASE_KUBERNETES="/opt/kubernetes/kube-scheduler"
ENV DIR_CERTS="${PATH_BASE_KUBERNETES}/certificates"
ENV SCHEDULER_CERTS="${DIR_CERTS}/kube-scheduler"
ENV TOKEN="fQAv5WoZEDyu6YKP5e3AH33p7qYKN92K"
ENV SCHEDULER_PEM="kube-scheduler.pem"
ENV SCHEDULER_KEY_PEM="kube-scheduler-key.pem"
ENV CA_CERT_PEM="ca.pem"
ENV CA_CERT_PEM_KEY="ca-key.pem"
ENV API_CERT_CRT="apiserver.crt"
ENV API_KEY="apiserver.key"
ENV API_CERT_PEM="apiserver.pem"
ENV API_KEY_PEM="apiserver-key.pem"
ENV API_CERT_CSR="apiserver.csr"

#KUBERNETES
ENV KUBERNETES_VERSION "v1.9.8"

RUN set -ex \
    && wget https://github.com/kubernetes/kubernetes/releases/download/${KUBERNETES_VERSION}/kubernetes.tar.gz \
    && tar -zxvf kubernetes.tar.gz -C /tmp \
    && echo y | /tmp/kubernetes/cluster/get-kube-binaries.sh \
    && tar -zxvf /tmp/kubernetes/server/kubernetes-server-*.tar.gz -C /tmp/kubernetes/server \
    && mkdir -p ${PATH_BASE_KUBERNETES}/bin \
    && cp -a /tmp/kubernetes/server/kubernetes/server/bin/kube-scheduler ${PATH_BASE_KUBERNETES}/bin/ \
    && ln -s ${PATH_BASE_KUBERNETES}/bin/kube-scheduler /usr/local/sbin/kube-scheduler \
    && mkdir -p DIR_CERTS \    
    && useradd kube \
    && chown -R kube:kube ${PATH_BASE_KUBERNETES}/ \
    && rm -rf /tmp/kubernetes \
    && rm -f kubernetes.tar.gz

# #GENERATE CERTIFICATES 
# RUN set -ex \
#     && mkdir ${DIR_CERTS} \
#     && cd ${DIR_CERTS} \
#     && openssl genrsa -out ${DIR_CERTS}/kube-control-manage-key.pem 2048 \
#     && openssl req -new -key ${DIR_CERTS}/kube-control-manage-key.pem -out ${DIR_CERTS}/kube-control-manage.csr -subj "/CN=kube-scheduler" \
#     && openssl x509 -req -in ${DIR_CERTS}/kube-control-manage.csr -CA ${DIR_CERTS}/${CA_CERT_PEM} -CAkey ${DIR_CERTS}/${CA_CERT_PEM_KEY} -CAcreateserial -out ${DIR_CERTS}/kube-control-manage.pem -days 7200

ADD bin/start_scheduler.sh /start_scheduler.sh
RUN chmod +x /start_scheduler.sh
#PORTS
# TCP     10251       kube-scheduler
EXPOSE 10251

COPY conf/supervisord.conf /etc/
ADD bin/start.sh /start.sh
RUN chmod +x /start.sh
CMD ["./start.sh"]

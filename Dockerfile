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
ENV PATH_BASE_KUBERNETES="/opt/kubernetes"
ENV DIR_CERTS="${PATH_BASE_KUBERNETES}/certs"
ENV SCHEDULER_CERTS="${DIR_CERTS}/modules/kube-scheduler"
ENV SCHEDULER_PEM="kube-scheduler.pem"
ENV SCHEDULER_KEY_PEM="kube-scheduler-key.pem"


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
    && mkdir -p ${DIR_CERTS} \    
    && useradd kube \
    && chown -R kube:kube ${PATH_BASE_KUBERNETES}/ \
    && rm -rf /tmp/kubernetes \
    && rm -f kubernetes.tar.gz

ADD bin/start_scheduler.sh /start_scheduler.sh
RUN chmod +x /start_scheduler.sh

#PORTS
# TCP     10251       kube-scheduler
EXPOSE 10251

COPY conf/supervisord.conf /etc/
ADD bin/start.sh /start.sh
RUN chmod +x /start.sh
CMD ["./start.sh"]

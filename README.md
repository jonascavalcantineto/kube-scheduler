# Enviroment Defaults

```
ENV APISERVER_IP="127.0.0.1"
ENV KUBERNETES_CLUSTER_RANGE_IP="10.254.0.0/16"
ENV CLUSTER_NAME="cluster.local"
ENV CONTEXT_NAME="default"
ENV USER="admin"
ENV PATH_BASE_KUBERNETES="/opt/kubernetes/control-manager"
ENV DIR_CERTS="${PATH_BASE_KUBERNETES}/certificates"
ENV KUBECONFIG="${DIR_CERTS}/kube-control-manager"
ENV TOKEN="fQAv5WoZEDyu6YKP5e3AH33p7qYKN92K"
ENV ADMIN_KEY_PEM="admin-key.pem"
ENV CA_CERT_PEM="ca.pem"
ENV CA_CERT_PEM_KEY="ca-key.pem"
ENV API_CERT_CRT="apiserver.crt"
ENV API_KEY="apiserver.key"
ENV API_CERT_PEM="apiserver.pem"
ENV API_KEY_PEM="apiserver-key.pem"
ENV API_CERT_CSR="apiserver.csr"

```

# Docker command

```
docker run -d 
        --name <container_name> --privileged 
        -p 10251:10251  
        -e APISERVER_IP=<ip_apiserver> 
        -e KUBERNETES_CLUSTER_RANGE_IP=<network/mask> 
        -e CLUSTER_NAME=<name.cluster> 
        -e USER=<user_admin> 
        -e PATH_BASE_KUBERNETES=<path_files_kube_apiserver> 
        -e DIR_CERTS=<path_all_certificates> 
        -e KUBECONFIG="<kubconfig_path>"
        -e ADMIN_CERT_PEM=<cert_user_admin.pem> 
        -e ADMIN_KEY_PEM=<user_admin-key.pem> 
        -e CA_CERT_PEM=<ca_cert_PEM.pem> 
        -e CA_CERT_PEM_KEY=<ca-key.pem>  
        -e API_CERT_CRT=<apiserver.crt> 
        -e API_KEY=<apiserver.key> 
        -e API_CERT_PEM=<apiserver.pem> 
        -e API_KEY_PEM=<apiserver-key.pem> 
        -e TOKEN=<token_generate_api>
        -v <path_local_storage_with_certificates_api>:${DIR_CERTS} <image>:<tag>
```
# Kubernetes

[![Submit Queue Widget]][Submit Queue] [![GoDoc Widget]][GoDoc] [![CII Best Practices](https://bestpractices.coreinfrastructure.org/projects/569/badge)](https://bestpractices.coreinfrastructure.org/projects/569)

<img src="https://github.com/kubernetes/kubernetes/raw/master/logo/logo.png" width="100">

----

Kubernetes is an open source system for managing [containerized applications]
across multiple hosts; providing basic mechanisms for deployment, maintenance,
and scaling of applications.

Kubernetes builds upon a decade and a half of experience at Google running
production workloads at scale using a system called [Borg],
combined with best-of-breed ideas and practices from the community.

Kubernetes is hosted by the Cloud Native Computing Foundation ([CNCF]).
If you are a company that wants to help shape the evolution of
technologies that are container-packaged, dynamically-scheduled
and microservices-oriented, consider joining the CNCF.
For details about who's involved and how Kubernetes plays a role,
read the CNCF [announcement].

----

## To start using Kubernetes

See our documentation on [kubernetes.io].

Try our [interactive tutorial].

Take a free course on [Scalable Microservices with Kubernetes].

## Support

If you need support, start with the [troubleshooting guide],
and work your way through the process that we've outlined.

That said, if you have questions, reach out to us
[one way or another][communication].

[announcement]: https://cncf.io/news/announcement/2015/07/new-cloud-native-computing-foundation-drive-alignment-among-container
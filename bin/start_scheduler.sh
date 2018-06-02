#!/bin/bash

kube-scheduler \
--leader-elect=true \
--v=2 \
--kubeconfig=${SCHEDULER_CERTS}/kubeconfig
#!/usr/bin/env bash

clusterctl generate cluster $AWS_EKS_CLUSTER_NAME \
  --flavor eks-managedmachinepool \
  --kubernetes-version $KUBERNETES_VERSION  \
  --worker-machine-count=$WORKER_MACHINE_COUNT \
  > ./capi-eks-$AWS_EKS_CLUSTER_NAME.yaml


#!/usr/bin/env bash

## create the namespace if it doesn't exist
kubectl create namespace $AWS_EKS_CLUSTER_NAME --dry-run=client -o yaml | kubectl apply -f -

## we'll use our custom eks template to build from which includes the vpc-cni addon
## for a list of other flavours, check https://github.com/kubernetes-sigs/cluster-api-provider-aws/tree/main/templates
clusterctl generate cluster $AWS_EKS_CLUSTER_NAME \
  --target-namespace $AWS_EKS_CLUSTER_NAME \
  --from templates/cluster-template-eks.yaml \
  --infrastructure aws \
  --kubernetes-version $KUBERNETES_VERSION  \
  --worker-machine-count=$WORKER_MACHINE_COUNT \
  > ./capi-eks-$AWS_EKS_CLUSTER_NAME.yaml

## display the cluster manifest produced
cat capi-eks-$AWS_EKS_CLUSTER_NAME.yaml
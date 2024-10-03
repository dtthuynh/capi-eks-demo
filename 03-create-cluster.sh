#!/usr/bin/env bash

## now we're ready to create our cluster by simply applying the yaml
kubectl apply -f capi-eks-$AWS_EKS_CLUSTER_NAME.yaml

### Once done, we should be good. Next couple steps are some additional things we can do
### to check the progress of the cluster as well as some other useful commands

## check the progress of the cluster via kubectl, which should be set to Provisioning
kubectl get clusters -A

## check the progress of the cluster's progression via clusterctl
clusterctl describe cluster $AWS_EKS_CLUSTER_NAME

## export the kubeconfig for the cluster
kubectl get secret $AWS_EKS_CLUSTER_NAME-user-kubeconfig \
  --namespace=$AWS_EKS_CLUSTER_NAME \
  -o jsonpath={.data.value} | base64 --decode \
  > $AWS_EKS_CLUSTER_NAME.kubeconfig

## on the cluster, we can check the nodes
kubectl --kubeconfig=$AWS_EKS_CLUSTER_NAME.kubeconfig get nodes
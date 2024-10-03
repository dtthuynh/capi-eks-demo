#!/usr/bin/env bash

#export AWS_ACCESS_KEY_ID="<YOUR_AWS_ACCESS_KEY_ID>"
#export AWS_SECRET_ACCESS_KEY="<YOUR_AWS_SECRET_ACCESS_KEY>"

export EKS=true
export EXP_MACHINE_POOL=true
export CAPA_EKS_IAM=true

export AWS_REGION="us-east-1"
export CONTROL_PLANE_MACHINE_COUNT=1
export WORKER_MACHINE_COUNT=3
export KUBERNETES_VERSION="v1.30.1"
export NODE_INSTANCE_TYPE="t3.medium"

export AWS_EKS_CLUSTER_NAME="capi-eks-2"
export AWS_SSH_KEY_NAME="$AWS_EKS_CLUSTER_NAME"
export AWS_B64ENCODED_CREDENTIALS=$(clusterawsadm bootstrap credentials encode-as-profile)

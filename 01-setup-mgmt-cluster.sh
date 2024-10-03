#!/usr/bin/env bash

# Create the kind cluster
kind create cluster --name $KIND_MGMT_CLUSTER_NAME

# Cluster API Provider for AWS ships with clusterawsadm, a utility to help you manage IAM objects
# The clusterawsadm binary uses env variables and encodes them in a value to be stored in a Kubernetes Secret 
# for the Kind cluster to fetch necessary permissions to create the workload clusters.
clusterawsadm bootstrap iam create-cloudformation-stack --region $AWS_REGION

# install the Cluster API components for AWS, this will help transform the Kind cluster into a management cluster
clusterctl init --infrastructure aws

# If we require SSH access to the nodes, we need to generate the SSH key
#aws ec2 create-key-pair --key-name ${AWS_EKS_CLUSTER_NAME} --region ${AWS_REGION} --query 'KeyMaterial' --output text > capi-eks.pem


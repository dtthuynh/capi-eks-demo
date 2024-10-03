# CAPI EKS Demo

Deploy EKS via CAPI, using Kind as the management cluster, and then prepare the cluster to be imported by Red Hat ACM/MCE.

## Pre-Requisites

You should have the following installed (can be done via homebrew on Mac):

- [kubectl](https://kubernetes.io/docs/tasks/tools/)
- [kind](https://kind.sigs.k8s.io/docs/user/quick-start/)
- [clusterctl](https://cluster-api.sigs.k8s.io/user/quick-start.html)
- [clusterawsadm](https://cluster-api.sigs.k8s.io/user/quick-start.html)
- [aws cli](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)

## Steps

1. Setup environment variables

    *Tip* You can update the script `00-setup-mgmt-exportVars.sh` and then `source` it to export the vars.

    Set the following environment variables to your needs. You can also do this via the [clusterctl configuration file](https://cluster-api.sigs.k8s.io/clusterctl/configuration) if you wish.

    ```bash
    export AWS_ACCESS_KEY_ID="<YOUR_AWS_ACCESS_KEY_ID>"
    export AWS_SECRET_ACCESS_KEY="<YOUR_AWS_SECRET_ACCESS_KEY>"

    export EKS=true
    export EXP_MACHINE_POOL=true
    export CAPA_EKS_IAM=true

    export AWS_REGION="us-east-1"
    export CONTROL_PLANE_MACHINE_COUNT=1
    export WORKER_MACHINE_COUNT=3
    export KUBERNETES_VERSION="v1.30.1"
    export NODE_INSTANCE_TYPE="t3.medium"

    export KIND_MGMT_CLUSTER_NAME="capi-mgmt"
    export AWS_EKS_CLUSTER_NAME="capi-eks1"
    export AWS_SSH_KEY_NAME="$AWS_EKS_CLUSTER_NAME"
    export AWS_B64ENCODED_CREDENTIALS=$(clusterawsadm bootstrap credentials encode-as-profile)
    ```

2. Setup the management cluster by running the script `01-setup-mgmt-cluster.sh`
3. Generate the necessary cluster manifests by running the script `02-setup-mgmt-clsuter.sh`
4. Create the cluster by running the script `03-create-cluster.sh`
5. Your cluster should now in the process of being created, with a kubeconfig generated for you

    *Note:* in order to import the cluster into MCE/ACM, you'll need to update the cluster with the correct Service Account, as well as updating the kubeconfig to contain the token.

    ```bash
    $ kubectl get clusters -A
    NAME         CLUSTERCLASS   PHASE         AGE   VERSION
    capi-eks-2                  Provisioned   28m

    $ clusterctl describe cluster capi-eks-2
    NAME                                                              READY  SINCE
    Cluster/capi-eks-2                                                True   15m
    ├─ClusterInfrastructure - AWSManagedCluster/capi-eks-2
    ├─ControlPlane - AWSManagedControlPlane/capi-eks-2-control-plane  True   15m
    └─Workers
      └─MachinePool/capi-eks-2-pool-0                                 True   13m
    ```

## Further Reading & References

- [Cluster API Book](https://cluster-api.sigs.k8s.io/)
- [Cluster API Provider AWS](https://cluster-api-aws.sigs.k8s.io/topics/eks/creating-a-cluster)
- [Multi-cluster management for Kubernetes with Cluster API and Argo CD](https://aws.amazon.com/blogs/containers/multi-cluster-management-for-kubernetes-with-cluster-api-and-argo-cd/)
- [Use Cluster API to provision Kubernetes clusters in anywhere!](https://dev.to/timtsoitt/use-cluster-api-to-provision-kubernetes-clusters-22c4)
# Create a GKE cluster
This repo is a collection of scripts to speed up my deployment of JFrog products on GKE.

At present, it just deploys a GKE cluster with a subnet and external access.

Much of the boilerplate code was taken from the Hashicorp tutorial here [Provision a GKE Cluster tutorial](https://developer.hashicorp.com/terraform/tutorials/kubernetes/gke).


## OSX Setup
### Install Terraform and setup GCP connectivity
Install terraform on your mac
```shell
brew install terraform
```

Install google cloud SDK
```shell
brew install --cask google-cloud-sdk
```

## Fedora Setup
### Install Terraform and setup GCP connectivity
Install terraform repo.
```shell
sudo dnf config-manager --add-repo https://rpm.releases.hashicorp.com/fedora/hashicorp.repo
```

Install Terraform
```shell
sudo dnf install terraform
```

Install kubectl
```shell
dnf install kubectl
```

Install google cloud SDK repo
```shell
sudo tee -a /etc/yum.repos.d/google-cloud-sdk.repo << EOM
[google-cloud-cli]
name=Google Cloud CLI
baseurl=https://packages.cloud.google.com/yum/repos/cloud-sdk-el9-x86_64
enabled=1
gpgcheck=1
repo_gpgcheck=0
gpgkey=https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
EOM
```

Install google cloud SDK
```shell
sudo dnf install google-cloud-cli
```

Install the gcloud auth plugin.
```shell
sudo dnf install google-cloud-cli-gke-gcloud-auth-plugin
```

Authenticate with the GCP
```shell
gcloud auth application-default login
```

Test connectivity by getting the you default configured project
```shell
gcloud config get-value project
```
#### Setup Terraform
Change directory into the repo.
```shell
.
└── deploy-gke-cluster
    ├── LICENSE
    ├── README.md
    ├── gke.tf
    ├── kubernetes-dashboard-admin.rbac.yaml
    ├── outputs.tf
    ├── terraform.tfvars
    ├── versions.tf
    └── vpc.tf
```

Pull in all of the project dependencies
```shell
terraform init
```

modify the values in ```terraform.tfvars``` to reflect your deployment region, machine type and a prefix to help identify your nodes in a shared project.  

Then you can plan you project
```shell
terraform plan
```

Apply it (takes 10-15 mins)
```shell
terraform apply
```

When finished, destroy your cluster
```shell
terraform destroy
```


## Configuring kubectl
After the install is complete the following command will configure kubectl with the details of your cluster

```shell
gcloud container clusters get-credentials $(terraform output -raw kubernetes_cluster_name) --region $(terraform output -raw region)
```

You can then test connectivity to your clusters
```shell
kubectl get nodes
```

You can check the status of the clusters in the [GKE console](https://console.cloud.google.com/kubernetes/list/overview?project=soleng-dev&supportedpurview=project). 

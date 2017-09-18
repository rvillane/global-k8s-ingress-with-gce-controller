## Requires these variables to be set

# export PROJECT=your-projectname
# export DNS_ZONE=your.domain.com.

[[ -z "$PROJECT" ]] && { echo "Env var PROJECT is missing, please export PROJECT=your-project" ; exit 1; }
[[ -z "$DNS_ZONE" ]] && { echo "Env var DNS_ZONE is missing, please export DNS_ZONE=your.domain.com." ; exit 1; }

# Create Clusters
gcloud container clusters create west-cluster --zone us-west1-a --scopes "cloud-platform,storage-ro,logging-write,monitoring-write,service-control,service-management,https://www.googleapis.com/auth/ndev.clouddns.readwrite"
gcloud container clusters create east-cluster --zone us-east1-b --scopes  "cloud-platform,storage-ro,logging-write,monitoring-write,service-control,service-management,https://www.googleapis.com/auth/ndev.clouddns.readwrite"

# Make Aliases
kubectl config set-context east --cluster=gke_${PROJECT}_us-east1-b_east-cluster --user=gke_${PROJECT}_us-east1-b_east-cluster
kubectl config set-context west --cluster=gke_${PROJECT}_us-west1-a_west-cluster --user=gke_${PROJECT}_us-west1-a_west-cluster

# Install and join the federation
kubefed init kfed --host-cluster-context=east --dns-zone-name=${DNS_ZONE} --dns-provider=google-clouddns
kubefed --context=kfed join east-cluster --cluster-context=east --host-cluster-context=east
kubefed --context=kfed join west-cluster --cluster-context=west --host-cluster-context=east
kubectl --context=kfed create ns default

# Use kfed context to create resources and deployments
kubectl config use-context kfed

# Show me the money
echo "kubectl --context=kfed get clusters "
kubectl --context=kfed get clusters
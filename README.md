# global-k8s-ingress-with-gce-controller


# Global Ingress

```
export PROJECT=hd-$(whoami)-$(date +%y%m%d)-ingress
export BILLING=00AA00-111111111-0000000
export DNS_ZONE=ingress.my.domain.com.
```


Create the project
```
gcloud projects create ${PROJECT}
gcloud beta billing projects link ${PROJECT} --billing-account=${BILLING}

gcloud config set project ${PROJECT}
```

Enable some APIs
```
gcloud service-management enable compute-component.googleapis.com \
--project=$PROJECT
gcloud service-management enable container.googleapis.com \
--project=$PROJECT
```

## Create clusters

```
gcloud container clusters create west-cluster \
  --zone us-west1-a --scopes "cloud-platform,storage-ro,logging-write,monitoring-write,service-control,service-management,https://www.googleapis.com/auth/ndev.clouddns.readwrite"

gcloud container clusters create east-cluster \
  --zone us-east1-b --scopes  "cloud-platform,storage-ro,logging-write,monitoring-write,service-control,service-management,https://www.googleapis.com/auth/ndev.clouddns.readwrite"
```


### Create aliases
We need shorter names that are compliant with a specific regex that happens to exclude underscores

```
kubectl config set-context east --cluster=gke_${PROJECT}_us-east1-b_east-cluster --user=gke_${PROJECT}_us-east1-b_east-cluster

kubectl config set-context west --cluster=gke_${PROJECT}_us-west1-a_west-cluster --user=gke_${PROJECT}_us-west1-a_west-cluster

```

## Step 2 - Install and Join to kubefed
Here were using kubefed to initialize the federation using the "east" context
```

kubefed init kfed \
  --host-cluster-context=east \
  --dns-zone-name=${DNS_ZONE} \
  --dns-provider=google-clouddns

kubectl config use-context kfed
```

The `kfed` context should be used for all federated deploys.  You can inspect the various cluster independently but all actions should be performed on the federated context. 

### Join the clusters into the federation
Provide the contexts to the federation server to join in the clusters

```
kubefed --context=kfed join east-cluster \
  --cluster-context=east \
  --host-cluster-context=east

kubefed --context=kfed join west-cluster \
  --cluster-context=west \
  --host-cluster-context=east

```



### Create the default namespace
```
kubectl --context=kfed create ns default
```


### Review the clusters are joined
```
kubectl --context=kfed get clusters
```


## Deploy to Cluster

```
git clone https://github.com/cgrant/global-k8s-ingress-with-gce-controller.git

cd global-k8s-ingress-with-gce-controller

kubectl apply -f deploy/app-with-context.yaml
kubectl apply -f deploy/app-without-context.yaml

kubectl apply -f deploy/ingress.yaml

```
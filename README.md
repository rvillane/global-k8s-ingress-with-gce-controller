# global-k8s-ingress-with-gce-controller

Make a federated cluster
```
./cluster/cluster-up.sh
```

Deploy some apps and services
```
kubectl apply -f deploy/app-with-context.yaml
kubectl apply -f deploy/app-without-context.yaml
```

Play with ingress options
```
kubectl apply -f deploy/ingress.yaml
```
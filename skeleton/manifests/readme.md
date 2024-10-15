

# 1. kustomize 배포


## DEV 환경 배포

```sh
$ kustomize build ./manifests/overlays/dev
```



## PRD 환경 배포

```sh
$ kustomize build ./manifests/overlays/prd
```




# 2. ArgoCD

## application

```sh



# DEV
$ kubectl apply -k ./manifests/overlays/dev/gitops

# 삭제시...
$ kubectl delete -k ./manifests/overlays/dev/gitops



# PRD
$ kubectl apply -k ./manifests/overlays/prd/gitops

# 삭제시...
$ kubectl delete -k ./manifests/overlays/prd/gitops



```




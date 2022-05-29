# how-to-build-a-paas

从0到1基于目前云原生的开源项目，构建一套基于`Kubernetes`的`PaaS`平台，作为演示和教学场景使用。

## 特性

+ [ ] code
  + [ ] gitlab
+ [ ] ci&cd
  + [ ] gitlab ci

## 如何构建

### 构建安装环境

```shell
docker build  -f Dockerfile -t  paas-install:master .

docker run -it -v ~/.kube/config:/root/.kube2/config paas-install:master
```

### 安装paas平台

```shell

# 创建命名空间
kubectl create namespace paas

helm install netcorepal-paas  ./charts/netcorepal-paas --namespace paas --create-namespace

helm uninstall netcorepal-paas --namespace paas
# 安装ingress

helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm install ingress-nginx ingress-nginx/ingress-nginx --namespace ingress-nginx --create-namespace -f ingress-nginx-values.yaml

kubectl create ingress demo-localhost --class=nginx  --rule=gitlab.localhost/*=demo:80
# 安装 gitlab
helm repo add gitlab https://charts.gitlab.io/
helm repo update
helm install gitlab gitlab/gitlab  --set global.hosts.domain=localhost  --set certmanager-issuer.email=me@example.com --namespace paas --create-namespace -f gitlab-values.yaml

# 安装  prometheus
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update
helm install kube-prometheus-stack prometheus-community/kube-prometheus-stack --namespace paas --create-namespace -f kube-prometheus-stack-values.yaml

helm uninstall kube-prometheus-stack --namespace paas
# 安装  rabbitmq

# 安装  mysql

# 安装  elasticsearch

# 安装  redis


```

## 相关文档

使用helm安装gitlab
<https://docs.gitlab.com/charts/quickstart/index.html#installing-kubectl>

<https://microsoft.github.io/reverse-proxy/articles/config-files.html>

<https://helm.sh/docs/chart_best_practices/dependencies/>

<https://www.lmlphp.com/user/60747/article/item/1653704/>

<https://blog.csdn.net/qq_39680564/article/details/107516510?utm_medium=distribute.pc_aggpage_search_result.none-task-blog-2~aggregatepage~first_rank_ecpm_v1~rank_v31_ecpm-2-107516510-null-null.pc_agg_new_rank&utm_term=helm%E4%BE%9D%E8%B5%96&spm=1000.2123.3001.4430>
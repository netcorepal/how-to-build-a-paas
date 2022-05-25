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

# 安装 gitlab
helm repo add gitlab https://charts.gitlab.io/

helm install gitlab gitlab/gitlab \
  --set global.hosts.domain=localhost \
  --set certmanager-issuer.email=me@example.com \
  -n paas
```

## 相关文档

使用helm安装gitlab
<https://docs.gitlab.com/charts/quickstart/index.html#installing-kubectl>

FROM debian:9
ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update && \
       apt-get -y install sudo dialog apt-utils apt-transport-https ca-certificates curl
RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections

# RUN apt-get update && apt-get install --assume-yes apt-utils
RUN curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg
RUN echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | tee /etc/apt/sources.list.d/kubernetes.list
RUN curl https://baltocdn.com/helm/signing.asc | gpg --dearmor | tee /usr/share/keyrings/helm.gpg > /dev/null
RUN echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/helm.gpg] https://baltocdn.com/helm/stable/debian/ all main" | tee /etc/apt/sources.list.d/helm-stable-debian.list

RUN apt-get update
RUN apt-get -y --allow-unauthenticated install kubectl helm
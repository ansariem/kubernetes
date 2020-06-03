# install docker v18.09
# reason for not using docker provision is that it always installs latest version of the docker, but kubeadm requires 18.09 or older
apt-get update
apt-get install -y apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
add-apt-repository "deb https://download.docker.com/linux/$(. /etc/os-release; echo "$ID") $(lsb_release -cs) stable"
#apt-get update && apt-get install -y docker-ce-cli=$(apt-cache madison docker-ce-cli | grep 18.09 | head -1 | awk '{print $3}')
#apt-get update && apt-get install -y docker-ce-cli=$(apt-cache madison docker-ce-cli | grep 18.09 | head -1 | awk '{print $3}')
apt-get update && apt-get install -y docker-ce docker-ce-cli containerd.io
# run docker commands as vagrant user (sudo not required)
usermod -aG docker vagrant
# install kubeadm
apt-get install -y apt-transport-https curl
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
cat <<EOF >/etc/apt/sources.list.d/kubernetes.list
deb http://apt.kubernetes.io/ kubernetes-xenial main
EOF
apt-get update
apt-get install -y kubelet kubeadm kubectl
apt-mark hold kubelet kubeadm kubectl
sudo ex +"%s@DPkg@//DPkg" -cwq /etc/apt/apt.conf.d/70debconf
sudo dpkg-reconfigure debconf -f noninteractive -p critical
# kubelet requires swap off
swapoff -a
# keep swap off after reboot
sudo sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab
sudo systemctl restart kubelet
## Follow the remaining steps based below mentioned URL'#!/bin/sh
#Master cluster setup
#1. Run this command from Master (Master Node IP : 192.168.205.20)
#kubeadm init --apiserver-advertise-address=192.168.205.20 --pod-network-cidr=10.244.0.0/16
#2Natework setup for cluster install either weave net or calico network policy
#kubectl apply -f "https://cloud.weave.works/k8s/net?k8s-version=$(kubectl version | base64 | tr -d '\n')"
#https://docs.projectcalico.org/v3.9/getting-started/kubernetes/installation/calico
#1. curl https://docs.projectcalico.org/v3.9/manifests/calico.yaml -O
#2. kubectl apply -f calico.yaml
#Then Copy the kubadm init out put and run from nodes as root user.

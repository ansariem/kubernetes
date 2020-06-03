# kubernetes
Vagrant file to deploy the kubernetes one master and two worker node servers.

Once provisioning complete. follow the below steps.

#Master cluster setup
#1. Run this command from Master (Master Node IP : 192.168.205.20)
#kubeadm init --apiserver-advertise-address=<master node IP> --pod-network-cidr=10.244.0.0/16

#2Natework setup for cluster install either weave net or calico network policy

#kubectl apply -f "https://cloud.weave.works/k8s/net?k8s-version=$(kubectl version | base64 | tr -d '\n')"
OR
#https://docs.projectcalico.org/v3.9/getting-started/kubernetes/installation/calico
#1. curl https://docs.projectcalico.org/v3.9/manifests/calico.yaml -O
#2. kubectl apply -f calico.yaml
# copy the home directory step up command and run from normal user
#Then Copy the kubadm init out put joining keys and run from nodes as root user.

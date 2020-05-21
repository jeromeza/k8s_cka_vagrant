# CKA EXAM LABS

This is a lab enviroment, that is to be used in prep for taking the CNCF CKA (Certified Kubernetes Administrator) exam.

The environment mirrors the configuration needed, when following Sander van Vugt's CKA course found here:
https://learning.oreilly.com/videos/certified-kubernetes-administrator/9780136677482

-------------------------
Prerequisites needed:
-------------------------
Vagrant:  
https://www.vagrantup.com/intro/getting-started/index.html

Virtualbox:  
https://www.virtualbox.org/wiki/Downloads  
  
"Vagrant is a tool for building and managing virtual machine environments in a single workflow. With an easy-to-use workflow and focus on automation, Vagrant lowers development environment setup time, increases production parity, and makes the "works on my machine" excuse a relic of the past."

Essentially it's a platform that allows you to spin up VMs in a programmatic fashion. Repeatable, reusable and quick.

---

Virtualbox is a Hypervisor which allows you to run VMs on your host machine (in this case my laptop) - Vagrant will make use of Virtualbox to create and run your VMs, while Vagrant itself will manage VM config - things like networking, boot scripts and any additional config needed to deploy in an easy and automated fashion.

No more manual installations needed!  

-------------------------
Usage:
-------------------------
$ git clone https://github.com/jeromeza/k8s_cka_vagrant.git  
$ cd k8s_cka_vagrant/  
$ vagrant up    
$ vagrant ssh control   
$ vagrant ssh worker1  
$ vagrant ssh worker2  
$ vagrant ssh worker3  

-------------------------
Notes:
-------------------------
* Makes use of Sander's setup found here:
https://github.com/sandervanvugt/cka

* Particularly the below, which are referenced in the Vagrantfile as bootstrapped scripts, which will be run during the Vagrant creation process:

https://raw.githubusercontent.com/sandervanvugt/cka/master/setup-docker.sh
https://raw.githubusercontent.com/sandervanvugt/cka/master/setup-kubetools.sh

* Makes use of the following Centos 7 Vagrant image as the base OS:  
centos/7

* Due to how networking is configured in Vagrant, you will need to tell your master node to listen on the "control" node IP (192.168.4.110) vs the default Vagrant IP.

* This can be done via kubeadm when initializing the "control" master node:  
### $ sudo kubeadm init --apiserver-advertise-address=192.168.4.110

-------------------------
Example Cluster Setup:
-------------------------

### --- EXAMPLE VAGRANT ENVIRONMENT SETUP ---  
$ git clone https://github.com/jeromeza/k8s_cka_vagrant.git  
$ cd k8s_cka_vagrant/  
$ vagrant up  

### --- EXAMPLE CONTROL (MASTER) KUBERNETES NODE SETUP ---  
$ vagrant ssh control  
$ sudo kubeadm init --apiserver-advertise-address=192.168.4.110  
  
To start using your cluster, you need to run the following as a regular user:  
  
  mkdir -p $HOME/.kube  
  sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config  
  sudo chown $(id -u):$(id -g) $HOME/.kube/config  
  
Then you can join any number of worker nodes by running the following on each as root:  
  
kubeadm join 192.168.4.110:6443 --token btnom1.grmjn91si3j7w9kx \  
    --discovery-token-ca-cert-hash sha256:ffc9f54f15bfc0822ac694739e6a2f26413108414d77563b82be3479a7af66f2  
  
$ mkdir -p $HOME/.kube  
$ sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config  
$ sudo chown $(id -u):$(id -g) $HOME/.kube/config  
  
NOTE: We now no longer need to use 'root' for k8s tasks like kubectl on our CONTROL node, we can now use our 'vagrant' user  
  
### --- ENABLE NETWORKING ON CONTROL (MASTER) KUBERNETES NODE ---  
$ kubectl apply -f "https://cloud.weave.works/k8s/net?k8s-version=$(kubectl version | base64 | tr -d '\n')"  
$ exit  
  
### --- EXAMPLE WORKER KUBERNETES NODE SETUP ---  
$ vagrant ssh worker1  
$ sudo kubeadm join 192.168.4.110:6443 --token btnom1.grmjn91si3j7w9kx \  
    --discovery-token-ca-cert-hash sha256:ffc9f54f15bfc0822ac694739e6a2f26413108414d77563b82be3479a7af66f2  
  
$ vagrant ssh worker2  
$ sudo kubeadm join 192.168.4.110:6443 --token btnom1.grmjn91si3j7w9kx \  
    --discovery-token-ca-cert-hash sha256:ffc9f54f15bfc0822ac694739e6a2f26413108414d77563b82be3479a7af66f2  
  
$ vagrant ssh worker3  
$ sudo kubeadm join 192.168.4.110:6443 --token btnom1.grmjn91si3j7w9kx \  
    --discovery-token-ca-cert-hash sha256:ffc9f54f15bfc0822ac694739e6a2f26413108414d77563b82be3479a7af66f2  

This node has joined the cluster:  
* Certificate signing request was sent to apiserver and a response was received.  
* The Kubelet was informed of the new secure connection details.  
  
Run 'kubectl get nodes' on the control-plane to see this node join the cluster.  
  
### --- TEST NODES FROM MASTER - ALL IS WORKING ---  
$ kubectl get nodes  
NAME                  STATUS   ROLES    AGE    VERSION  
control.example.com   Ready    master   4m6s   v1.18.2  
worker1.example.com   Ready    <none>   112s   v1.18.2  
worker2.example.com   Ready    <none>   82s    v1.18.2  
worker3.example.com   Ready    <none>   72s    v1.18.2  

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

* Vagrant creates 2x network interfaces:  
(eth0) for it's default network. 
(eth1) for this labs network (192.168.4.110 - 113)

* As such you will need to specify this on your 'control' node, aka your Kubernetes master node - when creating your master, as this will ensure it binds to the correct ip address:
### kubeadm init --api-advertise-addresses=192.168.4.110


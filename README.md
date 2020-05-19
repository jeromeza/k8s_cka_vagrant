# CKA EXAM LABS

This is a lab enviroment, that is to be used in prep for taking the CNCF CKA (Certified Kubernetes Administrator) exam.

The environment mirrors the configuration needed, when following Sander van Vugt's CKA course found here:
https://learning.oreilly.com/videos/certified-kubernetes-administrator/9780136677482

-------------------------
Prerequisites needed:
-------------------------
Vagrant:  
https://www.vagrantup.com/intro/getting-started/index.html

-------------------------
Usage:
-------------------------
$ git clone https://github.com/jeromeza/k8s_cka_vagrant.git  
$ cd k8s_centos   
$ vagrant up    
$ vagrant ssh control   
$ vagrant ssh worker1  
$ vagrant ssh worker2  
$ vagrant ssh worker3  

-------------------------
Notes:
-------------------------
Makes use of Sander's setup found here:
https://github.com/sandervanvugt/cka

Particularly the below, which are referenced in the Vagrantfile as bootstrapped scripts, which will be run during the Vagrant creation process:

https://raw.githubusercontent.com/sandervanvugt/cka/master/setup-docker.sh
https://raw.githubusercontent.com/sandervanvugt/cka/master/setup-kubetools.sh


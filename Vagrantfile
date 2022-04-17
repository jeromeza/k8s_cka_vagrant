# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|

  # Kubernetes Master Server
  config.vm.define "control" do |control|
    control.vm.box = "centos/7"
    control.vm.hostname = "control.example.com"
    control.vm.network "private_network", ip: "192.168.56.110"
    control.vm.provider "virtualbox" do |v|
      v.name = "control"
      v.memory = 4096
      v.cpus = 2
    end
    control.vm.provision "shell", path: "prereqs.sh"
    control.vm.provision "shell", path: "https://raw.githubusercontent.com/gwynforthewyn/cka/master/setup-container.sh"
    control.vm.provision "shell", path: "https://raw.githubusercontent.com/gwynforthewyn/cka/master/setup-kubetools.sh"
    control.vm.provision "shell", inline: "swapoff -a"
    control.vm.provision "shell", inline: "echo 192.168.56.111 worker1.example.com >> /etc/hosts"
    control.vm.provision "shell", inline: "echo 192.168.56.112 worker2.example.com >> /etc/hosts"
    control.vm.provision "shell", inline: "echo 192.168.56.113 worker3.example.com >> /etc/hosts"
    control.vm.provision "shell", inline: "echo 192.168.56.110 control.example.com >> /etc/hosts"
    control.vm.provision "shell", inline: "kubeadm init --apiserver-advertise-address 192.168.56.110"
    control.vm.provision "shell", inline: "mkdir /home/vagrant/.kube && cp /etc/kubernetes/admin.conf /home/vagrant/.kube/config && chown -R vagrant:vagrant /home/vagrant/.kube"
#    control.vm.provision "shell", inline: "sudo -u vagrant \"sh -c \'kubectl apply -f \"https://cloud.weave.works/k8s/net?k8s-version=$(kubectl version | base64 | tr -d '\n')&env.WEAVE_MTU=1337\" \'\""
  end

  NodeCount = 3

  # Kubernetes Worker Nodes
  (1..NodeCount).each do |i|
    config.vm.define "worker#{i}" do |workernode|
      workernode.vm.box = "centos/7"
      workernode.vm.hostname = "worker#{i}.example.com"
      workernode.vm.network "private_network", ip: "192.168.56.11#{i}"
      workernode.vm.provider "virtualbox" do |v|
        v.name = "worker#{i}"
        v.memory = 4096
        v.cpus = 1
      end
      workernode.vm.provision "shell", path: "prereqs.sh"
      workernode.vm.provision "shell", inline: "echo 192.168.56.111 worker1.example.com >> /etc/hosts"
      workernode.vm.provision "shell", inline: "echo 192.168.56.112 worker2.example.com >> /etc/hosts"
      workernode.vm.provision "shell", inline: "echo 192.168.56.113 worker3.example.com >> /etc/hosts"
      workernode.vm.provision "shell", inline: "echo 192.168.56.110 control.example.com >> /etc/hosts"
      workernode.vm.provision "shell", path: "https://raw.githubusercontent.com/gwynforthewyn/cka/master/setup-container.sh"
      workernode.vm.provision "shell", path: "https://raw.githubusercontent.com/gwynforthewyn/cka/master/setup-kubetools.sh"
      workernode.vm.provision "shell", inline: "swapoff -a"
    end
  end

end

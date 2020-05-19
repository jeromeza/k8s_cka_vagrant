# -*- mode: ruby -*-
# vi: set ft=ruby :

ENV['VAGRANT_NO_PARALLEL'] = 'yes'

Vagrant.configure(2) do |config|

  # Kubernetes Master Server
  config.vm.define "control" do |control|
    control.vm.box = "centos/7"
    control.vm.hostname = "control.example.com"
    control.vm.network "private_network", ip: "192.168.4.110"
    control.vm.provider "virtualbox" do |v|
      v.name = "control"
      v.memory = 2048
      v.cpus = 2
    end
    control.vm.provision "shell", path: "prereqs.sh"
    control.vm.provision "shell", path: "https://raw.githubusercontent.com/sandervanvugt/cka/master/setup-docker.sh"
    control.vm.provision "shell", path: "https://raw.githubusercontent.com/sandervanvugt/cka/master/setup-kubetools.sh"
  end

  NodeCount = 3

  # Kubernetes Worker Nodes
  (1..NodeCount).each do |i|
    config.vm.define "worker#{i}" do |workernode|
      workernode.vm.box = "centos/7"
      workernode.vm.hostname = "worker#{i}.example.com"
      workernode.vm.network "private_network", ip: "192.168.4.11#{i}"
      workernode.vm.provider "virtualbox" do |v|
        v.name = "worker#{i}"
        v.memory = 1024
        v.cpus = 1
      end
      workernode.vm.provision "shell", path: "prereqs.sh"
      workernode.vm.provision "shell", path: "https://raw.githubusercontent.com/sandervanvugt/cka/master/setup-docker.sh"
      workernode.vm.provision "shell", path: "https://raw.githubusercontent.com/sandervanvugt/cka/master/setup-kubetools.sh"
    end
  end

end

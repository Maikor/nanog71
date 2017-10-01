# -*- mode: ruby -*-
# vi: set ft=ruby :


Vagrant.configure(2) do |config|


  config.vm.define "linux_box_1" do |linux_box_1|
    linux_box_1.vm.box = "ciscoxr/ubuntu-xenial-docker"
    linux_box_1.vm.network :private_network, virtualbox__intnet: "link1", ip: "10.1.1.10"
    linux_box_1.vm.provision :shell, path: "scripts/install_quagga_1.sh", privileged: false
  end

  config.vm.define "linux_box_2" do |linux_box_2|
    linux_box_2.vm.box = "ciscoxr/ubuntu-xenial-docker"
    linux_box_2.vm.network :private_network, virtualbox__intnet: "link2", ip: "10.1.2.10"
    linux_box_2.vm.provision :shell, path: "scripts/install_quagga_2.sh", privileged: false
  end

  config.vm.define "controller" do |controller|
    controller.vm.box = "ciscoxr/ubuntu-xenial-docker"
    controller.vm.network :private_network, virtualbox__intnet: "link3", ip: "10.1.3.10"
    #controller.vm.provision :shell, path: "controller.sh", privileged: false
  end

  config.vm.define "rtr" do |rtr|
    rtr.vm.box = "IOS-XRv"
    rtr.vm.network :private_network, auto_config: false, virtualbox__intnet: "link1", ip: "10.1.1.20"
    rtr.vm.network :private_network, auto_config: false, virtualbox__intnet: "link2", ip: "10.1.2.20"
    rtr.vm.network :private_network, auto_config: false, virtualbox__intnet: "link3", ip: "10.1.3.20"

    rtr.vm.provision "transfer_config", type: "file", source: "configs/rtr_config", destination: "/home/vagrant/rtr_config"
      

    rtr.vm.provision "apply_config", type: "shell" do |s|
        s.path =  "scripts/apply_config.sh"
        s.args = ["/home/vagrant/rtr_config"]
    end
    
    config.vm.provider "virtualbox" do |v|
        v.memory = 5024
    end

  end
end

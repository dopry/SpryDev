# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # Vagrant and Vagrant Plugin configuration.
  config.hostmanager.enabled = true
  config.hostmanager.manage_host = true
  config.hostmanager.ignore_private_ip = false
  config.hostmanager.include_offline = true

  config.ssh.forward_agent = true

  # Common provider configuration
  config.vm.provider "virtualbox" do |vb|
     vb.customize ["modifyvm", :id, "--memory", "1024"]
     vb.customize ["modifyvm", :id, "--natdnsproxy1", "off"]
     vb.customize ["modifyvm", :id, "--natdnshostresolver1", "off"]
  end

  # Common vm configuration
  config.vm.box = "ubuntu/trusty64"

  # VM specific configurations
  config.vm.define "dev" do |dev|
    # forward gulp hosted client from vagrant to host.
    dev.vm.hostname = "spry.dev"
    dev.hostmanager.aliases = %w(spry.dev)
    dev.vm.network "private_network", ip: "192.168.34.10"
    # mount vboxsf as 777 on all hosts to match windows.
    dev.vm.synced_folder "./", "/vagrant", mount_options: ["dmode=777,fmode=777"]
    dev.vm.provision "shell", path: "vagrant/provision.sh"
  end
end
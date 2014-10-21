# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do | config|

  config.vm.define "mlh" do |mlh_config|
    mlh_config.vm.box = "chef/centos-6.5"
	mlh_config.vm.synced_folder "../projects", "/var/www/html"
	mlh_config.vm.synced_folder "../data", "/var/www/data"
	#mlh_config.vm.synced_folder "../ecommerce/cron", "/home/mylandho/public_html"
	mlh_config.vm.network "private_network", ip: "192.168.33.10"
    mlh_config.vm.network "public_network"
    mlh_config.vm.provision :shell, :path => "bootstrap.sh"
    mlh_config.vm.provision "puppet" do |puppet|
      puppet.module_path = "puppet/modules"
      puppet.manifests_path = "puppet/manifests"
      puppet.manifest_file = "mlh.pp"
    end
    mlh_config.vm.provider :virtualbox do |vb|
      vb.customize ["modifyvm", :id, "--memory", "512", "--name", "MLH"]
    end
  end
 
 
end

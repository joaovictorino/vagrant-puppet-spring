Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/bionic64"

  config.vm.provider "virtualbox" do |vb|
    vb.memory = 1024
    vb.cpus = 1
  end

  config.vm.define "mysqlserver" do |mysqlserver|
    mysqlserver.vm.network "private_network", ip: "10.80.4.10"

    mysqlserver.vm.provider "virtualbox" do |vb|
      vb.name = "mysqlserver_pp"
    end

    mysqlserver.vm.provision "shell", inline: "apt-get update && apt-get install -y puppet"
    mysqlserver.vm.provision "shell", inline: "mkdir -p /etc/puppet/modules && puppet module install puppetlabs/mysql"

    mysqlserver.vm.provision "puppet" do |puppet|
      puppet.manifests_path = "./mysql"
      puppet.manifest_file = "mysql_plugin.pp"
    end
  end

  config.vm.define "springapp" do |springapp|
    springapp.vm.network "forwarded_port", guest: 8080, host: 8080
    springapp.vm.network "private_network", ip: "10.80.4.11"

    springapp.vm.provider "virtualbox" do |vb|
      vb.name = "springapp_pp"
      vb.memory = 4096
      vb.cpus = 2
    end

    springapp.vm.provision "shell", inline: "apt-get update && apt-get install -y puppet"

    springapp.vm.provision "puppet" do |puppet|
      puppet.manifests_path = "./springapp"
      puppet.manifest_file = "springapp.pp"
    end
  end
end

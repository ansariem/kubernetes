# -*- mode: ruby -*-
# vi: set ft=ruby :

servers = [
    {
        :name => "master-u",
        :type => "master",
        :box => "bento/ubuntu-18.04",
        :box_version => "201906.18.0",
        :eth1 => "192.168.205.9",
        :mem => "1024",
        :cpu => "2"
    },
    {
        :name => "node-01",
        :type => "node",
        :box => "bento/ubuntu-18.04",
        :box_version => "201906.18.0",
        :eth1 => "192.168.205.11",
        :mem => "1024",
        :cpu => "2"
    },
    {
        :name => "node-02",
        :type => "node",
        :box => "bento/ubuntu-18.04",
        :box_version => "201906.18.0",
        :eth1 => "192.168.205.12",
        :mem => "1024",
        :cpu => "2"
    }
]


Vagrant.configure("2") do |config|

    servers.each do |opts|
        config.vm.define opts[:name] do |config|

            config.vm.box = opts[:box]
            config.vm.box_version = opts[:box_version]
            config.vm.hostname = opts[:name]
            config.vm.network :private_network, ip: opts[:eth1]

            config.vm.provider "virtualbox" do |v|

                v.name = opts[:name]
            	 v.customize ["modifyvm", :id, "--groups", "/k8s"]
                v.customize ["modifyvm", :id, "--memory", opts[:mem]]
                v.customize ["modifyvm", :id, "--cpus", opts[:cpu]]

            end

            # we cannot use this because we can't install the docker version we want - https://github.com/hashicorp/vagrant/issues/4871
            #config.vm.provision "docker"

          #  config.vm.provision "shell", inline: $configureBox

          #  if opts[:type] == "master"
          #      config.vm.provision "shell", inline: $configureMaster
          #  else
            #    config.vm.provision "shell", inline: $configureNode
            config.vm.provision "shell", path: "bootstrap.sh"
            #end

        end

    end

end

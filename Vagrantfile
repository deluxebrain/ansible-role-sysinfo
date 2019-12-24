# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANT_API_VERSION = "2"

Vagrant.configure(VAGRANT_API_VERSION) do |config|
    config.vm.box = "ubuntu/disco64"
    config.vm.hostname = "ansible-role-sysinfo"
   
    config.vm.provision "ansible" do |ansible|
        ansible_verbose = true
        ansible.playbook = "playbook.yml"
    end
   
    config.vm.provider "virtualbox" do |vbox, override|
        vbox.name = config.vm.hostname   # vbox ui title
        vbox.gui = false
        vbox.memory = 1024
        vbox.cpus = 1

        # Override Virtualbox time drift threshold ( 20 minutes ) to 1s
        vbox.customize [ "guestproperty", "set", :id, "--timesync-threshold", 1000 ]

        if Vagrant.has_plugin?("vagrant-vbguest")
            config.vbguest.auto_update = false
        end
    end
end


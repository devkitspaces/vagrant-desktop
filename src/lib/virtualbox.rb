#!/usr/bin/ruby

# ---------------------------------------
# Vagrant Configuration functions
# ---------------------------------------

def vm_info(config, name)
    config.vm.box = "bento/ubuntu-16.04"
    config.vm.hostname = name
    config.ssh.forward_agent = true  
  end

def vm_synced_folders(config)
    config.vm.synced_folder "../", "/opt/vagrant"
    config.vm.synced_folder "../../../", "/home/vagrant/repositories"
end

def vm_provider(config)
    vb.gui = true

    vb.name = settings['name']

    vb.customize ["modifyvm", :id, "--cpus", "2"]
    vb.customize ["modifyvm", :id, "--memory", "2048"]
    vb.customize ["modifyvm", :id, "--graphicscontroller", "vboxvga"]
    vb.customize ["modifyvm", :id, "--vram", "128"]

    vb.customize ["modifyvm", :id, "--hwvirtex", "on"]
    vb.customize ["modifyvm", :id, "--accelerate3d", "on"]
    vb.customize ["modifyvm", :id, "--ioapic", "on"]
end

def vm_provision(node, node_details)
    config.vm.provision :shell, :path => File.join( "provision", "bootstrap.sh" )
end
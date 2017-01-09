# -*- mode: ruby -*-
# vi: set ft=ruby :
require 'getoptlong'
require 'yaml'

Vagrant.require_version ">= 1.6.0"
VAGRANTFILE_API_VERSION = "2"

## Default variables
dir = Dir.pwd
vagrant_dir = File.expand_path(File.dirname(__FILE__))

SETTINGS_FILE = File.join(vagrant_dir, 'settings.yaml')

# Options
#
# Options for vagrant 

opts = GetoptLong.new(
  # Native vagrant options
     [ '--force', '-f', GetoptLong::NO_ARGUMENT ],
     [ '--provision', '-p', GetoptLong::NO_ARGUMENT ],
     [ '--provision-with', GetoptLong::NO_ARGUMENT ],
     [ '--provider', GetoptLong::OPTIONAL_ARGUMENT ],
     [ '--help', '-h', GetoptLong::NO_ARGUMENT ],
     [ '--check', GetoptLong::NO_ARGUMENT ],
     [ '--logout', GetoptLong::NO_ARGUMENT ],
     [ '--token', GetoptLong::NO_ARGUMENT ],
     [ '--disable-http', GetoptLong::NO_ARGUMENT ],
     [ '--http', GetoptLong::NO_ARGUMENT ],
     [ '--https', GetoptLong::NO_ARGUMENT ],
     [ '--ssh-no-password', GetoptLong::NO_ARGUMENT ],
     [ '--ssh', GetoptLong::NO_ARGUMENT ],
     [ '--ssh-port', GetoptLong::NO_ARGUMENT ],
     [ '--ssh-once', GetoptLong::NO_ARGUMENT ],
     [ '--host', GetoptLong::NO_ARGUMENT ],
     [ '--entry-point', GetoptLong::NO_ARGUMENT ],
     [ '--plugin-source', GetoptLong::NO_ARGUMENT ],
     [ '--plugin-version', GetoptLong::NO_ARGUMENT ],
     [ '--debug', GetoptLong::NO_ARGUMENT ],

    # Custom options
     [ '--name', GetoptLong::REQUIRED_ARGUMENT ],
     [ '--desktop', GetoptLong::OPTIONAL_ARGUMENT ],
     [ '--type', GetoptLong::OPTIONAL_ARGUMENT ]
)

# Vagrant Options
#
# The options and variables used in the vagrant <options> up call.

settings = {}
if File.file?(SETTINGS_FILE)
  settings = YAML.load_file(SETTINGS_FILE)
end

opts.each do |opt, arg|
  case opt
    when '--name'
      settings['VM_NAME'] =arg.gsub(/[^[:print:]]/i, '')
    when '--desktop'
      settings['VM_DESKTOP']=arg
    when '--type'
      settings['VM_TYPE']=arg
  end
end

settings['VM_NAME'] = settings['VM_NAME'] || 'vagrant-desktop'
settings['VM_DESKTOP']  = settings['VM_DESKTOP'] || 'ubuntu'
settings['VM_TYPE'] = settings['VM_TYPE'] || 'minimal'

# Write to configuration file
File.open(SETTINGS_FILE, 'w') { |f| YAML.dump(settings, f) }

# Vagrant Definition
#
# The definition of the vagrant environment

# Vagrantfile API/
Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.env.enable

  # Configuration
  #
  # Configuration options for the Vagrant environment.
  config.vm.box = "bento/ubuntu-16.04"
  config.vm.hostname = settings['VM_NAME']
  config.ssh.forward_agent = true
  config.vm.synced_folder "../", "/local", :mount_options => ["dmode=777", "fmode=666"]

  # Virtualbox configuration
  #
  # The configuration for the Virtualbox provider.
  config.vm.provider :virtualbox do |vb|
    vb.gui = true

    vb.name = settings['VM_NAME']
    vb.memory = "2048"
    vb.customize ["modifyvm", :id, "--vram", "32"]
  end
  
  # Provisioning
  #
  # Process provisioning scripts depending on the existence of custom files.
  config.vm.provision "shell", inline: "echo #{settings['VM_NAME']} is #{settings['VM_DESKTOP']} environment with [recommends=#{settings['VM_TYPE']}]"
  
  # provison-pre.sh
  #
  # provison-pre.sh acts as a pre-hook to the default provisioning script. Anything that
  # should run before the shell commands laid out in provision.sh should go in this script. 
  if File.exists?(File.join(vagrant_dir,'provision','provision-pre.sh')) then
    config.vm.provision :shell, :path => File.join( "provision", "provision-pre.sh" )
  end

  config.vm.provision :shell, :path => File.join( "provision", "prepare.sh" )

  # environments
  #
  # The environments directories provide provisioning scripts for supported desktop environments.
  # Each script is passed arguments relevant to the desktop provisioning.  The scripts also make use
  # of environment variables initialized with arguments passed to vagrant.
  case settings['VM_DESKTOP']
      when 'ubuntu'
          config.vm.provision :shell, :path => File.join( "provision", "environments", "ubuntu.sh" ), :args => "'#{settings['VM_TYPE']}'"
      when 'lubuntu'
          config.vm.provision :shell, :path => File.join( "provision", "environments", "lubuntu.sh" ), :args => "'#{settings['VM_TYPE']}'"
  else
      puts "#{settings['VM_DESKTOP']} not yet defined"
  end

  # provision.sh or provision-custom.sh
  #
  # By default, our Vagrantfile is set to use the provision.sh bash script located in the
  # provision directory. The provision.sh bash script provisions the development environment.
  # If it is detected that a provision-custom.sh script has been created, it is run as a replacement. 
  if File.exists?(File.join(vagrant_dir,'provision','provision.sh')) then
    config.vm.provision :shell, :path => File.join( "provision", "provision.sh" )
  end

  # provision-post.sh
  #
  # provision-post.sh acts as a post-hook to the provisioning. Anything that should
  # run after the shell commands laid out in  provisioning should be put into this file.
  if File.exists?(File.join(vagrant_dir,'provision','provision-post.sh')) then
    config.vm.provision :shell, :path => File.join( "provision", "provision-post.sh" )
  end

  # Reboot after installation
  config.vm.provision :shell, inline: "reboot"
  config.vm.provision "shell", inline: "echo #{settings['VM_NAME']} is #{settings['VM_DESKTOP']} environment with [recommends=#{settings['VM_TYPE']}]"
end
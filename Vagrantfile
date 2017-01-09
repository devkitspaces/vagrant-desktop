# -*- mode: ruby -*-
# vi: set ft=ruby :
require 'getoptlong'

## Default variables
dir = Dir.pwd
vagrant_dir = File.expand_path(File.dirname(__FILE__))

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

name='vagrant-desktop'
desktop="ubuntu"
type='minimal'
opts.each do |opt, arg|
  case opt
    when '--name'
      name=arg.gsub(/[^[:print:]]/i, '')
    when '--desktop'
      desktop=arg
    when '--type'
      type=arg
  end
end

# Vagrantfile API/syntax version.
VAGRANTFILE_API_VERSION = "2"
Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  # Configuration
  #
  # Configuration options for the Vagrant environment.
  config.vm.box = "bento/ubuntu-16.04"
  config.vm.hostname = "#{name}"
  config.ssh.forward_agent = true

  # Virtualbox configuration
  #
  # The configuration for the Virtualbox provider.
  config.vm.provider :virtualbox do |vb|
    vb.gui = true

    vb.name = "#{name}"
    vb.memory = "2048"
  end
  
  # Provisioning
  #
  # Process provisioning scripts depending on the existence of custom files.
  puts "#{name} is #{desktop} environment (recommends=#{type})"
  
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
  case desktop
      when 'ubuntu'
          config.vm.provision :shell, :path => File.join( "provision", "environments", "ubuntu.sh" ), :args => "'#{type}'"
      when 'lubuntu'
          config.vm.provision :shell, :path => File.join( "provision", "environments", "lubuntu.sh" ), :args => "'#{type}'"
  else
      puts "#{desktop} not yet defined"
  end

  # Reboot after installation
  config.vm.provision :shell, inline: "reboot"

  # provision.sh or provision-custom.sh
  #
  # By default, our Vagrantfile is set to use the provision.sh bash script located in the
  # provision directory. The provision.sh bash script provisions the desktop environment.
  # If it is detected that a provision-custom.sh script has been created, it is run as a replacement. 
  if File.exists?(File.join(vagrant_dir,'provision','provision.sh')) then
    config.vm.provision :shell, :path => File.join( "provision", "provision.sh" )
  end

  # provision-post.sh
  #
  # provision-post.sh acts as a post-hook to the desktop environment provisioning. Anything that should
  # run after the shell commands laid out in provision.sh or provision-custom.sh should be
  # put into this file. This provides the method to install packages related to development.
  if File.exists?(File.join(vagrant_dir,'provision','provision-post.sh')) then
    config.vm.provision :shell, :path => File.join( "provision", "provision-post.sh" )
  end
end
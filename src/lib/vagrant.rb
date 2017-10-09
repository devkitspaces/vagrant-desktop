#!/usr/bin/ruby
require 'stringio'

# ---------------------------------------
# Vagrant Functions
# ---------------------------------------

##
# Copies the script to the virtual machine and executes it with the specified arguments.
# Params:
# +config+:: The vagrant configuration
# +message+:: The message to output to the command
# +filepath+:: The path to the script
# +args+:: The arguments to pass to the script
#
def vagrant_copy_run(config, message, filepath, args)
    filename = File.basename(filepath)
    copy_path = "/tmp/#{filename}"

    config.vm.provision :file do |file|
        file.source = "#{filepath}"
        file.destination = copy_path
    end

    config.vm.provision :shell do |sh|
        sh.path = File.join( "provision", "entrypoint.bash" )
        sh.args = "'#{message}' '#{copy_path}' #{args}"
        sh.env = { }
    end
end

# ---------------------------------------
# Vagrant Configuration functions
# ---------------------------------------

##
# Sets a series of synced folder based on the settings file
# Params:
# +config+:: The vagrant configuration
# +settings+:: The settings object
#
def vm_synced_folders(config, settings)
    synced_folders = settings['synced_folders']
    synced_folders && synced_folders.each do |synced_folder|
        config.vm.synced_folder synced_folder['host'], synced_folder['guest']
    end
end

##
# Sets a series of scripts to run.
# Params:
# +config+:: The vagrant configuration
# +settings+:: A list of scripts
#
def vm_run_scripts(config, scripts)
    scripts && synced_folders.each do |script|
        config.vm.provision :shell do |sh|
            sh.path = synced_folder['path']
            sh.env = { }
        end
    end
end

##
# Sets a series of environment variables based on the settings file
# Params:
# +config+:: The vagrant configuration
# +settings+:: The settings object
#
def vm_variables(config, settings)
    profile = StringIO.new
    profile.puts "echo '#!/bin/bash' > /etc/profile.d/vagrant.sh"

    variables = settings['variables']
    variables && variables.each do |var|
        profile.puts "echo \"export #{var['name']}='#{var['value']}'\" >> /etc/profile.d/vagrant.sh"
    end

    log_dir = settings['logs']
    logfile = "provision-#{Time.now.strftime('%Y-%m-%d_%H-%M-%S')}.log"  
    FileUtils.mkdir_p(log_dir) unless File.directory?(log_dir)

    log_path = File.join(log_dir, logfile)
    profile.puts "echo \"export VAGRANT_LOG='/opt/vagrant/#{log_path}'\" >> /etc/profile.d/vagrant.sh"

    profile.puts "chmod +x /etc/profile.d/vagrant.sh"
    
    result = profile.string
    config.vm.provision "shell", inline: result
end

##
# Gets the current vagrant dotfile path
# Params:
# +name+:: The name of the vagrant box
# +file+:: The path to the settings file
# +dotfile_path+:: The path to the vagrant dotfile
#
# Returns: 
# A filepath to the vagrant dotfile
def vm_run_with_dot(name, file, dotfile_path)
    if(ENV['VAGRANT_DOTFILE_PATH'].nil? && '.vagrant' != dotfile_path)
        ENV['VAGRANT_DOTFILE_PATH'] = dotfile_path
        FileUtils.rm_r('.vagrant')
    
        system "vagrant --name=#{name} --file=#{file} " + ARGV.join(' ')
        ENV['VAGRANT_DOTFILE_PATH'] = nil
        exit 1
    end
end
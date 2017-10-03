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
# The method provides a set of environment variables to the script.
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

def vm_get_dot_path(variables)
    dotpath = variables['VAGRANT_DOTFILE_PATH'];
    if(dotpath.nil?)
        dotpath = '.vagrant';
    end
    return dotpath
end

def vm_ensure_dot_path(dotfile_path, curpath)
    if(dotfile_path.nil?)
        dotfile_path = '.vagrant';
    end

    if(dotfile_path != curpath)        
        return dotfile_path
    end

    return curpath
end
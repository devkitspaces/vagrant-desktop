#!/usr/bin/ruby
require 'getoptlong'

# ---------------------------------------
# Vagrant Functions
# ---------------------------------------

def vagrant_copy_run(config, script, args)
    copy_path = "/tmp/#{script}"

    config.vm.provision :file do |file|
        file.source = File.join( "provision", "#{script}" )
        file.destination = copy_path
    end

    config.vm.provision :shell do |sh|
        sh.path = File.join( "provision", "entrypoint.bash" )
        sh.args = "'#{script}' '#{copy_path}' #{args}"
        sh.env = { :VAGRANT_LOG => "#{VAGRANTFILE_LOG_PATH}" }
    end
end


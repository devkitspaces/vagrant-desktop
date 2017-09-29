#!/usr/bin/ruby
require 'getoptlong'

# ---------------------------------------
# Vagrant Functions
# ---------------------------------------

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
        sh.env = { :VAGRANT_LOG => "#{VAGRANTFILE_LOG_PATH}" }
    end
end


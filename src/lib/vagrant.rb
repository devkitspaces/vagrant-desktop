#!/usr/bin/ruby

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
        sh.env = { :VAGRANT_LOG => "#{VAGRANTFILE_LOG_PATH}" }
    end
end


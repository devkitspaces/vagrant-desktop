#!/usr/bin/ruby
require 'getoptlong'

# ---------------------------------------
# Utility Functions
# ---------------------------------------

##
# Print the required usage of vagrant
#
def print_usage()
    puts 'vagrant [options] <command>'
    puts
    puts 'Options:'
    puts ' --name      The name assigned to the virtual machine.'
    puts ' --file      The definition file for the virtual machine.'
end

# ---------------------------------------
# Option Functions
# ---------------------------------------

##
# Parses the command line options into a dictionary
#
# Returns: 
# A dictionary of parameters
def parse_options()
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

        # Vagrant desktop options
        [ "--name", GetoptLong::REQUIRED_ARGUMENT ],
        [ "--file", GetoptLong::REQUIRED_ARGUMENT ]
    )

    params = {}
    opts.each do |opt, arg|
        case opt
          when '--file'
            params['file']=arg
          when '--name'
            params['name']=arg
        end
    end

    return params
end

##
# Requires a command line option to be set to a value, otherwise abort
# Params:
# +name+:: The name of the command line option
# +value+:: The value of the command line option
#
# The application will terminate if the argument is null or empty
#
def require_arg(name, value)
    if value.nil? || value.empty?
        arg=name
        puts "Missing argument: The '--#{name}' argument is required."
        puts 
        print_usage()
        exit
    end
end
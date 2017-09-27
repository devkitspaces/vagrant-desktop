#!/usr/bin/ruby
require 'yaml'

# ---------------------------------------
# Option Functions
# ---------------------------------------

def read_settings(file) 
    settings = {}
    
    if !File.file?(file)
        puts "open #{file}: The system cannot find the file specified."
        puts "  path: #{file}"
        exit
    end

    settings = YAML.load_file(file)

    return settings;
end 
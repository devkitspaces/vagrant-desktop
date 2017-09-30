#!/usr/bin/ruby
require 'yaml'

# ---------------------------------------
# Settings Functions
# ---------------------------------------

##
# Reads the settings file from the specified path
# Params:
# +file+:: The path to the settings file
#
# The application will terminate if the file cannot be found
#
# Returns:
# A dictionary of settings
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

##
# Validates the settings file for required properties
# Params:
# +settings+:: The settings object
#
# The application will terminate if any required property is missing
#
def validate_settings(settings)
    err=false

    err = !has_property(settings, 'name') \
        | !has_property(settings, 'box') \
        | !has_property(settings, 'path') \
        | !has_property(settings, 'desktop') \
        | !has_property(settings, 'synced_folders') \
        | !has_property(settings, 'logs')

    if ! File.exists?(File.join('env',"#{settings['desktop']}.bash")) then
        puts "The environment '#{settings['desktop']}' could not be found."
        err = true
    end

    if err
        puts "The settings file has errors. Please fix and try to provision again."
        exit
    end
end

##
# Verifies that the dictionary contains the specified property
# Params:
# +settings+:: The settings object
# +property+:: The name of the property
#
# The function will output a message if the property is missing
#
# Returns:
# True if the key exists, false otherwise
def has_property(settings, property)
    if settings["#{property}"].nil? || settings["#{property}"].empty?
        puts "The property '#{property}' is missing from the settings file."
        return false
    end
    return true
end
# Vagrant Linux Desktop
[![License][license-badge]][license-link]

---

## Summary

Provide a method of reproducible graphical development environments based on Linux.  This repositroy provides a base Linux Desktop environment, sandboxed on their local computer.  

## Usage

You can use this locally with `vagrant up`, calling as such:

```
vagrant --name=mydesktop --desktop=lubuntu up
```

It is recommended to use the script `start.sh` to ensure all arguments are provided in their proper form.  You can do so by calling:

```
./start.sh -n mydesktop -d lubuntu
```

If you want more information about the script `start.sh`, you can do so by calling:

```
./start.sh -h
```

## Parameters

The parameters are used in the calling of `vagrant up`, primarily as `vagrant <options> up`.  After provisioning the environment, a settings file (`setting.yaml`) is created, which the provided parameters.

| Name | Type | Description |
| ---  | ---  | ---         |
| name | string | Name of the provisioned desktop environment |
| desktop | filename | The name of the desktop provisioning script.  These scripts are present in `provision/environments`. |

It is based on `bento/ubuntu` images.  If the timezone is not set, the provision script will attempt to auto-detect the timezone using the [`tzupdate`](https://github.com/cdown/tzupdate).

## Dependencies 

The following are the dependencies of the vagrant project

* `getoptlong` - The [GetoptLong](http://ruby-doc.org/stdlib-2.1.0/libdoc/getoptlong/rdoc/GetoptLong.html) class allows you to parse command line options similarly to the GNU getopt_long() C library call.
* `yaml` - The [YAML](https://ruby-doc.org/stdlib-1.9.3/libdoc/yaml/rdoc/YAML.html) module provides a Ruby interface for data serialization in YAML format.

## Setting up the application 

On first run (`vagrant up`) the base `bento/ubuntu` image will be downloaded, and the environments will be created.  

[license-badge]: https://img.shields.io/badge/license-MIT-blue.svg?maxAge=2592000
[license-link]: LICENSE
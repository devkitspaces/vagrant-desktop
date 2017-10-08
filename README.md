# Vagrant Linux Desktop

## Summary

Provide a method of reproducible graphical development environments based on Linux.  This repository provides a base Linux Desktop environment, sandboxed on your local computer.  

### Usage

You can use this locally with `vagrant up`, calling as such:

```
vagrant --name=mydesktop up
```

However It is recommended to use the script `create.sh` for the first run to ensure all necessary arguments are provided. The provided arguments creates a `settings.yaml`, storing the settings for the machine.  You can create the machine by calling:

```
sh create.sh -n mydesktop -d ubuntu
```

If you want more information about the script `create.sh`, you can do so by calling:

```
sh create.sh -h
```

### Parameters

The parameters are used in the calling of `vagrant up`, primarily as `vagrant [OPTIONS] up`.  After provisioning the environment, a settings file (`setting.yaml`) is created, which stores the provided parameters.

| Name | Type | Description |
| ---  | ---  | ---         |
| name | `string` | Name of the provisioned desktop environment |
| desktop | `filename` | The name of the desktop provisioning script.  These scripts are present in [`packaging/environments`](src/packaging/environments). |

The vagrant environment is based on the `bento/ubuntu` images.  If the timezone is not set, the provision script will attempt to auto-detect the timezone using [`tzupdate`](https://github.com/cdown/tzupdate).

## Components

On first run (`create.sh ...`) the base `bento/ubuntu` image will be downloaded, and the packages for a graphical interface will be downloaded. This will take a significant amount of time to fully setup to become fully installed.  The default user is `vagrant` with password `vagrant`.

### Architecture

The `vagrant-desktop` is meant to be included as a git submodule as part of a `.Workspace` project.  The following is the architecture of a `.Workspace` meta-project:

```
* .Workspace Repository
    * bin
    * lib
    * build
        * build-all.sh
    * Repositories
        * MySourceCode (git repo submodule)
        * MyLibCode (git repo submodule)
    * Environments
        * vagrant-desktop (git repo submodule)
    README.md
```

The concept of this architecture is that the vagrant-desktop git repository can provision the desktop environment necessary for development.  From within the environment you can then edit the source code that is on the host system.

Essential tasks like pushing/pulling from the repository can be handled on the host machine to avoid having to copy secrets in the virtual machine.

### Shared Folders

The `Vagrantfile` makes use of the following shared folders to access files on the host machine.

| Name | Path |  Host Path (relative to `Vagrantfile`) | Description |
| --- | --- | --- | --- |
| Repository | /srv/local | ../ | The `vagrant-desktop` repository root. |
| Repositories | /home/vagrant/repositories | ../../../ | The parent directory of the `vagrant-desktop` repository. See [Architecture](#architecture). |

## Development

The `Vagrantfile` is built to act as a bootstrap for more complex vagrant environments that provision a full development environment.  As such, it includes lines for script execution that can be leveraged downstream by other projects.  These scripts are expected within the `provision/` directory.

| Script | Purpose |
| --- | --- |
| provision-pre.sh | Acts as a pre-hook to the default provisioning script. |
| provision.sh | provision.sh provisions the development environment. |
| provision-post.sh | Acts as a post-hook to the provisioning. |

### Dependencies 

The following are the dependencies of the vagrant project

* `getoptlong` - The [GetoptLong](http://ruby-doc.org/stdlib-2.1.0/libdoc/getoptlong/rdoc/GetoptLong.html) class allows you to parse command line options similarly to the GNU getopt_long() C library call.
* `yaml` - The [YAML](https://ruby-doc.org/stdlib-1.9.3/libdoc/yaml/rdoc/YAML.html) module provides a Ruby interface for data serialization in YAML format.

## Acknowledgements

The project icon is by [Maxi Koichi from the Noun Project](docs/icon/README.md).
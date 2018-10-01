# Vagrant Linux Desktop

## Summary

Provide a method of reproducible graphical development environments based on Linux.  This repository provides a base Linux Desktop environment, sandboxed on your local computer.

## Getting Started

You can use this locally with `vagrant up`, calling as such:

```bash
vagrant --name=mydesktop --file=desktop.yaml up
```

However It is recommended to use the script `create.sh` for the first run to ensure all necessary arguments are provided. The provided arguments requires a `settings.yaml`, storing the settings for the machine. You can see an example of one in `tools/simple.yaml`. You can create the machine by calling:

```bash
sh create.sh -n mydesktop -d ubuntu
```

If you want more information about the script `create.sh`, you can do so by calling:

```bash
sh create.sh -h
```

### Parameters

The parameters are used in the calling of `vagrant up`, primarily as `vagrant [OPTIONS] up`. After provisioning the environment, a settings file (`setting.yaml`) is created, which stores the provided parameters.

| Name | Type | Description |
| --- | --- | --- |
| name | `string` | Name of the provisioned desktop environment |
| desktop | `filename` | The name of the desktop provisioning script. These scripts are present in [`packaging/environments`](src/packaging/environments). |

The vagrant environment is based on the `bento/ubuntu` images. If the timezone is not set, the provision script will attempt to auto-detect the timezone using [`tzupdate`](https://github.com/cdown/tzupdate).

### Settings

The following are arguments to the settings.yaml file:

| Name | Type | Description |
| --- | --- | --- |
| name | `string` | Name of the provisioned desktop environment |
| box | `vagrant-box` | The name of the underlying vagrant box |
| path | `dirname` | The path to the `.vagrant` directory |
| desktop | `string` | The name of the desktop provisioning script |
| logs | `dirname` | The directory to dump logs files  |
| synced_folders | `(host: directory, guest: directory)[]` |  |

An example yaml is included below:

```yaml
name: lab
box: ubuntu/trusty64
path: "."
desktop: ubuntu-minimal
logs: "log_dir"
synced_folders:
  - host: "../"
    guest: "/media/vagrant"
```

## Acknowledgements

The project icon is retrieved from [the Noun Project](docs/icon/icon.json). The original source material has been altered for the purposes of the project. The icon is used under the terms of the [Public Domain](https://creativecommons.org/publicdomain/zero/1.0/).

The project icon is by [Maxi Koichi from the Noun Project](https://thenounproject.com/term/package/137417).
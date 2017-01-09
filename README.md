![](./docs/icon.png)
Vagrant Linux Desktop
=

### Abstract

Provide a method of reproducible graphical development environments based on Linux.  This repositroy provides a base Linux Desktop environment, sandboxed on their local computer.  

## Usage

```
vagrant --name=myenvironment --desktop=lubuntu --full=true up
```

## Parameters

The parameters are used in the calling of `vagrant up`, primarily as `vagrant <options> up`.

* `--name=myenvironment` - The name of the desktop environment
* `--desktop=lubuntu` - The desktop environment
* `--type=full` - The type of recommendations to include in the desktop environment
* `--timezone=` - The timezone information *eg Europe/London, etc*

It is based on `bento/ubuntu` images.

## Setting up the application 

On first run (`vagrant up`) the base `bento/ubuntu` image will be downloaded, and the environments will be created.  

## Info

* The standard username and password is `vagrant/vagrant`.

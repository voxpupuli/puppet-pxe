# Puppet Powered PXE Provisioning

[![Puppet Forge](https://img.shields.io/puppetforge/v/zleslie/pxe.svg)]() [![Build Status](https://travis-ci.org/xaque208/puppet-pxe.svg?branch=master)](https://travis-ci.org/xaque208/puppet-pxe)

Super awesome Puppet powered PXE menu and image management for network based
installations.  Seriously.  Its awesome.

Features
--------
  * Automatic image fetching
  * Menu management for easy selection at boot time
  * Host specific menu management
  * Supported OSs
    * Debian
    * Ubuntu
    * CentOS
    * RetHat (with `baseurl`)
    * Fedora
    * Scientific
    * CoreOS

Dependencies
---

You will need a running TFTP configured.  The module now depends on the
`puppetlabs/tftp` module.

## Sample Usage

# Basic setup

```Puppet
class { 'tftp': }
class { 'pxe': }
```

This will setup a tftp server and directory and install pxelinux into it with a
base configuration.

### Images

Here is a sample of how one might stage the network installation images and
build menus for selection at boot time.

First, we start by dragging in the pre-reqs for the whole process.

```Puppet
include pxe
```

Next, lets build a hash for each of the image sets we intend to be booting.

```Puppet
permute { 'Debian Installers':
  resource => 'pxe::installer',
  unique   => {
    arch => ['amd64','i386'],
    ver  => ['squeeze','wheezy'],
    os   => 'debian'
  },
  common   => {
    file   => 'os_<%= @os %>',
    kernel => 'images/<%= @os %>/<%= @ver %>/<%= @arch %>/linux',
    append => 'initrd=images/<%= @os %>/<%= @ver %>/<%= @arch %>/initrd.gz text',
  },
}
```

We can also append common options that will be supported across each of the
menu entries created by the `resource_permute` function.

```Puppet
$redhat_common = {
  "baseurl" => "http://mirror.dyrden.net/rhel<%= ver %>server-<%= arch %>/disc1/images/pxeboot"
}
```

Now we permute and combine the hashes to generate the individual resources that
fetch the images and place them in the correct directory structure.

```Puppet
resource_permute('pxe::images', $ubuntu)
resource_permute('pxe::images', $redhat, $redhat_common)
```

### Menus

```Puppet
include pxe

pxe::menu { 'Main Menu':
  file     => 'default',
  template => 'pxe/menu_default.erb';
}

pxe::menu::entry { 'Installations':
  file    => 'default',
  append  => 'pxelinux.cfg/menu_install',
}

pxe::menu { "Operating System (${arch})":
  file => 'menu_install',
}

pxe::menu { 'Debian':
  file => 'os_debian',
}
```

### Host Configs

```Puppet
pxe::menu::entry { "server1.dyrden.net":
  file    => "01-aa-bb-cc-dd-ee-ff",
  kernel  => "images/debian/i386/squeeze/squeeze",
  append  => "vga=791 initrd=images/debian/i386/squeeze/squeeze.gz",
}
```


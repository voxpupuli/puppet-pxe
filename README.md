# Puppet Powered PXE Provisioning

[![Build Status](https://travis-ci.org/voxpupuli/puppet-pxe.png?branch=master)](https://travis-ci.org/voxpupuli/puppet-pxe)
[![Code Coverage](https://coveralls.io/repos/github/voxpupuli/puppet-pxe/badge.svg?branch=master)](https://coveralls.io/github/voxpupuli/puppet-pxe)
[![Puppet Forge](https://img.shields.io/puppetforge/v/puppet/pxe.svg)](https://forge.puppetlabs.com/puppet/pxe)
[![Puppet Forge - downloads](https://img.shields.io/puppetforge/dt/puppet/pxe.svg)](https://forge.puppetlabs.com/puppet/pxe)
[![Puppet Forge - endorsement](https://img.shields.io/puppetforge/e/puppet/pxe.svg)](https://forge.puppetlabs.com/puppet/pxe)
[![Puppet Forge - scores](https://img.shields.io/puppetforge/f/puppet/pxe.svg)](https://forge.puppetlabs.com/puppet/pxe)

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

Next, lets loop over some data and create a few `pxe::installer` resources
using the new Puppet language methods.

```Puppet
$debian_architectures = ['amd64', 'i386']
$debian_versions = ['squeeze', 'wheezy', 'jessie']

$debian_versions.each |$ver| {
  $os = 'debian'

  $debian_architectures.each |$arch| {

    pxe::installer { "${os}_${ver}_${arch}":
      arch   => $arch,
      ver    => $ver,
      os     => $os,
      file   => "os_${os}",
      kernel => "images/${os}/${ver}/${arch}/linux",
      append => "initrd=images/${os}/${ver}/${arch}/initrd.gz text",
    }
  }
}
```

This structure could be extended considerably, but it paints a picture for how
to build a bunch of resources using the puppet iteration.  This module used to
recommend use of the `resource_permute()` function, but that was long before
the new Puppet4 language constructs replaced the need for this function.  As
such, its recommended that you use the `pxe::installer` resources directly.

## Syslinux

By default this module will install the latest version of syslinux, downloaded
from kernel.org (You can see the latest version in the manifests/params.pp)
file.  To install the version that ships with your OS, or to specify a version,
pass the syslinux variable to pxe.

For Example:

class { 'pxe':
  syslinux_version => 'system',
}

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

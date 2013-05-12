# Puppet Powered PXE Provisioning

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

Dependencies
---

You will need a running TFTP configured.  The module now depends on the
`puppetlabs/tftp` module.

## Sample Usage

# Basic setup

    class { "tftp": }
    class { "pxe": }

This will setup a tftp server and directory and install pxelinux into it with a
base configuration.

### Images

Here is a sample of how one might stage the network installation images and
build menus for selection at boot time.

First, we start by dragging in the pre-reqs for the whole process.

    include pxe

Next, lets build a hash for each of the image sets we intend to be booting.

    $ubuntu = {
      "arch" => ["amd64","i386"],
      "ver"  => ["hardy","karmic","lucid","maverick","natty","oneiric","precise"],
      "os"   => "ubuntu"
    }

    $redhat = {
      "arch" => ["x86_64","i386"],
      "ver"  => 6,
      "os"   => "redhat"
    }

We can also append common options that will be supported across each of the
menu entries created by the `resource_permute` function.

    $redhat_common = {
      "baseurl" => "http://mirror.dyrden.net/rhel<%= ver %>server-<%= arch %>/disc1/images/pxeboot"
    }

Now we permute and combine the hashes to generate the individual resources that
fetch the images and place them in the correct directory structure.

    resource_permute('pxe::images', $ubuntu)
    resource_permute('pxe::images', $redhat, $redhat_common)

### Menus

    include pxe

    pxe::menu {
      'Main Menu':
        file      => "default",
        template  => "pxe/menu_default.erb";
    }

    pxe::menu::entry {
      "Installations":
        file    => "default",
        append  => "pxelinux.cfg/menu_install",
    }

    pxe::menu {
      'Operating System ($arch)':
        file  => "menu_install",
    }

    pxe::menu::entry {
      "Debian":
        file    => "menu_install",
        append  => "pxelinux.cfg/os_debian",
    }

    pxe::menu {
      'Debian':
        file  => "os_debian",
    }

    pxe::menu::entry {
      "Debian 6 squeeze i386 Installation":
        file    => "os_debian",
        kernel  => "images/debian/i386/squeeze/squeeze",
        append  => "vga=791 initrd=images/debian/i386/squeeze/squeeze.gz",
    }


### Host Configs

    pxe::menu::entry {
      "server1.dyrden.net":
        file    => "01-aa-bb-cc-dd-ee-ff",
        kernel  => "images/debian/i386/squeeze/squeeze",
        append  => "vga=791 initrd=images/debian/i386/squeeze/squeeze.gz",
    }


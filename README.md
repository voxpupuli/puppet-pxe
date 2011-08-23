Puppet PXE
==========
Deploy PXE boot images and menu for network installations.

Features
--------
  * Automatic image downloading
  * Menu management
  * Supported OSs 
    * Debian
    * Ubuntu
    * CentOS
    * Ret Hat (with `baseurl`)
    * Fedora
    * Scientific

Usage
-----
### Images

    include pxe

    $ubuntu = {
      "arch" => ["amd64","i386"],
      "ver"  => ["hardy","karmic","lucid","maverick","natty","oneiric"],
      "os"   => "ubuntu"
    }

    $redhat = {
      "arch" => ["x86_64","i386"],
      "ver"  => 6,
      "os"   => "redhat"
    }

    $redhat_common = {
      "baseurl" => "http://mirror.dyrden.net/rhel<%= ver %>server-<%= arch %>/disc1/images/pxeboot"
    }

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


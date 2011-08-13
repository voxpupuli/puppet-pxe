Puppet PXE
==========
Deploy PXE boot images for network installations.

Features
--------
  * Automatic image downloading
  * Menu management
  * Supports Debian, Ubuntu, CentOS and Ret Hat (with `baseurl`)

Future Work
-----------
  * Improve menu system
  * Add support OEL, Sci-Linux, etc

Placeholder
-----------
  * pxe::menu::menuentry should accept 'target' param for concat building

Usage
-----
### Basic usage

    $ubuntu = {
      "arch" => ["amd64","i386"],
      "ver"  => ["hardy","karmic","lucid","maverick","natty","oneiric"],
      "os"   => "ubuntu"
    }

    $debian = {
      "arch" => ["amd64","i386"],
      "ver"  => ["lenny","squeeze","wheezy"],
      "os"   => "debian"
    }
    $centos = {
      "arch" => ["x86_64","i386"],
      "ver"  => [4,5,6],
      "os"   => "centos"
    }
    $redhat = {
      "arch" => ["x86_64","i386"],
      "ver"  => 6,
      "os"   => "redhat"
    }

    $redhat_common = {
      "baseurl" => "http://mirror.dyr.den/rhel<%= ver %>server-<%= arch %>/disc1/images/pxeboot"
    }

    resource_permute('pxe::images', $ubuntu)
    resource_permute('pxe::images', $debian)
    resource_permute('pxe::images', $centos)
    resource_permute('pxe::images', $redhat, $redhat_common)


### Menuing System

To add a new menu item, you need two exported resources in the pxe::menu::resources class.

    @pxe::menu::menuentry { "Install": }
    @pxe::menu { "Install": }

This will create a pxelinux.cfg/Install class, and give you the ability to add entries to it.  Then realize the resource somewhere useful and begin adding entries to it, as seen in the pxe::bootstrap class.

    Pxe::Menu::Menuentry <| title == "Install" |>

    pxe::menu::entry { 
      "Ubuntu $altname $ver $arch Preseed Install":
        kernel => "$kernel",
        append => "initrd=$initrd auto locale=en_US console-setup/layoutcode=us netcfg/get_hostname=unassigned-hostname url=http://tork.znet/bootstrap/maverick.cfg text",
        target => "Install",
    }

The namevar of the resource becomes the label which will be displayed in the menu.  Use $kernel and $append as one might expect, and set the target to be the namevar of the menu that you are creating, in thise case "Install".  NOTE: **Case Matters**

### Host Configs
  You can also have individual host configurations for hosts that need more tailored builds.

    pxe::host {
      "server1.example.net":
        hwaddr => "01-aa-bb-cc-dd-ee-ff",
        arch   => "amd64",
        ver    => "maverick",
    }

This will create the file specific to the mac address and be loaded instead of the defaul pxelinux config.  Please note, this will skip the default menu configuration and therefore can be dangerous to use if a host boots from the network.


Puppet PXE
==========
Manage a PXE server for assisting in automated network installations.

Features
--------
  * Installation and configuration of tftp through the use of xinetd
  * Automated kernel and initrd image managemnt for network installations
  * Limited preseed and kickstart configuration and deployment
  * Basic menu system for selection of installation type

Future Work
-----------
  * Improve menu system
  * Add support for debian, centos
  * Add disk layout support for bootstrap configurations
  * Host specific pxelinux configuration creation

Placeholder
-----------
  * retire use of class { 'pxe'... in favor of bootstrap::resources
  * retire pxe::menu in favor of bootstrap::resources
  * pxe::menu::menuentry should accept 'target' param for concat building

Usage
-----
### Basic usage
The following class statement will get everything setup with default settings.  See the class pxe::bootstrap::settings for more information on customization of overrides.

    class { 'pxe::bootstrap::settings': }


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

The namevar of the resource becomes the lable which will be displayed in the menu.  Use $kernel and $append as one might expect, and set the target to be the namevar of the menu that you are creating, in thise case "Install".  NOTE: **Case Matters**


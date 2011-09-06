define pxe::images::resources (
    $os,
    $ver,
    $arch
  ) {

  $tftp_root = $::pxe::tftp_root
  $os_cap    = inline_template("<%= os.capitalize %>")

  # directory structure
  if ! defined(File["$tftp_root/images"]) { @file { "$tftp_root/images": ensure => directory; } }
  if ! defined(File["$tftp_root/images/$os"]) { @file { "$tftp_root/images/$os": ensure => directory; } }
  if ! defined(File["$tftp_root/images/$os/$ver"]) { @file { "$tftp_root/images/$os/$ver": ensure => directory; } }
  if ! defined(File["$tftp_root/images/$os/$ver/$arch"]) { @file { "$tftp_root/images/$os/$ver/$arch": ensure => directory; } }

  # Menu
  if !defined(Pxe::Menu["Main Menu"]) {
    @pxe::menu {
      "Main Menu":
        file     => "default",
        template => "pxe/menu_default.erb";
    }
  }

  if !defined(Pxe::Menu::Entry["Installations"]) {
    @pxe::menu::entry {
      "Installations":
        file    => "default",
        append  => "pxelinux.cfg/menu_install",
    }
  }

  if ! defined(Pxe::Menu['System Installs']) {
    pxe::menu {
      'System Installs':
        file        => "menu_install",
    }
  }

  if ! defined(Pxe::Menu::Entry["$os_cap"]) {
    @pxe::menu::entry {
      "$os_cap":
        file    => "menu_install",
        append  => "pxelinux.cfg/os_${os}",
    }
  }

  if ! defined(Pxe::Menu["$os_cap"]) { # we will arrive here more than once, avoid dupes
    @pxe::menu {
      "$os_cap":
        file        => "os_${os}",
    }
  }

}


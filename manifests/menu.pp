# * file: which file to write to
# * template: to use for the menu

define pxe::menu (
    $file,
    $back        = "Main Menu",
    $append      = "pxelinux.cfg/default",
    $template    = "pxe/menu.erb") {

  include concat::setup

  $tftp_root = $::pxe::tftp_root
  $fullpath  = "$tftp_root/pxelinux.cfg"

  concat::fragment { "menu_${name}-header":
    order   => '00',
    target  => "$fullpath/$file",
    content => template("$template"),
  }

  concat { "$fullpath/$file": }

}


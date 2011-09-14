# Define: pxe::menu::installentry
#
# This will create an entry, but also accepts things like arch and version
#
# Parameters:
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
define pxe::menu::installentry (
  $order    ='10',
  $kernel,
  $append,
  $file,
  $arch,
  $os,
  $ver,
  $template = "pxe/menuinstallentry.erb") {

  include concat::setup

  $tftp_root = $::pxe::tftp_root
  $fullpath  = "$tftp_root/pxelinux.cfg"

  $menu_file     = inline_template($file)
  $append_string = inline_template($append)
  $kernel_string = inline_template($kernel)

  concat::fragment { "install-menu-${os}-${ver}-${arch}":
    order   => $order,
    target  => "$fullpath/$menu_file",
    content => template("pxe/menuinstallentry.erb"),
  }

}


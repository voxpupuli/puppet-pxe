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
    $order     ='10',
    $kernel,
    $append,
    $file,
    $arch,
    $os,
    $ver,
    $template  = "pxe/menuinstallentry.erb",
    $menutitle = ''
) {

  include concat::setup

  if $menutitle == '' {
    $label = $title
  } else {
    $label = $menutitle
  }

  $tftp_root = $::pxe::tftp_root
  $fullpath  = "$tftp_root/pxelinux.cfg"

  $menu_file     = inline_template($file)
  $append_string = inline_template($append)
  $kernel_string = inline_template($kernel)
  $label_string  = inline_template($label)

  concat::fragment { "install-menu-${label_string}":
    order   => $order,
    target  => "$fullpath/$menu_file",
    content => template("pxe/menuinstallentry.erb"),
  }

}


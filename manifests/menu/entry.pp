# Class: pxe::menu::entry
#
# This is a utility class for creating menu entries for pxe booting.
#
# Parameters:
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
define pxe::menu::entry (
    $template   = "pxe/menuentry.erb",
    $order      ='10',
    $kernel     = "menu.c32",
    $append     = '',
    $file,
    $menuetitle = ''
) {

  if $menutitle == '' {
    $label = $title
  } else {
    $label = $menutitle
  }

  $tftp_root = $::pxe::tftp_root
  $fullpath  = "${tftp_root}/pxelinux.cfg"

  $file_string   = inline_template($file)
  $label_string  = inline_template($label)

  concat::fragment { "${file_string}-menu-entry-${title}":
    order   => $order,
    target  => "${fullpath}/${file_string}",
    content => template("pxe/menuentry.erb"),
  }

}

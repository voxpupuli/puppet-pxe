# Define: pxe::menu::installentry
#
# This will create an entry, but also accepts things like arch and version,
# which are not useed, but are useful for use with resource_permute, when you
# want to permute on values, but not use them.
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
    $kernel,
    $append,
    $file,
    $arch,
    $os,
    $ver,
    $order     = '10',
    $template  = 'pxe/menuinstallentry.erb',
    $menutitle = ''
) {

  if $menutitle == '' {
    $label = $title
  } else {
    $label = $menutitle
  }

  $tftp_root = $::pxe::tftp_root
  $fullpath  = "${tftp_root}/pxelinux.cfg"

  $file_string   = inline_template($file)
  $append_string = inline_template($append)
  $kernel_string = inline_template($kernel)
  $label_string  = inline_template($label)

  concat::fragment { "install-menu-${label_string}":
    order   => $order,
    target  => "${fullpath}/${file_string}",
    content => template($template),
  }
}

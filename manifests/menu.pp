# * file: which file to write to
# * template: to use for the menu

# Here we want to setup a new menu file, but we also want to be able to get to
# this menu from another menu.  The $root refers to to the file that is directly
# above this one in the menu which allows us to setup the file to which this
# resource appies, but also add a pxe::menu::entry to get here.

define pxe::menu (
  $file,
  $back     = 'Main Menu',
  $append   = 'pxelinux.cfg/default',
  $template = 'pxe/menu.erb',
  $root     = 'default',
) {

  $tftp_root = $::pxe::tftp_root
  $fullpath  = "${tftp_root}/pxelinux.cfg"

  concat::fragment { "menu_${name}-header":
    order   => '00',
    target  => "${fullpath}/${file}",
    content => template($template),
  }

  if !defined(Concat["${fullpath}/${file}"]) {
    concat { "${fullpath}/${file}": }
  }

  # If we are adding the root entry, then there is no need to reference this
  # from elsewhere.
  if $file != $root {
    pxe::menu::entry { $name:
      file   => $root,
      append => "pxelinux.cfg/${file}",
    }
  }

  if $root == 'default' {
    if !defined(Concat["${fullpath}/${root}"]) {
      concat { "${fullpath}/${root}": }
    }
  }
}

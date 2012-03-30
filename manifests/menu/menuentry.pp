# 
# This module will create a sub-menu entry in the given $target

define pxe::menu::menuentry (
    $menutitle = '',
    $kernel    = 'menu.c32',
    $target    = 'default',
    $template  = "pxe_menuentry.erb"
  ) {

  if $menutitle == '' {
    $label = $title
  }

  $tftp_root = $::pxe::tftp_root
  $append    = "pxelinux.cfg/$label"

  include pxe::menu::resources
  Pxe::Menu <| title == $title |>

  concat::fragment { "$target-menuentry-$title":
    order   => '10',
    target  => "$tftp_root/pxelinux.cfg/$target",
    content => template("$template"),
  }

}

define pxe::menu (
    $back      = 'default',
    $back_name = '|| Main Menu',
    $template  = "pxe/menuentry-header.erb"
    ) {

  include concat::setup
  #include pxe::menu::default

  $target    = $title
  $tftp_root = $::pxe::tftp_root
  $fullpath  = "$tftp_root/pxelinux.cfg"
  $prefix    = "pxelinux.cfg"

  include pxe::menu::resources
  Pxe::Menu <| target == $title |>

  concat::fragment { "menu_$name-header":
    order   => '00',
    target  => "$fullpath/$target",
    content => template("pxe/menuentry-header.erb"),
  }

  concat { "$fullpath/$target": }

  #Concat <| target = "$fullpath/$target" |>

}

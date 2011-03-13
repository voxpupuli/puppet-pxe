define pxe::menu::entry ($kernel,$append,$target) {

  $tftp_root = $::pxe::tftp_root
  $label = $title 

  include pxe::menu::resources
  Pxe::Menu <| title == $title |>
  
  concat::fragment { "$target-menu-entry-$title":
    order => '10',
    target => "$tftp_root/pxelinux.cfg/$target",
    content => template("pxe/menuentry.erb"),
  } 
  

}

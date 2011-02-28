define pxe::menu::install::entry ($image='menu.c32',$append){
  include pxe::menu::install

  $tftp_root = $::pxe::tftp_root
  $label = $title 
 
  concat::fragment { "menu_install-entry-$title":
    order => '10',
    target => "$tftp_root/pxelinux.cfg/menu_install",
    content => template("pxe/menu_install-entry.erb"),
  } 

}

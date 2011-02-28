define pxe::menu::ubuntu::entry ($kernel,$initrd){
  include pxe::menu::install

  $tftp_root = $::pxe::tftp_root
  $label = $title 
 
  concat::fragment { "os_ubuntu-entry-$title":
    order => '10',
    target => "$tftp_root/pxelinux.cfg/os_ubuntu",
    content => template("pxe/os_ubuntu-entry.erb"),
  } 

}

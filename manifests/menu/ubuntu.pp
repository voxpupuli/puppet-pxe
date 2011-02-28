class pxe::menu::ubuntu {
  include concat::setup

  $tftp_root = $::pxe::tftp_root

  pxe::menu::install::entry {
    "Ubuntu":
      append => "pxelinux.cfg/os_ubuntu"
  }
  
  concat::fragment { 'os_ubuntu-header':
    order => '00',
    target => "$tftp_root/pxelinux.cfg/os_ubuntu",
    source => "puppet:///modules/pxe/os_ubuntu-header",
  }

  concat { "$tftp_root/pxelinux.cfg/os_ubuntu": }


}

class pxe::menu::install {
  include concat::setup

  $tftp_root = $::pxe::tftp_root
  
  concat::fragment { 'menu_install-header':
    order => '00',
    target => "$tftp_root/pxelinux.cfg/menu_install",
    source => "puppet:///modules/pxe/menu_install-header",
  }

  concat { "$tftp_root/pxelinux.cfg/menu_install": }


}

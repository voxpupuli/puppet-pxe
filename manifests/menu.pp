class pxe::menu {

  file { "$tftp_root/pxelinux.cfg/default":
    source => "puppet:///modules/pxe/default";
  }

}

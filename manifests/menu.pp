class pxe::menu {

  file { "$tftp_root/pxelinux.cfg/default":
    owner  => root,
    group  => root,
    mode   => 644,
    source => "puppet:///modules/pxe/default";
  }

}

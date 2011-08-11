define pxe::host (
    $hwaddr,
    $arch,
    $ver
    ) {

  $kernel = "images/ubuntu/$ver/$arch/linux"
  $initrd = "images/ubuntu/$ver/$arch/initrd.gz"

  pxe::menu::host { 
    "$hwaddr": 
      kernel => "$kernel",
      append => "initrd=$initrd auto locale=en_US console-setup/layoutcode=us netcfg/get_hostname=unassigned-hostname url=http://tork.znet/bootstrap/maverick.cfg text",
  }

}

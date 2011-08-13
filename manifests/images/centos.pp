define pxe::images::centos(
    $arch,
    $ver,
    $os,
    $baseurl = ''
  ) {

  $tftp_root = $::pxe::tftp_root

  if $baseurl == '' {
    $srclocation = "http://mirrors.kernel.org/$os/$ver/os/$arch/images/pxeboot"
  }

  exec {
    "wget $os pxe linux $arch $ver":
      cwd     => "$tftp_root/images/$os/$ver/$arch",
      creates => "$tftp_root/images/$os/$ver/$arch/vmlinuz",
      command => "/usr/bin/wget $srclocation/vmlinuz";
    "wget $os pxe initrd.img $arch $ver":
      cwd     => "$tftp_root/images/$os/$ver/$arch",
      creates => "$tftp_root/images/$os/$ver/$arch/initrd.img",
      command => "/usr/bin/wget $srclocation/initrd.img";
  }

}


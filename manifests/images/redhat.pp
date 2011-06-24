define pxe::images::redhat($arch,$ver,$baseurl) {

  if $baseurl == '' { err('$baseurl is empty and it need not be') }

  exec {
    "wget redhat pxe linux $arch $ver":
      cwd     => "$tftp_root/images/redhat/$ver/$arch",
      creates => "$tftp_root/images/redhat/$ver/$arch/vmlinuz",
      command => "/usr/bin/wget $baseurl/images/pxeboot/vmlinuz";
    "wget redhat pxe initrd.img $arch $ver":
      cwd     => "$tftp_root/images/redhat/$ver/$arch",
      creates => "$tftp_root/images/redhat/$ver/$arch/initrd.img",
      command => "/usr/bin/wget $baseurl/images/pxeboot/initrd.img";
  }

}


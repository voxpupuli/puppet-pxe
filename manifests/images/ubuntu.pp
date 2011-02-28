define pxe::images::ubuntu($arch,$ver) {

#  pxe::menu::ubuntu::entry { 
#    "Ubuntu $ver $arch Preseed Install":
#       kernel => "images/ubuntu/$ver/$arch/linux",
#       initrd => "images/ubuntu/$ver/$arch/initrd.gz",
#  }

  # http://mirrors.kernel.org/ubuntu/dists/lucid/main/installer-amd64/current/images/netboot/ubuntu-installer/amd64/
	$baseurl = "http://mirrors.kernel.org/ubuntu/dists"
  $path = "$ver/main/installer-$arch/current/images/netboot/ubuntu-installer/$arch"

	exec {
		"wget ubuntu pxe linux $arch $ver":
			cwd => "$tftp_root/images/ubuntu/$ver/$arch",
			command => "/usr/bin/wget $baseurl/$path/linux",
			creates => "$tftp_root/images/ubuntu/$ver/$arch/linux";
		"wget ubuntu pxe initrd.img $arch $ver":
			cwd => "$tftp_root/images/ubuntu/$ver/$arch",
			command => "/usr/bin/wget $baseurl/$path/initrd.gz",
			creates => "$tftp_root/images/ubuntu/$ver/$arch/initrd.gz";
	}

}


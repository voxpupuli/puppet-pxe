define pxe::images::ubuntu($arch,$ver) {

  # http://mirrors.kernel.org/ubuntu/dists/lucid/main/installer-amd64/current/images/netboot/ubuntu-installer/amd64/
  $path    = "$ver/main/installer-$arch/current/images/netboot/ubuntu-installer/$arch"
	$baseurl = "http://mirrors.kernel.org/ubuntu/dists"

	exec {
		"wget ubuntu pxe linux $arch $ver":
			cwd     => "$tftp_root/images/ubuntu/$ver/$arch",
			command => "/usr/bin/wget $baseurl/$path/linux",
			creates => "$tftp_root/images/ubuntu/$ver/$arch/linux";
		"wget ubuntu pxe initrd.img $arch $ver":
			cwd     => "$tftp_root/images/ubuntu/$ver/$arch",
			command => "/usr/bin/wget $baseurl/$path/initrd.gz",
			creates => "$tftp_root/images/ubuntu/$ver/$arch/initrd.gz";
	}

}


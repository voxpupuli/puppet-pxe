define pxe::centos($arch,$ver) {
	
	$dirs = [
		"${tftp_root}/images/centos/${arch}/${ver}",
	]

	file { $dirs: ensure => directory, owner => root, group => root, mode => 755; }

	exec {
		"pull centos pxe vmlinuz $arch $ver":
			cwd => "${tftp_root}/images/centos/${arch}/${ver}",
			command => "/usr/bin/wget http://mirrors.kernel.org/centos/${ver}/os/${arch}/images/pxeboot/vmlinuz",
			creates => "${tftp_root}/images/centos/${arch}/${ver}/vmlinuz";
		"pull centos pxe initrd.img $arch $ver":
			cwd => "${tftp_root}/images/centos/${arch}/${ver}",
			command => "/usr/bin/wget http://mirrors.kernel.org/centos/${ver}/os/${arch}/images/pxeboot/initrd.img",
			creates => "${tftp_root}/images/centos/${arch}/${ver}/initrd.img";
	}

	file {
		"${ks_root}/centos_${arch}_${ver}.cfg":
			owner => root, group => root, mode => 644, content => template("pxe/centos_ks.cfg.erb");
	}


}


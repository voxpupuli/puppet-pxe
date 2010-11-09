define pxe::ubuntu($arch,$ver) {
   
    # http://mirrors.kernel.org/ubuntu/dists/lucid/main/installer-amd64/current/images/netboot/ubuntu-installer/amd64/
    $baseurl = "http://mirrors.kernel.org/ubuntu/dists"

	
	$dirs = [
		"${tftp_root}/images/ubuntu/${arch}/${ver}",
	]

	file { $dirs: ensure => directory, owner => root, group => root, mode => 755; }

	exec {
		"pull ubuntu pxe linux $arch $ver":
			cwd => "${tftp_root}/images/ubuntu/${arch}/${ver}",
			command => "/usr/bin/wget ${baseurl}/${ver}/main/installer-${arch}/current/images/netboot/ubuntu-installer/${arch}/linux",
			creates => "${tftp_root}/images/ubuntu/${arch}/${ver}/linux";
		"pull centos pxe initrd.img $arch $ver":
			cwd => "${tftp_root}/images/ubuntu/${arch}/${ver}",
			command => "/usr/bin/wget ${baseurl}/${ver}/main/installer-${arch}/current/images/netboot/ubuntu-installer/${arch}/initrd.gz",
			creates => "${tftp_root}/images/ubuntu/${arch}/${ver}/initrd.gz";
	}

	#file {
	#	"${ks_root}/centos_${arch}_${ver}.cfg":
	#		owner => root, group => root, mode => 644, content => template("pxe/centos_ks.cfg.erb");
	#}
}


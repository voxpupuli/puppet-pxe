class pxe {
	include pxe::params
    include pxe::centos
	include apache

	$tftp_root = $pxe::params::tftp_root
	$ks_root   = $pxe::params::ks_root

	package {
		"xinetd":				ensure => installed;
		"syslinux":			ensure => installed;
		"tftp-server":	ensure => installed;
	}

	file {
		"/etc/xinetd.d/tftp":
			owner		=> root,
			group		=> root,
			mode		=> 644,
			notify	=> Service["xinetd"],
			source	=> "puppet:///modules/pxe/tftp_xinetd";
		"${tftp_root}": ensure => directory, owner => root, group => root, mode => 755;
		"${tftp_root}/pxelinux.0": ensure => directory, owner => root, group => root, mode => 755,
			source => "/usr/lib/syslinux/pxelinux.0";
		"${tftp_root}/menu.c32": ensure => directory, owner => root, group => root, mode => 755,
			source => "/usr/lib/syslinux/menu.c32";
		"${tftp_root}/memdisk": ensure => directory, owner => root, group => root, mode => 755,
			source => "/usr/lib/syslinux/memdisk";
		"${tftp_root}/mboot.c32": ensure => directory, owner => root, group => root, mode => 755,
			source => "/usr/lib/syslinux/mboot.c32";
		"${tftp_root}/chain.c32": ensure => directory, owner => root, group => root, mode => 755,
			source => "/usr/lib/syslinux/chain.c32";
		#"${tftp_root}/pxelinux.cfg": ensure => directory, owner => root, group => root, mode => 755;
		"${tftp_root}/images": ensure => directory, owner => root, group => root, mode => 755;
		"${tftp_root}/images/centos": ensure => directory, owner => root, group => root, mode => 755;
		"${ks_root}": ensure => directory, owner => root, group => root, mode => 755;
	}

	service {
		"xinetd":
			ensure => running,
			enable => true;
	}
	
	$dirs = [
		"${tftp_root}/images/centos/i386",
		"${tftp_root}/images/centos/x86_64",
	]
	
	file { $dirs: ensure => directory, owner => root, group => root, mode => 755; }
	
	centosimages { 
		"centos_i386_4.8":
			arch => "i386",
			ver => "4.8";
		"centos_x86_64_4.8":
			arch => "x86_64",
			ver => "4.8";
		"centos_i386_5.5":
			arch => "i386",
			ver => "5.5";
		"centos_x86_64_5.5":
			arch => "x86_64",
			ver => "5.5";
	}
	
}


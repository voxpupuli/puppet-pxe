class pxe ($tftp_root='/tftpboot'){
  include apache
  include pxe::menu

  package {
    "xinetd":   ensure => installed;
    "syslinux": ensure => installed;
  }

  package {
    "tftp-server":	
      name   => $operatingsystem ? {
        Ubuntu  => "tftpd-hpa",
        default => "tftp-server",
      },
      ensure => installed;
	}

  file {
    "/etc/xinetd.d/tftp":
      owner     => root,
      group     => root,
      mode      => 644,
      notify    => Service["xinetd"],
      content   => template("pxe/tftp_xinetd.erb");
    "${tftp_root}": 
      ensure    => directory, 
      owner     => root, 
      group     => root, 
      mode      => 755;
    "${tftp_root}/pxelinux.0": 
      ensure    => directory, 
      owner     => root, 
      group     => root, 
      mode      => 755,
      source    => "/usr/lib/syslinux/pxelinux.0",
      require   => Package["syslinux"];
    "${tftp_root}/menu.c32": 
      ensure    => directory, 
      owner     => root, 
      group     => root, 
      mode      => 755,
      source    => "/usr/lib/syslinux/menu.c32",
      require   => Package["syslinux"];
    "${tftp_root}/memdisk": 
      ensure    => directory, 
      owner     => root, 
      group     => root, 
      mode      => 755,
      source    => "/usr/lib/syslinux/memdisk",
      require   => Package["syslinux"];
    "${tftp_root}/mboot.c32": 
      ensure    => directory, 
      owner     => root, 
      group     => root, 
      mode      => 755,
      source    => "/usr/lib/syslinux/mboot.c32",
      require   => Package["syslinux"];
    "${tftp_root}/chain.c32": 
      ensure    => directory, 
      owner     => root, 
      group     => root, 
      mode      => 755,
      source    => "/usr/lib/syslinux/chain.c32",
      require   => Package["syslinux"];
    "${tftp_root}/pxelinux.cfg": 
      ensure    => directory, 
      owner     => root, 
      group     => root, 
      mode      => 755;
  }

  service {
    "xinetd":
      ensure => running,
      enable => true;
  }

  Pxe::Images <| |>

}


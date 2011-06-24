class pxe ($tftp_root='/srv/tftp'){
  class { apache: }
  class { tftp: tftp_root => $tftp_root; }
  class { "pxe::menu::default": tftp_root => $tftp_root; }

  package {
    "syslinux": ensure => installed;
  }

  Pxe::Images <| |>

  file {
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

}


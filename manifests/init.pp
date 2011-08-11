class pxe ($tftp_root='/srv/tftp'){
  #class { apache: }
  #class { tftp:                 tftp_root => $tftp_root; }
  class { "pxe::menu::default": tftp_root => $tftp_root; }

  #include depends::www
  #include depends::tftp

  include pxe::params

  $syslinux_dir = $pxe::params::syslinux_dir


  package {
    "syslinux": ensure => installed;
  }

  Pxe::Images <| |>

  file {
    "${tftp_root}/pxelinux.0":
      ensure    => directory,
      owner     => root,
      group     => 0,
      mode      => 755,
      source    => "$syslinux_dir/pxelinux.0",
      require   => Package["syslinux"];
    "${tftp_root}/menu.c32":
      ensure    => directory,
      owner     => root,
      group     => 0,
      mode      => 755,
      source    => "$syslinux_dir/menu.c32",
      require   => Package["syslinux"];
    "${tftp_root}/memdisk":
      ensure    => directory,
      owner     => root,
      group     => 0,
      mode      => 755,
      source    => "$syslinux_dir/memdisk",
      require   => Package["syslinux"];
    "${tftp_root}/chain.c32":
      ensure    => directory,
      owner     => root,
      group     => 0,
      mode      => 755,
      source    => "$syslinux_dir/chain.c32",
      require   => Package["syslinux"];
    "${tftp_root}/pxelinux.cfg":
      ensure    => directory,
      owner     => root,
      group     => 0,
      mode      => 755;
  }

}


class pxe ($tftp_root='/srv/tftp'){

  class { "pxe::menu::default": tftp_root => $tftp_root; }

  include pxe::params

  $syslinux_dir     = $pxe::params::syslinux_dir
  $syslinux_archive = $pxe::params::syslinux_archive

  file { $tftp_root:
    ensure => directory,
  }

  exec { "syslinux_install":
    cwd     => "/usr/local/src",
    command => "/usr/bin/wget $syslinux_archive; tar -xzf syslinux-4.04.tar.gz",
    creates => "/usr/local/src/syslinux-4.04",
  }

  Pxe::Images <| |>

  file {
    "${tftp_root}/pxelinux.0":
      ensure    => directory,
      owner     => root,
      group     => 0,
      mode      => 755,
      source    => "$syslinux_dir/core/pxelinux.0",
      require   => Exec["syslinux_install"];
    "${tftp_root}/menu.c32":
      ensure    => directory,
      owner     => root,
      group     => 0,
      mode      => 755,
      source    => "$syslinux_dir/com32/menu/menu.c32",
      require   => Exec["syslinux_install"];
    "${tftp_root}/pxelinux.cfg":
      ensure    => directory,
      owner     => root,
      group     => 0,
      mode      => 755;
  }

}


class pxe ($tftp_root='/srv/tftp'){

  include pxe::params

  $syslinux_dir     = $pxe::params::syslinux_dir
  $syslinux_archive = $pxe::params::syslinux_archive

  exec { "syslinux_install":
    path    => ["/bin", "/usr/bin", "/usr/local/bin"],
    cwd     => "/usr/local/src",
    command => "wget $syslinux_archive; tar -xzf syslinux-4.04.tar.gz",
    creates => "/usr/local/src/syslinux-4.04",
  }

  file {
    "${tftp_root}/pxelinux.0":
      owner     => root,
      group     => 0,
      mode      => 755,
      source    => "${syslinux_dir}/core/pxelinux.0",
      require   => Exec["syslinux_install"];
    "${tftp_root}/menu.c32":
      owner     => root,
      group     => 0,
      mode      => 755,
      source    => "${syslinux_dir}/com32/menu/menu.c32",
      require   => Exec["syslinux_install"];
    "${tftp_root}/vesamenu.c32":
      owner     => root,
      group     => 0,
      mode      => 755,
      source    => "${syslinux_dir}/com32/menu/vesamenu.c32",
      require   => Exec["syslinux_install"];
    "${tftp_root}/chain.c32":
      owner     => root,
      group     => 0,
      mode      => 755,
      source    => "${syslinux_dir}/com32/modules/chain.c32",
      require   => Exec["syslinux_install"];
    "${tftp_root}/reboot.c32":
      owner     => root,
      group     => 0,
      mode      => 755,
      source    => "${syslinux_dir}/com32/modules/reboot.c32",
      require   => Exec["syslinux_install"];
    "${tftp_root}/memdisk":
      owner     => root,
      group     => 0,
      mode      => 755,
      source    => "${syslinux_dir}/memdisk/memdisk",
      require   => Exec["syslinux_install"];
    "${tftp_root}/pxelinux.cfg":
      ensure    => directory,
      owner     => root,
      group     => 0,
      mode      => 755;
  }

}

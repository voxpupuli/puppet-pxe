class pxe::syslinux::direct(
  String[1] $tftp_root,
  String[1] $syslinux_archive,
  String[1] $syslinux_dir,
) {

  exec { 'syslinux_install':
    path    => ['/bin', '/usr/bin', '/usr/local/bin'],
    cwd     => '/usr/local/src',
    command => "wget -q -O - ${syslinux_archive} | tar -xzf - -C `dirname ${syslinux_dir}`",
    creates => $syslinux_dir,
  }

  file { "${tftp_root}/pxelinux.0":
    source  => "${syslinux_dir}/bios/core/pxelinux.0",
    require => Exec['syslinux_install'],
  }

  file { "${tftp_root}/syslinux/menu.c32":
    source  => "${syslinux_dir}/bios/com32/menu/menu.c32",
    require => Exec['syslinux_install'],
  }

  file { "${tftp_root}/syslinux/vesamenu.c32":
    source  => "${syslinux_dir}/bios/com32/menu/vesamenu.c32",
    require => Exec['syslinux_install'],
  }

  file { "${tftp_root}/syslinux/reboot.c32":
    source  => "${syslinux_dir}/bios/com32/modules/reboot.c32",
    require => Exec['syslinux_install'],
  }

  file { "${tftp_root}/syslinux/ldlinux.c32":
    source  => "${syslinux_dir}/bios/com32/elflink/ldlinux/ldlinux.c32",
    require => Exec['syslinux_install'],
  }

  file { "${tftp_root}/syslinux/libcom32.c32":
    source  => "${syslinux_dir}/bios/com32/lib/libcom32.c32",
    require => Exec['syslinux_install'],
  }

  file { "${tftp_root}/syslinux/libutil.c32":
    source  => "${syslinux_dir}/bios/com32/libutil/libutil.c32",
    require => Exec['syslinux_install'],
  }

  file { "${tftp_root}/syslinux/memdisk":
    source  => "${syslinux_dir}/bios/memdisk/memdisk",
    require => Exec['syslinux_install'],
  }
}

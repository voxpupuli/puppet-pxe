class pxe::syslinux::system (
  String[1] $tftp_root,
  String[1] $syslinux_dir,
) {
  package { 'syslinux': }

  file { "${tftp_root}/pxelinux.0":
    source  => "${syslinux_dir}/pxelinux.0",
    require => Package['syslinux'],
  }

  file { "${tftp_root}/syslinux/ldlinux.c32":
    source  => "${syslinux_dir}/ldlinux.c32",
    require => Package['syslinux'],
  }

  file { "${tftp_root}/syslinux/menu.c32":
    source  => "${syslinux_dir}/menu.c32",
    require => Package['syslinux'],
  }

  file { "${tftp_root}/syslinux/vesamenu.c32":
    source  => "${syslinux_dir}/vesamenu.c32",
    require => Package['syslinux'],
  }

  file { "${tftp_root}/syslinux/libutil.c32":
    source  => "${syslinux_dir}/libutil.c32",
    require => Package['syslinux'],
  }

  file { "${tftp_root}/syslinux/reboot.c32":
    source  => "${syslinux_dir}/reboot.c32",
    require => Package['syslinux'],
  }

  file { "${tftp_root}/syslinux/memdisk":
    source  => "${syslinux_dir}/memdisk",
    require => Package['syslinux'],
  }
}

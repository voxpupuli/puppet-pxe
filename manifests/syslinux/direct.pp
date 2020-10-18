class pxe::syslinux::direct (
  String[1] $tftp_root,
  String[1] $syslinux_archive,
  String[1] $syslinux_dir,
) {
  if $syslinux_dir =~ /syslinux-([0-9.]+)$/ {
    $syslinux_version = $1
  }
  file { $syslinux_dir:
    ensure => directory;
  }
  archive { "/usr/local/src/syslinux-${syslinux_version}.tar.gz":
    ensure       => present,
    source       => $syslinux_archive,
    extract      => true,
    extract_path => "${syslinux_dir}/..",
    require      => File[$syslinux_dir];
  }

  file { "${tftp_root}/pxelinux.0":
    source  => "${syslinux_dir}/bios/core/pxelinux.0",
    require => Archive["/usr/local/src/syslinux-${syslinux_version}.tar.gz"];
  }

  file { "${tftp_root}/syslinux/menu.c32":
    source  => "${syslinux_dir}/bios/com32/menu/menu.c32",
    require => Archive["/usr/local/src/syslinux-${syslinux_version}.tar.gz"];
  }

  file { "${tftp_root}/syslinux/vesamenu.c32":
    source  => "${syslinux_dir}/bios/com32/menu/vesamenu.c32",
    require => Archive["/usr/local/src/syslinux-${syslinux_version}.tar.gz"];
  }

  file { "${tftp_root}/syslinux/reboot.c32":
    source  => "${syslinux_dir}/bios/com32/modules/reboot.c32",
    require => Archive["/usr/local/src/syslinux-${syslinux_version}.tar.gz"];
  }

  file { "${tftp_root}/syslinux/ldlinux.c32":
    source  => "${syslinux_dir}/bios/com32/elflink/ldlinux/ldlinux.c32",
    require => Archive["/usr/local/src/syslinux-${syslinux_version}.tar.gz"];
  }

  file { "${tftp_root}/syslinux/libcom32.c32":
    source  => "${syslinux_dir}/bios/com32/lib/libcom32.c32",
    require => Archive["/usr/local/src/syslinux-${syslinux_version}.tar.gz"];
  }

  file { "${tftp_root}/syslinux/libutil.c32":
    source  => "${syslinux_dir}/bios/com32/libutil/libutil.c32",
    require => Archive["/usr/local/src/syslinux-${syslinux_version}.tar.gz"];
  }

  file { "${tftp_root}/syslinux/memdisk":
    source  => "${syslinux_dir}/bios/memdisk/memdisk",
    require => Archive["/usr/local/src/syslinux-${syslinux_version}.tar.gz"];
  }
}

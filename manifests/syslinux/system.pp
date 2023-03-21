class pxe::syslinux::system (
  String[1] $tftp_root,
  String[1] $syslinux_dir,
) {
  package { 'syslinux': }

  file { "${tftp_root}/pxelinux.0":
    source  => "${syslinux_dir}/pxelinux.0",
    require => Package['syslinux'],
  }
  
  file { "${tftp_root}/syslinux":
    source  => $syslinux_dir,
    recurse => true,
    require => Package['syslinux'],
  }

}

class pxe::syslinux::system (
  String[1] $tftp_root,
  String[1] $syslinux_dir,
) {
  package { 'syslinux': }

  file { "${tftp_root}/pxelinux.0":
    source  => "${syslinux_dir}/pxelinux.0",
    require => Package['syslinux'],
  }
  $tftproot_syslinux_files = [
    'menu.c32',
    'vesamenu.c32',
    'reboot.c32',
    'ldlinux.c32',
    'libcom32.c32',
    'libutil.c32',
    'memdisk',
  ]
  $tftproot_syslinux_files.each |$file| {
    file { "${tftp_root}/syslinux/${file}":
      source  => "${syslinux_dir}/${file}",
      require => Package['syslinux'],
    }
  }
}

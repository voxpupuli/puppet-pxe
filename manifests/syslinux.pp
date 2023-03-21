#
# This class will install the syslinux images into the tftp root directory.
#
class pxe::syslinux (
  String[1] $syslinux_version,
  String[1] $tftp_root,
  String[1] $system_syslinux_dir   = $pxe::params::system_syslinux_dir,
) inherits pxe::params {
  if $syslinux_version == 'system' {
    # pxe::syslinux::system will also manage ${tftp_root}/syslinux
    class { 'pxe::syslinux::system':
      syslinux_dir => $system_syslinux_dir,
      tftp_root    => $tftp_root,
    }
  } elsif $syslinux_version =~ /^([0-9]+)\./ {
    $syslinux_major_version = $1
    class { 'pxe::syslinux::direct':
      syslinux_dir     => "/usr/local/src/syslinux-${syslinux_version}",
      syslinux_archive => "https://www.kernel.org/pub/linux/utils/boot/syslinux/${syslinux_major_version}.xx/syslinux-${syslinux_version}.tar.gz",
      tftp_root        => $tftp_root,
    }
    file { "${tftp_root}/syslinux":
      ensure => directory,
    }
  } else {
    fail('Invalid Syslinux Version')
  }

  File {
    owner   => root,
    group   => 0,
    mode    => '0755',
    require => File[$tftp_root],
  }

  ensure_resource('file', $tftp_root, {
      ensure  => directory,
      require => undef,
  })

  file { "${tftp_root}/pxelinux.cfg":
    ensure => directory,
  }
}

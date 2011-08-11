class pxe::params {

  case $operatingsystem {
    'freebsd': {
      $syslinux_dir = '/usr/local/share/syslinux'
    }
    'debian','ubuntu': {
      $syslinux_dir = '/usr/lib/syslinux'
    }
    default: {
    }
  }

}

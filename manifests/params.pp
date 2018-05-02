# Class: pxe::params
#
# Some static variables to use elsewhere
#
class pxe::params {
  $syslinux_version    = '6.03'
  $system_syslinux_dir = '/usr/share/syslinux' # This is true for CentOS can't speak for other OS'es
}

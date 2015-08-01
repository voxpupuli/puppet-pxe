# Class: pxe::params
#
# Some static variables to use elsewhere
#
class pxe::params {

  $syslinux_archive = 'https://www.kernel.org/pub/linux/utils/boot/syslinux/6.xx/syslinux-6.03.tar.gz'
  $syslinux_dir     = '/usr/local/src/syslinux-6.03'
}

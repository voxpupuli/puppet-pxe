# Class: pxe::params
#
# Some static variables to use elsewhere
#
class pxe::params {

  $tftproot         = '/srv/tftp'
  $syslinux_archive = 'https://www.kernel.org/pub/linux/utils/boot/syslinux/4.xx/syslinux-4.04.tar.gz'
  $syslinux_dir     = '/usr/local/src/syslinux-4.04'
}

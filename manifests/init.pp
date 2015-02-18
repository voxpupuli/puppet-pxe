# Class: pxe
#
# Setup a PXE root directory.  This should do nothing but setup the base
# menuing system with syslinux and some pxe tools installed.
#
class pxe (
  $tftp_root        = $pxe::params::tftp_root,
  $syslinux_archive = $pxe::params::syslinux_archive,
  $memtest_archive  = $pxe::params::memtest_archive
) inherits pxe::params {
  include pxe::syslinux
  include pxe::tools
}

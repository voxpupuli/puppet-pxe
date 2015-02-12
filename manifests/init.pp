# Class: pxe
#
# Setup a PXE root directory.  This should do nothing but setup the base
# menuing system with syslinux and some pxe tools installed.
#
class pxe (
  $tftp_root        = $pxe::params::tftp_root,
  $syslinux_archive = undef
) inherits pxe::params {
  class { 'pxe::syslinux':
    syslinux_archive => $syslinux_archive
  }
  include pxe::tools
}

# Class: pxe
#
# Setup a PXE root directory.  This should do nothing but setup the base
# menuing system with syslinux and some pxe tools installed.
#
class pxe (
  $tftp_root        = '/srv/tftp',
  $syslinux_version = $pxe::params::syslinux_version,
  $tools            = true,
) inherits pxe::params {

  ensure_packages(['wget'], 'ensure' => 'present')

  class { 'pxe::syslinux':
    tftp_root        => $tftp_root,
    syslinux_version => $syslinux_version,
  }
  if $tools{
    include pxe::tools
  }
}

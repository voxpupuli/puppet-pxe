# Class: pxe
#
# Setup a PXE root directory
#
class pxe (
  $tftp_root='/srv/tftp'
){

  include pxe::params
  include pxe::syslinux
  include pxe::tools
}

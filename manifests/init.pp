# Class: pxe
#
# Setup a PXE root directory.  This should do nothing but setup the base
# menuing system with syslinux and some pxe tools installed.
#
class pxe (
  $tftp_root='/srv/tftp'
){
  include pxe::syslinux
  include pxe::tools
}

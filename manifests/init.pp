class pxe ($tftp_root='/srv/tftp'){

  include pxe::params
  include pxe::tools
  include pxe::syslinux

}

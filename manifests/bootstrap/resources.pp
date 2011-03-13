class pxe::bootstrap::resources {
    
  @file  { $location: ensure => directory; }
  #@class { 'pxe': tftp_root = > $tftproot, }

}

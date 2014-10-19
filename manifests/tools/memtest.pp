# Class: pxe::tools::memtest
#
# Adds the memtest image to the menu
#
class pxe::tools::memtest (
  $url = 'http://www.memtest.org/download/4.20/memtest86+-4.20.bin.gz'
){

  $tftp_root = $::pxe::tftp_root

  exec { 'retrieve memtest image':
    path    => ['/usr/bin', '/usr/local/bin', '/bin'],
    command => "wget -q -O - ${url} | gunzip > ${tftp_root}/tools/memtest86+",
    creates => "${tftp_root}/tools/memtest86+",
    require => File["${tftp_root}/tools"],
  }

  # Create the menu entry
  pxe::menu::entry { 'Memtest86+':
    file   => 'menu_tools',
    kernel => 'tools/memtest86+',
  }
}

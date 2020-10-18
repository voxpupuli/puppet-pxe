# Class: pxe::tools::memtest
#
# Adds the memtest image to the menu
#
class pxe::tools::memtest (
  $url = 'http://www.memtest.org/download/4.20/memtest86+-4.20.bin.gz',
  $tftp_root = $pxe::tftp_root
) {
  archive { "${tftp_root}/tools/memtest86+-4.20.bin.gz":
    ensure       => present,
    source       => $url,
    extract      => true,
    extract_path => "${tftp_root}/tools",
    creates      => "${tftp_root}/tools/memtest86+-4.20.bin",
    require      => Class['Pxe::Tools'];
  }
  file { "${tftp_root}/tools/memtest86+":
    ensure  => link,
    target  => "${tftp_root}/tools/memtest86+-4.20.bin",
    require => Archive["${tftp_root}/tools/memtest86+-4.20.bin.gz"];
  }

  # Create the menu entry
  pxe::menu::entry { 'Memtest86+':
    file      => 'menu_tools',
    kernel    => 'tools/memtest86+',
    tftp_root => $tftp_root,
  }
}

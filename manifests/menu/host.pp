# Define: pxe::menu::host
#
define pxe::menu::host ($kernel,$append) {

  $tftp_root = $pxe::tftp_root
  $label     = $title

  concat::fragment { $title:
    order   => '00',
    target  => "${tftp_root}/pxelinux.cfg/${title}",
    content => template('pxe/menuhost.erb'),
  }

  concat { "${tftp_root}/pxelinux.cfg/${title}": }

}

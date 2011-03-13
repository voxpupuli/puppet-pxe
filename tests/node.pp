class { 'pxe':
  tftp_root => '/tftpboot',
}


class { 'pxe::bootstrap::settings':
  location  => '/var/www/bootstrap',
  ntpserver => "wall.znet",
  rootpw    => 'changeme'
}

class { 'pxe::bootstrap::settings':
  location => '/var/www/bootstrap',
  ntpserver => 
}

pxe::bootstrap {
  "maverick.cfg":
    os         => "ubuntu",
    ver        => "maverick",
    proxy      => "http://vanir.puppetlabs.lan:3142",
    role       => "standard",
    arch       => "amd64",
}


# TO ADD:
pxe::host {
  "server1.example.net":
    hwaddr => "01-aa-bb-cc-dd-ee-ff",
    bootstrap => "pxe/preseed-server1.example.net.erb",
}

pxe::bootstrap::preseed::settings {
  upgrade => true,
}


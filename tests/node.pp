class { 'pxe':
  tftp_root => '/tftpboot',
}

class { 'pxe::bootstrap::settings':
  location => '/var/www/bootstrap',
}

pxe::bootstrap {
  "maverick.cfg":
    os         => "ubuntu",
    ver        => "maverick",
    proxy      => "http://vanir.puppetlabs.lan:3142",
    role       => "standard",
    arch       => "amd64",
}


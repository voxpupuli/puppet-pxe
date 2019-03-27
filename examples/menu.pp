include pxe

pxe::menu { 'Main Menu':
  file     => 'default',
  template => 'pxe/menu_default.erb';
}

pxe::menu::entry { 'Installations':
  file   => 'default',
  append => 'pxelinux.cfg/menu_install',
}

pxe::menu { "Operating System (${arch})":
  file => 'menu_install',
}

pxe::menu { 'Debian':
  file => 'os_debian',
}

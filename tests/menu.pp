include pxe

pxe::menu {
  'Main Menu':
    file     => "default",
    template => "pxe/menu_default.erb";
}

pxe::menu::entry {
  "Installations":
    file    => "default",
    append  => "pxelinux.cfg/menu_install",
}

pxe::menu {
  'Operating System ($arch)':
    file        => "menu_install",
}

pxe::menu::entry {
  "Debian":
    file    => "menu_install",
    append  => "pxelinux.cfg/os_debian",
}

pxe::menu {
  'Debian':
    file        => "os_debian",
}

pxe::menu::entry {
  "Debian 6 squeeze i386 Installation":
    file    => "os_debian",
    kernel  => "images/debian/i386/squeeze/squeeze",
    #append => "vga=normal initrd=images/debian/i386/squeeze/squeeze.gz",
    append  => "vga=791 initrd=images/debian/i386/squeeze/squeeze.gz",
}

#$debian = {
#  arch => ["x86_64","i386"],
#  ver  => "squeeze",
#}

$debian_common = {
  file   => "os_debian",
  kernel => 'images/debian/<%= arch %>/squeeze/linux'
}

#resource_permute('pxe::menu::entry', $debian, $debian_common)


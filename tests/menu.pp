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

#pxe::menu::entry {
#  "Debian 6 squeeze i386 Installation":
#    file    => "os_debian",
#    kernel  => "images/debian/i386/squeeze/squeeze",
#    #append => "vga=normal initrd=images/debian/i386/squeeze/squeeze.gz",
#    append  => "vga=791 initrd=images/debian/i386/squeeze/squeeze.gz",
#}


# How I want it to be

#$debian = {
#  "arch" => ["amd64","i386"],
#  "ver"  => ["lenny","squeeze","wheezy"],
#  "os"   => "debian"
#}
#
#$debian_menu = {
#  file    => "os_<%= os %>",
#  kernel  => "images/debian/<%= arch %>/<%= ver %>/linux",
#  append  => "vga=791 initrd=images/<%= os %>/<%= arch %>/<%= ver %>/initrd.gz auto locale=en_US console-setup/layoutcode=us netcfg/get_hostname=debian url=http://urd.puppetlabs.lan/seed/debian_base.cfg text",
#}
#
#resource_permute('pxe::menu::zentry', $debian, $debian_menu)
#


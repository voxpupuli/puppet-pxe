include pxe

$ubuntu = {
  "arch" => ["amd64","i386"],
  "ver"  => ["hardy","karmic","lucid","maverick","natty","oneiric"],
  "os"   => "ubuntu"
}

$ubuntu_menu = {
  file    => "os_<%= os %>",
  kernel  => "images/<%= os %>/<%= arch %>/<%= ver %>/linux",
  append  => "vga=791 initrd=images/<%= os %>/<%= arch %>/<%= ver %>/initrd.gz auto locale=en_US console-setup/layoutcode=us netcfg/get_hostname=debian url=http://urd.puppetlabs.lan/seed/ubuntu_base.cfg text",
}

$debian = {
  "arch" => ["amd64","i386"],
  "ver"  => ["lenny","squeeze","wheezy"],
  "os"   => "debian"
}

$debian_menu = {
  "file"    => "os_<%= os %>",
  "kernel"  => "images/<%= os %>/<%= arch %>/<%= ver %>/linux",
  "append"  => "vga=791 initrd=images/<%= os %>/<%= arch %>/<%= ver %>/initrd.gz auto locale=en_US console-setup/layoutcode=us netcfg/get_hostname=<%= os %> url=http://urd.puppetlabs.lan/seed/debian_base.cfg text",
}

$centos = {
  "arch" => ["x86_64","i386"],
  "ver"  => [4,5,6],
  "os"   => "centos"
}

$centos_menu = {
  "file"    => "os_<%= os %>",
  "kernel"  => "images/<%= os %>/<%= arch %>/<%= ver %>/vmlinuz",
  "append"  => "initrd=images/<%= os %>/<%= arch %>/<%= ver %>/initrd.img ks=http://urd.puppetlabs.lan/ks/centos_kickstart.cfg text",
}

$redhat = {
  "arch" => ["x86_64","i386"],
  "ver"  => 6,
  "os"   => "redhat"
}

$redhat_common = {
  "baseurl" => "http://yo.puppetlabs.lan/rhel<%= ver %>server-<%= arch %>/disc1/images/pxeboot"
}

$redhat_menu = {
  "file"    => "os_<%= os %>",
  "kernel"  => "images/<%= os %>/<%= arch %>/<%= ver %>/vmlinuz",
  "append"  => "initrd=images/<%= os %>/<%= arch %>/<%= ver %>/initrd.img ks=http://urd.puppetlabs.lan/ks/<% os %><%= ver %>-<%= arch %>.cfg text",
}

$scientific = {
  "arch" => ["x86_64","i386"],
  "ver"  => "6.0",
  "os"   => "scientific"
}

$scientific_common = {
  "baseurl" => "http://mirror.yellowfiber.net/scientific/<%= ver %>/<%= arch %>/os/images/pxeboot/"
}

$fedora = {
  "arch" => ["x86_64","i386"],
  "ver"  => "15",
  "os"   => "fedora"
}

$fedora_common = {
  "baseurl" => "http://mirrors.kernel.org/fedora/releases/<%= ver %>/Fedora/<%= arch %>/os/images/pxeboot/",
  "file"    => "os_<%= os %>",
  "kernel"  => "images/<%= os %>/<%= arch %>/<%= ver %>/vmlinuz",
  "append"  => "initrd=images/<%= os %>/<%= arch %>/<%= ver %>/initrd.img ks=http://urd.puppetlabs.lan/ks/<% os %><%= ver %>-<%= arch %>.cfg text",
}

resource_permute('pxe::images', $ubuntu)
resource_permute('pxe::images', $debian)
resource_permute('pxe::images', $centos)
resource_permute('pxe::images', $redhat,     $redhat_common)
resource_permute('pxe::images', $scientific, $scientific_common)
resource_permute('pxe::images', $fedora,     $fedora_common)

resource_permute('pxe::menu::installentry', $debian, $debian_menu)
resource_permute('pxe::menu::installentry', $ubuntu, $ubuntu_menu)

resource_permute('pxe::bootstrap', $ubuntu, $ubuntu_menu)



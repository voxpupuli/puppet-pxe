include pxe
class { "tftp":
  inet => false;
}

$ubuntu = {
  "arch" => ["amd64","i386"],
  "ver"  => ["hardy","karmic","lucid","maverick","natty","oneiric"],
  "os"   => "ubuntu"
}

$ubuntu_common = {
  file    => "os_<%= os %>",
  kernel  => "images/<%= os %>/<%= ver %>/<%= arch %>/linux",
  append  => "vga=791 initrd=images/<%= os %>/<%= ver %>/<%= arch %>/initrd.gz auto locale=en_US console-setup/layoutcode=us netcfg/get_hostname=debian url=http://urd.puppetlabs.lan/seed/ubuntu_base.cfg text",
}

$debian = {
  "arch" => ["amd64","i386"],
  "ver"  => ["lenny","squeeze","wheezy"],
  "os"   => "debian"
}

$debian_common = {
  "file"    => "os_<%= os %>",
  "kernel"  => "images/<%= os %>/<%= ver %>/<%= arch %>/linux",
  "append"  => "vga=normal initrd=images/<%= os %>/<%= ver %>/<%= arch %>/initrd.gz auto locale=en_US console-keymaps-at/keymap=us hostname=<%= os %> url=http://urd.puppetlabs.lan/seed/debian_base.cfg text",
}

$centos = {
  "arch" => ["x86_64","i386"],
  "ver"  => [4,5,6],
  "os"   => "centos"
}

$centos_common = {
  "file"    => "os_<%= os %>",
  "kernel"  => "images/<%= os %>/<%= ver %>/<%= arch %>/vmlinuz",
  "append"  => "initrd=images/<%= os %>/<%= ver %>/<%= arch %>/initrd.img ks=http://urd.puppetlabs.lan/ks/centos_kickstart.cfg text",
}

$redhat = {
  "arch" => ["x86_64","i386"],
  "ver"  => 6,
  "os"   => "redhat"
}

$redhat_common = {
  "baseurl" => "http://yo.puppetlabs.lan/rhel<%= ver %>server-<%= arch %>/disc1/images/pxeboot",
  "file"    => "os_<%= os %>",
  "kernel"  => "images/<%= os %>/<%= ver %>/<%= arch %>/vmlinuz",
  "append"  => "initrd=images/<%= os %>/<%= ver %>/<%= arch %>/initrd.img ks=http://urd.puppetlabs.lan/ks/<% os %><%= ver %>-<%= arch %>.cfg text",
}

$scientific = {
  "arch" => ["x86_64","i386"],
  "ver"  => "6.0",
  "os"   => "scientific"
}

$scientific_common = {
  "baseurl" => "http://mirror.yellowfiber.net/scientific/<%= ver %>/<%= arch %>/os/images/pxeboot/",
  "file"    => "os_<%= os %>",
  "kernel"  => "images/<%= os %>/<%= ver %>/<%= arch %>/vmlinuz",
  "append"  => "initrd=images/<%= os %>/<%= ver %>/<%= arch %>/initrd.img ks=http://urd.puppetlabs.lan/ks/<% os %><%= ver %>-<%= arch %>.cfg text",
}

$fedora = {
  "arch" => ["x86_64","i386"],
  "ver"  => "15",
  "os"   => "fedora"
}

$fedora_common = {
  "baseurl" => "http://fedora.cat.pdx.edu/linux/releases/<%= ver %>/Fedora/<%= arch %>/os/images/pxeboot/",
  "file"    => "os_<%= os %>",
  "kernel"  => "images/<%= os %>/<%= ver %>/<%= arch %>/vmlinuz",
  "append"  => "initrd=images/<%= os %>/<%= ver %>/<%= arch %>/initrd.img ks=http://urd.puppetlabs.lan/ks/<%= os %><%= ver %>-<%= arch %>.cfg text",
}

resource_permute('pxe::bootstrap', $debian, $debian_common)
resource_permute('pxe::bootstrap', $ubuntu, $ubuntu_common)
resource_permute('pxe::bootstrap', $fedora, $fedora_common)
resource_permute('pxe::bootstrap', $centos, $centos_common)
resource_permute('pxe::bootstrap', $redhat, $redhat_common)
resource_permute('pxe::bootstrap', $scientific, $scientific_common)


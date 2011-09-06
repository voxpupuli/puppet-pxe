include pxe

$ubuntu = {
  "arch" => ["amd64","i386"],
  "ver"  => ["hardy","karmic","lucid","maverick","natty","oneiric"],
  "os"   => "ubuntu"
}

$debian = {
  "arch" => ["amd64","i386"],
  "ver"  => ["lenny","squeeze","wheezy"],
  "os"   => "debian"
}

$centos = {
  "arch" => ["x86_64","i386"],
  "ver"  => [4,5,6],
  "os"   => "centos"
}

$redhat = {
  "arch" => ["x86_64","i386"],
  "ver"  => 6,
  "os"   => "redhat"
}

$redhat_common = {
  "baseurl" => "http://yo.puppetlabs.lan/rhel<%= ver %>server-<%= arch %>/disc1/images/pxeboot"
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
  "baseurl" => "http://mirrors.kernel.org/fedora/releases/<%= ver %>/Fedora/<%= arch %>/os/images/pxeboot/"
}

resource_permute('pxe::images', $ubuntu)
resource_permute('pxe::images', $debian)
resource_permute('pxe::images', $centos)
resource_permute('pxe::images', $redhat, $redhat_common)
resource_permute('pxe::images', $scientific, $scientific_common)
resource_permute('pxe::images', $fedora, $fedora_common)


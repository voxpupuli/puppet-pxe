# Class: pxe::images::centos
#
# Retrieve the requested CentOS image
#
define pxe::images::centos (
  $arch,
  $ver,
  $os      = 'centos',
  $baseurl = undef,
) {
  $tftp_root = $pxe::tftp_root

  if ! $baseurl {
    $srclocation = "http://mirrors.kernel.org/${os}/${ver}/os/${arch}/images/pxeboot"
  } else {
    $srclocation = inline_template($baseurl)
  }

  archive { "${tftp_root}/images/${os}/${ver}/${arch}/vmlinuz":
    ensure => present,
    source => "${srclocation}/vmlinuz";
  }
  archive { "${tftp_root}/images/${os}/${ver}/${arch}/initrd.img":
    ensure => present,
    source => "${srclocation}/initrd.img";
  }
}

# Class: pxe::images::redhat
#
# Retrieve the requested RedHat image
#
define pxe::images::redhat (
  $arch,
  $ver,
  $os,
  $baseurl,
) {
  $tftp_root = $pxe::tftp_root

  if ! $baseurl { err('$baseurl is empty and it need not be') }

  $srclocation = inline_template($baseurl)

  archive { "${tftp_root}/images/redhat/${ver}/${arch}/vmlinuz":
    ensure => present,
    source => "${srclocation}/vmlinuz";
  }
  archive { "${tftp_root}/images/redhat/${ver}/${arch}/initrd.img":
    ensure => present,
    source => "${srclocation}/initrd.img";
  }
}

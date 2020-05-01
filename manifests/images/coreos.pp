# Class: pxe::images::coreos
#
# Retrieve the requested CoreOS image
#
define pxe::images::coreos (
  $arch,
  $ver,
  $os      = 'coreos',
  $baseurl = undef,
) {
  if $arch != 'amd64' { err("Only arch = 'amd64' is supported for CoreOS, ${arch} is invalid") }
  if $os != 'coreos' { err("Only os = 'coreos' is supported for CoreOS, ${os} is invalid") }

  if ! $baseurl {
    $srclocation = "http://stable.release.core-os.net/${arch}-usr/${ver}"
  } else {
    $srclocation = "${baseurl}/${arch}-usr/${ver}"
  }

  $tftp_root = $pxe::tftp_root

  archive { "${tftp_root}/images/${os}/${ver}/${arch}/coreos_production_pxe.vmlinuz":
    ensure => present,
    source => "${srclocation}/coreos_production_pxe.vmlinuz";
  }
  archive { "${tftp_root}/images/${os}/${ver}/${arch}/coreos_production_pxe_image.cpio.gz":
    ensure => present,
    source => "${srclocation}/coreos_production_pxe_image.cpio.gz";
  }
}

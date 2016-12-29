# Class: pxe::images::debian
#
# Retrieve the requested CoreOS image
#
define pxe::images::coreos(
  $arch,
  $ver,
  $os      = 'coreos',
  $baseurl = ''
) {

  if $arch != 'amd64' { err("Only arch = 'amd64' is supported for CoreOS, ${arch} is invalid") }
  if $os != 'coreos' { err("Only os = 'coreos' is supported for CoreOS, ${os} is invalid") }

  if $baseurl == '' {
    $srclocation = "http://stable.release.core-os.net/${arch}-usr/${ver}"
  } else {
    $srclocation = "${baseurl}/${arch}-usr/${ver}"
  }

  $tftp_root = $::pxe::tftp_root

  exec {
    "wget ${os} pxe linux ${arch} ${ver}":
      path    => ['/usr/bin', '/usr/local/bin'],
      cwd     => "${tftp_root}/images/${os}/${ver}/${arch}",
      command => "wget ${srclocation}/coreos_production_pxe.vmlinuz",
      creates => "${tftp_root}/images/${os}/${ver}/${arch}/coreos_production_pxe.vmlinuz";
    "wget ${os} pxe initrd.img ${arch} ${ver}":
      path    => ['/usr/bin', '/usr/local/bin'],
      cwd     => "${tftp_root}/images/${os}/${ver}/${arch}",
      command => "wget ${srclocation}/coreos_production_pxe_image.cpio.gz",
      creates => "${tftp_root}/images/${os}/${ver}/${arch}/coreos_production_pxe_image.cpio.gz";
  }
}

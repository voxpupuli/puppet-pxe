# Class: pxe::images::redhat
#
# Retrieve the requested RedHat image
#
define pxe::images::redhat($arch,$ver,$os,$baseurl) {

  $tftp_root = $::pxe::tftp_root

  if $baseurl == '' { err('$baseurl is empty and it need not be') }

  $srclocation = inline_template($baseurl)

  exec {
    "wget redhat pxe linux ${arch} ${ver}":
      path    => ['/usr/bin', '/usr/local/bin'],
      cwd     => "${tftp_root}/images/redhat/${ver}/${arch}",
      creates => "${tftp_root}/images/redhat/${ver}/${arch}/vmlinuz",
      command => "wget ${srclocation}/vmlinuz";
    "wget redhat pxe initrd.img ${arch} ${ver}":
      path    => ['/usr/bin', '/usr/local/bin'],
      cwd     => "${tftp_root}/images/redhat/${ver}/${arch}",
      creates => "${tftp_root}/images/redhat/${ver}/${arch}/initrd.img",
      command => "wget ${srclocation}/initrd.img";
  }
}

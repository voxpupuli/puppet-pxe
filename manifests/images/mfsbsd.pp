# Class: pxe::images::mfsbsd
#
# Retrieve the requested MfsBSD image
#
define pxe::images::mfsbsd(
  $arch,
  $ver,
  $os      = 'mfsbsd',
  $baseurl = ''
) {

  if $baseurl == '' {
    case $os {
      default:  { $srclocation = 'http://mfsbsd.vx.sk/files/images' }
    }
  }

  # http://mfsbsd.vx.sk/files/images/10/amd64/mfsbsd-10.2-RELEASE-amd64.img
  $path    = "${os}-${ver}-${arch}.img"
  $tftp_root = $::pxe::tftp_root

  exec { "wget ${os} live image ${arch} ${ver}":
      path    => ['/usr/bin', '/usr/local/bin'],
      cwd     => "${tftp_root}/images/${os}/",
      command => "wget ${srclocation}/${path}",
      creates => "${tftp_root}/images/${os}/${path}";
  }
}

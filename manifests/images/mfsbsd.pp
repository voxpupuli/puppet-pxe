define pxe::images::mfsbsd(
    $arch,
    $ver,
    $os      = "mfsbsd",
    $baseurl = ''
    ) {
# This assumes debian as an os, but it works equally for os="ubuntu"

  if $baseurl == '' {
    case $os {
      default:  { $srclocation = "http://mfsbsd.vx.sk/files/images" }
    }
  }

  # http://mirrors.kernel.org/debian/dists/lucid/main/installer-amd64/current/images/netboot/debian-installer/amd64/
  $path    = "${os}-${ver}-${arch}.img"
  $tftp_root = $::pxe::tftp_root

  exec { "wget ${os} live image ${arch} ${ver}":
      path    => ["/usr/bin", "/usr/local/bin"],
      cwd     => "${tftp_root}/images/${os}/",
      command => "wget ${srclocation}/${path}",
      creates => "${tftp_root}/images/${os}/${path}";
  }

}

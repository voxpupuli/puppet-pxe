define pxe::images::debian(
    $arch,
    $ver,
    $os = "debian",
    $baseurl = ''
    ) {
# This assumes debian as an os, but it works equally for os="ubuntu"

  if $baseurl == '' {
    case $os {
      "debian": { $srclocation = "http://ftp.debian.org/${os}/dists" }
      "ubuntu": { $srclocation = "http://archive.ubuntu.com/${os}/dists" }
      default:  { $srclocation = "http://mirrors.kernel.org/${os}/dists" }
    }
  }

  # http://mirrors.kernel.org/debian/dists/lucid/main/installer-amd64/current/images/netboot/debian-installer/amd64/
  $path    = "${ver}/main/installer-${arch}/current/images/netboot/${os}-installer/${arch}"
  $tftp_root = $::pxe::tftp_root

  exec {
    "wget ${os} pxe linux ${arch} ${ver}":
      path    => ["/usr/bin", "/usr/local/bin"],
      cwd     => "${tftp_root}/images/${os}/${ver}/${arch}",
      command => "wget ${srclocation}/${path}/linux",
      creates => "${tftp_root}/images/${os}/${ver}/${arch}/linux";
    "wget ${os} pxe initrd.img ${arch} ${ver}":
      path    => ["/usr/bin", "/usr/local/bin"],
      cwd     => "${tftp_root}/images/${os}/${ver}/${arch}",
      command => "wget ${srclocation}/${path}/initrd.gz",
      creates => "${tftp_root}/images/${os}/${ver}/${arch}/initrd.gz";
  }

}


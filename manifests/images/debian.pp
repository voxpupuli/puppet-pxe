# Class: pxe::images::debian
#
# Retrieve the requested Debian image
#
define pxe::images::debian (
  $arch,
  $ver,
  $netboot = 'netboot', # ubuntu provides other netboots, ex "utopic-netboot"
  $os      = 'debian', # ubuntu also works
  $baseurl = undef,
) {
  if ! $baseurl {
    case $os {
      'debian': { $srclocation = "http://ftp.debian.org/${os}/dists" }
      'ubuntu': { $srclocation = "http://archive.ubuntu.com/${os}/dists" }
      default:  { $srclocation = "http://mirrors.kernel.org/${os}/dists" }
    }
  } else {
    $srclocation = "${baseurl}/${os}/dists"
  }

  # http://mirrors.kernel.org/debian/dists/lucid/main/installer-amd64/current/images/netboot/debian-installer/amd64/
  $path    = "${ver}/main/installer-${arch}/current/images/${netboot}/${os}-installer/${arch}"
  $tftp_root = $pxe::tftp_root

  archive { "${tftp_root}/images/${os}/${ver}/${arch}/linux":
    ensure => present,
    source => "${srclocation}/${path}/linux";
  }
  archive { "${tftp_root}/images/${os}/${ver}/${arch}/initrd.gz":
    ensure => present,
    source => "${srclocation}/${path}/initrd.gz";
  }
}

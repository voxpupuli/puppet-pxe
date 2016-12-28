# == Resource: pxe::images::mfsbsd
#
# Provisioning the resource will retrieve the requested MfsBSD images.
#
# === Parameters
# [*arch*]
#   The architecture. Can be i386 and amd64 for FreeBSD < 11.0-RELEASE. Can
#   be amd64 only for FreeBSD >= 11.0-RELEASE.
#
# [*baseurl*]
#   The http endpoint to download the images from. Lends itself to proxies
#   like aptcacher-ng.
#
# [*os*]
#   The variant of mfsbsd to download. Can be any of {'mfsbsd', 'mfsbsd-se',
#   'mfsbsd-mini'}
#
# [*ver*]
#   The version of mfsbsd to download. Is constructed in the fashion of
#   $MAJOR.$MINOR-RELEASE as in 8.4-RELEASE.
#
define pxe::images::mfsbsd(
  $arch,
  $ver,
  $baseurl = undef,
  $os = 'mfsbsd',
) {

  # TODO: with deprecation of puppet < 4, use puppet regex type and fail()
  validate_re($arch, '^(amd64|i386)$')
  validate_re($os, '^(mfsbsd|mfsbsd-se|mfsbsd-mini)$')
  validate_re($ver, '^\d+.\d-RELEASE$')

  $ver_a = split($ver,'[.-]')
  $maj = $ver_a[0]
  $min = $ver_a[1]

  $srclocation = $baseurl ? {
    /(http|ftp):\/\/.+/ => $baseurl,
    default             => 'http://mfsbsd.vx.sk/files/images',
  }

  # NOTICE: with 11.0-RELEASE, mm@ has dropped i386 and changed the path
  # http://mfsbsd.vx.sk/files/images/10/amd64/mfsbsd-10.2-RELEASE-amd64.img
  # http://mfsbsd.vx.sk/files/images/11/mfsbsd-11.0-RELEASE-amd64.img

  # TODO: with puppet > 4, parse numbers from strings, use numeric comparison
  $path = $maj ? {
    /11/    => "${maj}/${os}-${ver}-${arch}.img",
    default => "${maj}/${arch}/${os}-${ver}-${arch}.img",
  }

  $tftp_root = $::pxe::tftp_root

  exec { "wget ${os} live image ${arch} ${ver}":
    path    => ['/usr/bin', '/usr/local/bin'],
    cwd     => "${tftp_root}/images/${os}/${ver}/${arch}",
    command => "wget ${srclocation}/${path}",
    creates => "${tftp_root}/images/${os}/${path}";
  }
}

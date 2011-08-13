define pxe::bootstrap::redhat (
    $arch,
    $ver,
    $baseurl
  ) {

  $os = 'redhat'

  case $ver {
    '6.0': { $altname = '6' }
    default:  { err ("$ver is not a supported version on $os") }
  }

#  $pxe_images = {
#    'redhat pxe images' => {
#      arch => $arch,
#      ver  => $ver,
#      baseurl => $baseurl,
#      os => $os
#
#    }
#  }

#  permute('pxe::images', $pxe_images)

#  @pxe::images {
#    "$os $ver $arch":
#      os      => $os,
#      ver     => $ver,
#      arch    => $arch,
#      baseurl => "http://yo.puppetlabs.lan/rhel${altname}server-${arch}/disc1";
#  }
}



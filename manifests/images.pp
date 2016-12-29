# Define: pxe::images
#
# This is the control class for grabbing pxe network boot images.  Simlar
# distros are lumped together because the logic in the sub-define is the same.
#
# * Create directory structure for tftp images
# * Download images from public mirrors or private locations ( set by baseurl )
#
define pxe::images (
  $os,
  $ver,
  $arch,
  $netboot = 'netboot',
  $baseurl = undef
) {

  $tftp_root = $::pxe::tftp_root
  $os_cap    = inline_template('<%= @os.capitalize %>')

  # Export the resources needed by all classes
  pxe::images::resources { "${os} ${ver} ${arch}":
    os   => $os,
    ver  => $ver,
    arch => $arch;
  }

  # Realize some directories
  File <| title == "${tftp_root}/images" |>
  File <| title == "${tftp_root}/images/${os}" |>
  File <| title == "${tftp_root}/images/${os}/${ver}" |>
  File <| title == "${tftp_root}/images/${os}/${ver}/${arch}" |>

  # Download the images
  case $os {
    debian,ubuntu: {
      pxe::images::debian { "${os} ${ver} ${arch}":
        arch    => $arch,
        ver     => $ver,
        os      => $os,
        netboot => $netboot,
        baseurl => $baseurl,
      }
    }
    centos,fedora,scientific: {
      pxe::images::centos { "${os} ${ver} ${arch}":
        arch    => $arch,
        ver     => $ver,
        os      => $os,
        baseurl => $baseurl,
      }
    }
    coreos: {
      pxe::images::coreos { "${os} ${ver} ${arch}":
        arch    => $arch,
        ver     => $ver,
        os      => $os,
        baseurl => $baseurl,
      }
    }
    redhat: {
      if $baseurl != '' {
        pxe::images::redhat { "${os} ${ver} ${arch}":
          arch    => $arch,
          ver     => $ver,
          os      => $os,
          baseurl => $baseurl,
        }
      }
    }
    /^mfsbsd(-se|-mini)$/: {
      pxe::images::mfsbsd { "${os} ${ver} ${arch}":
        arch    => $arch,
        ver     => $ver,
        os      => $os,
        baseurl => $baseurl,
      }
    }

    default: { err ("images for ${os} not configured") }
  }
}

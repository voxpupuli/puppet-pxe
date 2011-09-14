# Define: pxe::images
#
# This is the control class for grabbing pxe network boot images.  Simlar distros are lumped together because the logic in the sub-define is the same.
#
# Parameters:
#   os: the name of the os to use in urls when grabbing images and building the tftp directory structure
#   ver:
#   arch:
#   baseurl:
#
# Actions:
#   * Create directory structure for tftp images
#   * Download images from public mirrors or private locations ( set by baseurl )
#
# Requires:
#
# Sample Usage:
#
define pxe::images (
    $os,
    $ver,
    $arch,
    $baseurl = ''
  ) {

  $tftp_root = $::pxe::tftp_root
  $os_cap    = inline_template("<%= os.capitalize %>")

  # Setup directory pathing
  pxe::images::resources { "$os $ver $arch":
    os   => $os,
    ver  => $ver,
    arch => $arch;
  }

  File <| title == "$tftp_root/images" |>
  File <| title == "$tftp_root/images/$os" |>
  File <| title == "$tftp_root/images/$os/$ver" |>
  File <| title == "$tftp_root/images/$os/$ver/$arch" |>


  # Grab the images needed
  case $os {
    debian,ubuntu: {
      pxe::images::debian {
        "$os $ver $arch":
          arch    => "$arch",
          ver     => "$ver",
          os      => "$os",
          baseurl => $baseurl ? {
            ''      => undef,
            default => $baseurl
          };
      }
    }
    centos,fedora,scientific: {
      pxe::images::centos {
        "$os $ver $arch":
          arch    => "$arch",
          ver     => "$ver",
          os      => "$os",
          baseurl => $baseurl ? {
            ''      => undef,
            default => $baseurl
          };
      }
    }
    redhat: {
      pxe::images::redhat {
        "$os $ver $arch":
          arch    => "$arch",
          ver     => "$ver",
          os      => "$os",
          baseurl => $baseurl ? {
            ''      => undef,
            default => $baseurl
          };
      }
    }

    default: { err ("images for $os not configured") }
  }
}


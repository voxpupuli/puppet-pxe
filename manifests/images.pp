define pxe::images (
    $os,
    $ver,
    $arch,
    $baseurl = '',
    $menu    = true
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

  # If menu is enabled, build it out
  if $menu == true {

    Pxe::Menu <| |>
    Pxe::Menu::Entry <| |>

  }


  # Grab the images needed
  case $os {
    debian,ubuntu: {

    if !defined(Pxe::Menu::Entry["$os_cap $ver $arch Installation"]) {
      @pxe::menu::entry {
        "$os_cap $ver $arch Installation":
          file    => "os_${os}",
          kernel  => "images/$os/$arch/$ver/linux",
          append  => "vga=791 initrd=images/$os/$arch/$ver/initrd.gz",
      }
    }
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


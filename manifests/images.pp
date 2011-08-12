define pxe::images ($os,$ver,$arch) {
  $tftp_root = $::pxe::tftp_root
  pxe::images::resources { "$os $ver $arch": 
    os   => $os,
    ver  => $ver,
    arch => $arch;
  }

  File <| title == "$tftp_root/images" |>
  File <| title == "$tftp_root/images/$os" |>
  File <| title == "$tftp_root/images/$os/$ver" |>
  File <| title == "$tftp_root/images/$os/$ver/$arch" |>

  case $os {
    debian,ubuntu: {
      pxe::images::debian {
        "$os $ver $arch":
          arch => "$arch",
          ver  => "$ver",
          os   => "$os";
      }
    }
    default: { err ("images for $os not configured") }
  }
}


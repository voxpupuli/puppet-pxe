define pxe::images ($os,$ver,$arch) {
  $tftp_root = $::pxe::tftp_root
  pxe::images::resources { "$os $ver $arch": }

  File <| title == "$tftp_root/images" |>
  File <| title == "$tftp_root/images/$os" |>
  File <| title == "$tftp_root/images/$os/$ver" |>
  File <| title == "$tftp_root/images/$os/$ver/$arch" |>

  case $os {
    ubuntu: {
      pxe::images::ubuntu {
        "$os $ver $arch":
          arch => "$arch",
          ver => "$ver";
      }
    }
    default: { err ("images for $os not configured") }
  }
}


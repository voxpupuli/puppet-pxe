define pxe::images ($os,$ver,$arch) {
  $tftp_root = $::pxe::tftp_root
  pxe::images::resources { "$os $ver $arch": }
  
  File <| title == "$tftp_root/images" |>
  File <| title == "$tftp_root/images/$os" |>
  File <| title == "$tftp_root/images/$os/$ver" |>
  File <| title == "$tftp_root/images/$os/$ver/$arch" |>

  case $os {
    ubuntu,debian: {
      $path    = "$ver/main/installer-$arch/current/images/netboot/$os-installer/$arch"
      $baseurl = "http://mirrors.kernel.org/$os/dists"

      exec {
        "wget $os pxe linux $arch $ver":
          cwd     => "$tftp_root/images/$os/$ver/$arch",
          command => "/usr/bin/wget $baseurl/$path/linux",
          creates => "$tftp_root/images/$os/$ver/$arch/linux";
       "wget $os pxe initrd.img $arch $ver":
          cwd     => "$tftp_root/images/$os/$ver/$arch",
          command => "/usr/bin/wget $baseurl/$path/initrd.gz",
          creates => "$tftp_root/images/$os/$ver/$arch/initrd.gz";
      }
    }
    default: { err ("images for $os not configured")
  }
}


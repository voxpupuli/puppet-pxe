# Define: pxe::installer
#
# Downlaods the requested image and sets up a generic installation entry for
# each image.
#
define pxe::installer (
  $os,
  $ver,
  $arch,
  $file,
  $kernel,
  $append,
  $baseurl = undef,
  $netboot = 'netboot',
  $menu    = true,
) {
  if $menu {
    Pxe::Menu <||>
    Pxe::Menu::Entry <||>
  }

  unless defined(Pxe::Images["${os} ${ver} ${arch}"]) {
    pxe::images { "${os} ${ver} ${arch}":
      os      => $os,
      ver     => $ver,
      arch    => $arch,
      netboot => $netboot,
      baseurl => $baseurl,
    }
  }

  $append_string = inline_template($append)
  $kernel_string = inline_template($kernel)

  pxe::menu::entry { "Installer: ${title}":
    file   => "os_${os}",
    kernel => $kernel_string,
    append => $append_string,
  }
}

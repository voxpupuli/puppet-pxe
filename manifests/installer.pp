# This define is a wrapper to do two things:
# * download the image files
# * setup a generic an installation entry for each image
define pxe::installer (
    $os,
    $ver,
    $arch,
    $baseurl = '',
    $menu    = true,
    $file,
    $kernel,
    $append
){

  if $menu == true {
    Pxe::Menu <||>
    Pxe::Menu::Entry <||>
  }

  pxe::images { "${os} ${ver} ${arch}":
    os      => $os,
    ver     => $ver,
    arch    => $arch,
    baseurl => $baseurl,
  }

  $append_string = inline_template($append)
  $kernel_string = inline_template($kernel)

  pxe::menu::entry { "Installer: ${os} ${ver} ${arch}":
    file   => "os_${os}",
    kernel => $kernel_string,
    append => $append_string,
  }

}

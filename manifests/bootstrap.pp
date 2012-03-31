# This define is a wrapper to do two things:
# * download the image files
# * setup a generic an installation entry for each image
define pxe::bootstrap (
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

  pxe::images {
    "$os $ver $arch":
      os      => $os,
      ver     => $ver,
      arch    => $arch,
      baseurl => $baseurl,
  }

  pxe::menu::installentry {
    "$os $ver $arch":
      os     => $os,
      ver    => $ver,
      arch   => $arch,
      file   => "os_${os}",
      kernel => $kernel,
      append => $append,
  }

}


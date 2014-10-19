# Define: pxe::images::resources
#
# This define creates a series of resources that are used in other defines.  The
# reason for this class is to allow `include pxe::images::resources` in
# classes/defines where you will need a given resource more than once.  This
# merely facilitates the createtion of virtual resources for realization in
# other parts of the code.
#
define pxe::images::resources (
  $os,
  $ver,
  $arch
) {

  $tftp_root = $::pxe::tftp_root
  $os_cap    = inline_template('<%= @os.capitalize %>')

  # directory structure
  if ! defined(File["${tftp_root}/images"]) {
    @file { "${tftp_root}/images": ensure => directory; }
  }
  if ! defined(File["${tftp_root}/images/${os}"]) {
    @file { "${tftp_root}/images/${os}": ensure => directory; }
  }
  if ! defined(File["${tftp_root}/images/${os}/${ver}"]) {
    @file { "${tftp_root}/images/${os}/${ver}": ensure => directory; }
  }
  if ! defined(File["${tftp_root}/images/${os}/${ver}/${arch}"]) {
    @file { "${tftp_root}/images/${os}/${ver}/${arch}": ensure => directory; }
  }

  # Menu
  if !defined(Pxe::Menu['Main Menu']) {
    @pxe::menu { 'Main Menu':
        file     => 'default',
        template => 'pxe/menu_default.erb';
    }
  }

  if ! defined(Pxe::Menu['System Installers']) {
    pxe::menu { 'System Installers':
      file  => 'menu_install',
    }
  }

  if ! defined(Pxe::Menu[$os_cap]) {
    @pxe::menu { $os_cap:
      file => "os_${os}",
      root => 'menu_install',
    }
  }
}

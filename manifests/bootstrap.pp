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

  # If menu is enabled, build it out
  if $menu == true {
    Pxe::Menu <| |>
    Pxe::Menu::Entry <| |>
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


#  $tftpboot  = $pxe::tftpboot
#  $location  = $pxe::bootstrap::settings::location
#  $ntpserver = $pxe::bootstrap::settings::ntpserver
#  $rootpw    = $pxe::bootstrap::settings::rootpw

#  include pxe::bootstrap::resources
#  File  <| title == "$location" |>
#  #Class <| title == 'pxe' |>
#  Pxe::Menu::Menuentry <| title == "Install" |>
#
#  include pxe::menu::default
#
#  case $os {
#    ubuntu:   {
#      $mirror           = 'archive.ubuntu.com'
#      $secmirror        = 'security.ubuntu.com'
#      $secmirror_path   = '/ubuntu'
#      $mirror_directory = '/ubuntu'
#
#      case $ver {
#        maverick: { $altname = "10.10"}
#        lucid:    { $altname = "10.04"}
#        default:  { err ("$ver is not a supported version on $os") }
#      }
#
#      $kernel = "images/ubuntu/$ver/$arch/linux"
#      $initrd = "images/ubuntu/$ver/$arch/initrd.gz"
#      $buildcfg = "url=http://tork.znet/bootstrap/maverick.cfg"
#      $appendargs = [
#        "initrd=$initrd",
#        "auto",
#        "locale=en_US",
#        "console-setup/layoutcode=us",
#        "url=http://tork.znet/bootstrap/$ver.cfg",
#        "netcfg/get_hostname=unassigned-hostname",
#        "netcfg/choose_interface=eth0",
#        "text",
#      ]
#
#      pxe::menu::entry { 
#        "Ubuntu $altname $ver $arch Preseed Install":
#          kernel => "$kernel",
#          append => inline_template("<% appendargs.each do |arg| %><%= arg %> <% end %>"),
#          #initrd => "images/ubuntu/$ver/$arch/initrd.gz",
#          target => "Install",
#      }
#
#      file {
#        "$location/$name":
#          owner => root,
#          group => root,
#          mode  => 644,
#          content => template("pxe/preseed.cfg.erb");
#      }
#    }
#    debian:   {
#      $mirror = 'http.us.debian.org'
#      $mirror_directory = '/debian'
#      case $ver {
#        squeeze:    { $altname = "6" }
#        lenny:      { $altname = "5" }
#        default:  { err ("$ver is not a supported version on $os") }
#      }
#    }
#    redhat: {
#      $testarch = ["x86_64","i386"]
#      $testver  = ["6","5","4"]
#      $pxe_redhat = {
#          arch    => $testarch,
#          ver     => $testver,
##    baseurl => "http://yo.puppetlabs.lan/rhel_ver_server-_arch_/disc1"
#      }
#
#      pxe_expand('pxe::bootstrap::redhat', $pxe_redhat)
#
##      pxe::bootstrap::redhat {
##        "$os $ver $arch":
##          arch    => $testarch,
##          ver     => $testver,
##          baseurl => "http://yo.puppetlabs.lan/rhel${altname}server-${arch}/disc1";
##      }
#    }
#    default: { err ("$os is not supported") } 
#  }
#
##  @pxe::images {
##   "$os $ver $arch":
##      os   => $os,
##      ver  => $ver,
##      arch => $arch;
##  }
#
}


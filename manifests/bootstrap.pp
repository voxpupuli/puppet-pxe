# This module should catch everything related to deployment of systems, including
# Menu configuratiom
# Image gathering
# Auto-script provisioning (pressed, kickstart)


define pxe::bootstrap ($os,$ver,$proxy='',$role='standard',$arch='amd64'){

  $tftpboot = $pxe::tftpboot
  $location = $pxe::bootstrap::settings::location

  include pxe::bootstrap::resources
  File <| title == "$location" |>
 
  include pxe::menu 

  case $os {
    ubuntu:   {
      include pxe::menu::ubuntu

      $mirror = 'archive.ubuntu.com'
      $mirror_directory = '/ubuntu'
      $secmirror = 'security.ubuntu.com'
      $secmirror_path = '/ubuntu'

      case $ver {
        maverick: { $altname = "10.10"}
        lucid:    { $altname = "10.04"}
        default:  { err ("$ver is not a supported version on $os") }
      }

      pxe::menu::ubuntu::entry { 
      #pxe::menu::os::entry { 
        "Ubuntu $altname $ver $arch Preseed Install":
           kernel => "images/ubuntu/$ver/$arch/linux",
           initrd => "images/ubuntu/$ver/$arch/initrd.gz",
      }
    }
    debian:   {
      $mirror = 'http.us.debian.org'
      $mirror_directory = '/debian'
      case $ver {
        squeeze:    { $altname = "6" }
        lenny:      { $altname = "5" }
        default:  { err ("$ver is not a supported version on $os") }
      }
    }
    default: { err ("$os is not supported") } 
  }

  file {
    "$location/$name":
      owner => root,
      group => root,
      mode  => 644,
      content => template("pxe/preseed.cfg.erb");
  }

  @pxe::images {
   "$os $ver $arch":
      os   => $os,
      ver  => $ver,
      arch => $arch;
  }

}


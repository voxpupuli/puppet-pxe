# This was an initial attempt at creating per host boot configuration, but
# ended up being very specific to debian.  I think this would be more useful if
# you could instead of targeting the pxeboot.cfg/default file, just create some
# menus and some defaults for a given system.  This way you could have a
# default "boot from local disk" and a "reimage this box" with what ever flavor
# of install you like.  This seems more useful to me.  Patches accepted. :)

define pxe::host (
  $hwaddr,
  $arch,
  $ver,
  $get_hostname   = 'unassigned-hostname',
  $boot_interface = 'eth0',
  $seed_url       = 'http://tork.znet/bootstrap/maverick.cfg'
) {

  $kernel = "images/ubuntu/${ver}/${arch}/linux"
  $initrd = "images/ubuntu/${ver}/${arch}/initrd.gz"

  $appendargs = [
    "initrd=${initrd}",
    'auto',
    'locale=en_US',
    'console-setup/layoutcode=us',
    "url=${seed_url}",
    "netcfg/get_hostname=${get_hostname}",
    "netcfg/choose_interface=${boot_interface}",
    'text',
  ]

  pxe::menu::host { $hwaddr:
    kernel => $kernel,
    append => inline_template('<% @appendargs.each do |arg| %><%= @arg %> <% end %>'),
  }

}

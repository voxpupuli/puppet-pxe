define pxe::host (
    $hwaddr,
    $arch,
    $ver,
    $get_hostname="unassigned-hostname",
    $boot_interface="eth0",
    $seed_url='http://tork.znet/bootstrap/maverick.cfg'
    ) {

  $kernel = "images/ubuntu/$ver/$arch/linux"
  $initrd = "images/ubuntu/$ver/$arch/initrd.gz"
  $appendargs = [
    "initrd=$initrd",
    "auto",
    "locale=en_US",
    "console-setup/layoutcode=us",
    "url=$seed_url",
    "netcfg/get_hostname=$get_hostname",
    "netcfg/choose_interface=$boot_interface",
    "text",
  ]

  pxe::menu::host { 
    "$hwaddr": 
      kernel => "$kernel",
      append => inline_template("<% appendargs.each do |arg| %><%= arg %> <% end %>"),
  }

}

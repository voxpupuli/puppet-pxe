# ----------
# Server Setup
# ----------
class { 'pxe': }

# ----------
# Basic images for manuall install
# ----------
permute { 'Debian Installers':
  resource => 'pxe::installer',
  unique   => {
    arch => ['amd64','i386'],
    ver  => ['squeeze','wheezy','jessie'],
    os   => 'debian'
  },
  common   => {
    file   => 'os_<%= @os %>',
    kernel => 'images/<%= @os %>/<%= @ver %>/<%= @arch %>/linux',
    append => 'initrd=images/<%=@os%>/<%=@ver%>/<%=@arch%>/initrd.gz text',
  },
}

permute { 'CentOS Installers':
  resource => 'pxe::installer',
  unique   => {
    arch => ['x86_64','i386'],
    ver  => [5,6],
    os   => 'centos'
  },
  common   => {
    file   => 'os_<%= @os %>',
    kernel => 'images/<%= @os %>/<%= @ver %>/<%= @arch %>/vmlinuz',
    append => 'initrd=images/<%=@os%>/<%=@ver%>/<%=@arch%>/initrd.img text',
  },
}

#permute { 'Fedora Installers':
#  resource => 'pxe::installer',
#  unique   => {
#    arch => ['x86_64','i386'],
#    ver  => '15',
#    os   => 'fedora'
#  },
#  common   => {
#    baseurl => 'http://mirrors.kernel.org/fedora/releases/<%= @ver %>/Fedora/<%= @arch %>/os/images/pxeboot/',
#    file    => 'os_<%= @os %>',
#    kernel  => 'images/<%= @os %>/<%= @ver %>/<%= @arch %>/vmlinuz',
#    append  => 'initrd=images/<%= @os %>/<%= @ver %>/<%= @arch %>/initrd.img text',
#  },
#}

# ----------
# FreeBSD and Friends
# ----------
#permute { 'FreeBSD and Friends':
#  resource => 'pxe::installer',
#  unique   => {
#    arch => ['amd64'],
#    ver  => 'se-9.0-RELEASE',
#    os   => 'mfsbsd'
#  },
#  common   => {
#    file   => 'os_<%= @os %>',
#    kernel => 'memdisk raw',
#    append => 'initrd=images/mfsbsd/<%= @os %>-<%= @ver %>-<%= @arch %>.img'
#  },
#}

# ----------
# ESXi
# ----------
pxe::menu::entry { 'ESXi 5.0':
  file   => 'menu_install',
  kernel => 'images/esxi50/mboot.c32',
  append => '-c images/esxi50/boot.cfg',
}

pxe::menu::entry { 'ESXi 5.1':
  file   => 'menu_install',
  kernel => 'images/esxi51/mboot.c32',
  append => '-c images/esxi51/boot.cfg',
}

# ----------
# Operations
# ----------
pxe::menu { 'Deployments': file => 'menu_deploy', }

permute { 'Debian Ops':
  resource => 'pxe::menu::installentry',
  unique   => {
    arch => ['amd64'],
    ver  => ['squeeze','wheezy'],
    os   => ['debian'],
  },
  common   => {
    file      => 'menu_deploy',
    kernel    => 'images/<%= @os %>/<%= @ver %>/<%= @arch %>/linux',
    append    => 'initrd=images/<%= @os %>/<%= @ver %>/<%= @arch %>/initrd.gz auto locale=en_US console-keymaps-at/keymap=us hostname=<%= @os %> domain=<%= @domain %> url=http://boot.<%= @domain %>/d-i/debian_ops.cfg text suite=<%= @ver %>',
    menutitle => 'Operations auto-deployment <%=@os%> <%=@ver%> <%=@arch%>',
  },
}


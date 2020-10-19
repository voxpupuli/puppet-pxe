require 'spec_helper'

describe 'pxe::installer' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) { facts.merge(concat_basedir: '/dne') }

      context 'simple' do
        let(:title) { 'debian_potato_amd64' }
        let(:params) do
          {
            arch: 'amd64',
            ver: 'potato',
            os: 'debian',
            file: 'os_debian',
            kernel: 'images/debian/potato/amd64/linux',
            append: 'initrd=images/debian/potato/amd64/initrd.gz text'
          }
        end

        it do
          is_expected.to contain_pxe__installer('debian_potato_amd64')
          is_expected.to contain_pxe__menu__entry('Installer: debian potato amd64').with('kernel' => 'images/debian/potato/amd64/linux',
                                                                                         'append' => 'initrd=images/debian/potato/amd64/initrd.gz text')
        end
        it { is_expected.to contain_archive('/srv/tftp/images/debian/potato/amd64/initrd.gz') }
        it { is_expected.to contain_archive('/srv/tftp/images/debian/potato/amd64/linux') }
        it { is_expected.to contain_archive('/srv/tftp/tools/memtest86+-4.20.bin.gz') }
        it { is_expected.to contain_class('Pxe::Tools::Memtest') }
        it { is_expected.to contain_class('Pxe::Tools') }
        it { is_expected.to contain_class('Pxe') }
        it { is_expected.to contain_concat__Fragment('default-menu-entry-System Installers') }
        it { is_expected.to contain_concat__Fragment('default-menu-entry-Tools') }
        it { is_expected.to contain_concat__Fragment('menu_Debian-header') }
        it { is_expected.to contain_concat__Fragment('menu_Main Menu-header') }
        it { is_expected.to contain_concat__Fragment('menu_System Installers-header') }
        it { is_expected.to contain_concat__Fragment('menu_Tools-header') }
        it { is_expected.to contain_concat__Fragment('menu_install-menu-entry-Debian') }
        it { is_expected.to contain_concat__Fragment('menu_tools-menu-entry-Memtest86+') }
        it { is_expected.to contain_concat__Fragment('os_debian-menu-entry-Installer: debian potato amd64') }
        it { is_expected.to contain_concat('/srv/tftp/pxelinux.cfg/default') }
        it { is_expected.to contain_concat('/srv/tftp/pxelinux.cfg/menu_install') }
        it { is_expected.to contain_concat('/srv/tftp/pxelinux.cfg/menu_tools') }
        it { is_expected.to contain_concat('/srv/tftp/pxelinux.cfg/os_debian') }
        it { is_expected.to contain_file('/srv/tftp/images/debian/potato/amd64') }
        it { is_expected.to contain_file('/srv/tftp/images/debian/potato') }
        it { is_expected.to contain_file('/srv/tftp/images/debian') }
        it { is_expected.to contain_file('/srv/tftp/images') }
        it { is_expected.to contain_file('/srv/tftp/tools/memtest86+') }
        it { is_expected.to contain_file('/srv/tftp/tools') }
        it { is_expected.to contain_pxe__Images__Debian('debian potato amd64') }
        it { is_expected.to contain_pxe__Images__Resources('debian potato amd64') }
        it { is_expected.to contain_pxe__Images('debian potato amd64') }
        it { is_expected.to contain_pxe__Menu__Entry('Debian') }
        it { is_expected.to contain_pxe__Menu__Entry('Memtest86+') }
        it { is_expected.to contain_pxe__Menu__Entry('System Installers') }
        it { is_expected.to contain_pxe__Menu__Entry('Tools') }
        it { is_expected.to contain_pxe__Menu('Debian') }
        it { is_expected.to contain_pxe__Menu('Main Menu') }
        it { is_expected.to contain_pxe__Menu('System Installers') }
        it { is_expected.to contain_pxe__Menu('Tools') }
      end
    end
  end
end

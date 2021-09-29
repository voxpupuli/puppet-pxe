require 'spec_helper'

describe 'pxe::syslinux::system' do
  context 'should install package syslinux' do
    let(:params) do
      {
        syslinux_dir: '/var/lib/syslinux',
        tftp_root: '/srv/tftp'
      }
    end

    it { is_expected.to contain_package('syslinux') }
    it { is_expected.to contain_file('/srv/tftp/pxelinux.0') }
    it { is_expected.to contain_File('/srv/tftp/syslinux/memdisk') }
    it { is_expected.to contain_File('/srv/tftp/syslinux/menu.c32') }
    it { is_expected.to contain_file('/srv/tftp/syslinux/reboot.c32') }
    it { is_expected.to contain_file('/srv/tftp/syslinux/ldlinux.c32') }
    it { is_expected.to contain_file('/srv/tftp/syslinux/libutil.c32') }
    it { is_expected.to contain_file('/srv/tftp/syslinux/vesamenu.c32') }
  end
end

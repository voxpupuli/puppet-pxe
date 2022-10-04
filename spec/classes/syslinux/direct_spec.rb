# frozen_string_literal: true

require 'spec_helper'

describe 'pxe::syslinux::direct' do
  context 'should contain pxe::syslinux::direct class' do
    let(:params) do
      {
        syslinux_dir: '/usr/local/src/syslinux-6.03',
        syslinux_archive: 'https://www.kernel.org/pub/linux/utils/boot/syslinux/6.xx/syslinux-6.03.tar.gz',
        tftp_root: '/srv/tftp'
      }
    end

    it { is_expected.to contain_class('pxe::syslinux::direct') }
    it { is_expected.to contain_archive('/usr/local/src/syslinux-6.03.tar.gz') }
    it { is_expected.to contain_file('/srv/tftp/pxelinux.0') }
    it { is_expected.to contain_file('/srv/tftp/syslinux/ldlinux.c32') }
    it { is_expected.to contain_file('/srv/tftp/syslinux/libcom32.c32') }
    it { is_expected.to contain_file('/srv/tftp/syslinux/libutil.c32') }
    it { is_expected.to contain_file('/srv/tftp/syslinux/memdisk') }
    it { is_expected.to contain_file('/srv/tftp/syslinux/menu.c32') }
    it { is_expected.to contain_file('/srv/tftp/syslinux/reboot.c32') }
    it { is_expected.to contain_file('/srv/tftp/syslinux/vesamenu.c32') }
    it { is_expected.to contain_file('/usr/local/src/syslinux-6.03') }
  end
end

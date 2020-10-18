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

    it do
      is_expected.to contain_class('pxe::syslinux::direct')
    end
  end
end

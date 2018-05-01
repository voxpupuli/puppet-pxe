require 'spec_helper'

describe 'pxe::syslinux::system' do
  context 'should install package syslinux' do
    let(:params) do
      {
        syslinux_dir: '/var/lib/syslinux',
        tftp_root: '/srv/tftp'
      }
    end

    it do
      is_expected.to contain_package('syslinux')
    end
  end
end

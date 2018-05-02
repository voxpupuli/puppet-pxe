require 'spec_helper'

describe 'pxe::syslinux' do
  context 'can install a specific version of syslinux' do
    let(:title) { 'pxe_syslinux_direct' }
    let(:params) do
      {
        system_syslinux_dir: '6.02',
        tftp_root: '/srv/tftp',
        syslinux_version: '6.02'
      }
    end

    it do
      is_expected.to contain_class('pxe::syslinux::direct')
      is_expected.to contain_file('/srv/tftp')
      is_expected.to contain_file('/srv/tftp/syslinux')
      is_expected.to contain_file('/srv/tftp/pxelinux.cfg')
    end
  end

  context 'can install system syslinux' do
    let(:title) { 'pxe_syslinux_system' }
    let(:params) do
      {
        system_syslinux_dir: 'system',
        tftp_root: '/srv/tftp',
        syslinux_version: 'system'
      }
    end

    it do
      is_expected.to contain_class('pxe::syslinux::system')
    end
  end

  context 'fail on bad input' do
    let(:title) { 'pxe_syslinux_fail_on_bad_input' }
    let(:params) do
      {
        system_syslinux_dir: 'ABCD',
        tftp_root: '/should/fail',
        syslinux_version: 'ABCD'
      }
    end

    it do
      is_expected.to compile.and_raise_error(%r{Invalid Syslinux Version})
    end
  end
end

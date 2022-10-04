# frozen_string_literal: true

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

    it { is_expected.to contain_class('pxe::syslinux::direct') }
    it { is_expected.to contain_file('/srv/tftp') }
    it { is_expected.to contain_file('/srv/tftp/syslinux') }
    it { is_expected.to contain_file('/srv/tftp/pxelinux.cfg') }
    it { is_expected.to contain_archive('/usr/local/src/syslinux-6.02.tar.gz') }
    it { is_expected.to contain_class('Pxe::Params') }
    it { is_expected.to contain_file('/usr/local/src/syslinux-6.02') }
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

    it { is_expected.to contain_class('pxe::syslinux::system') }
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

    it { is_expected.to compile.and_raise_error(%r{Invalid Syslinux Version}) }
  end
end

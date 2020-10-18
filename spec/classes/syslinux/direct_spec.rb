require 'spec_helper'

describe 'pxe::syslinux::direct' do
  context 'should contain pxe::syslinux::direct class' do
    it do
      is_expected.to compile.with_all_deps
      is_expected.to contain_class('pxe::syslinux::direct')
    end
  end
end

require 'spec_helper'

describe 'pxe::installer' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) { facts.merge({:concat_basedir => '/dne'}) }

      context 'simple' do
        let(:title) { 'debian_potato_amd64' }
        let(:params) { {
          :arch => 'amd64',
          :ver => 'potato',
          :os => 'debian',
          :file => 'os_debian',
          :kernel => 'images/debian/potato/amd64/linux',
          :append => 'initrd=images/debian/potato/amd64/initrd.gz text'
        } }

        it do
          is_expected.to contain_pxe__installer('debian_potato_amd64')
          is_expected.to contain_pxe__menu__entry('Installer: debian potato amd64').with({
            'kernel' => 'images/debian/potato/amd64/linux',
            'append' => 'initrd=images/debian/potato/amd64/initrd.gz text'
          })
        end
      end

    end
  end
end

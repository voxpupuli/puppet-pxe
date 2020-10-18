require 'spec_helper'

describe 'pxe::tools' do
  context 'should contain pxe::tools class' do
    let(:params) do
      {
        tftp_root: '/srv/tftp'
      }
    end

    it do
      is_expected.to contain_class('pxe::tools')
    end
  end
end

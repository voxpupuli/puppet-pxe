require 'spec_helper'

describe 'pxe::tools::memtest' do
  context 'should contain pxe::tools::memtest class' do
    let(:params) do
      {
        url: 'http://www.memtest.org/download/4.20/memtest86+-4.20.bin.gz',
        tftp_root: '/srv/tftp'
      }
    end

    it do
      is_expected.to contain_class('pxe::tools::memtest')
    end
  end
end

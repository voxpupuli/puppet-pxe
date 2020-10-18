require 'spec_helper'

describe 'pxe::tools::memtest' do
  context 'should contain pxe::tools::memtest class' do
    it do
      is_expected.to compile.with_all_deps
      is_expected.to contain_class('pxe::tools::memtest')
    end
  end
end

# frozen_string_literal: true

require 'spec_helper'

describe 'pxe' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) { facts.merge(concat_basedir: '/dne') }

      it { is_expected.to compile.with_all_deps }
      it { is_expected.to contain_class('pxe') }
      it { is_expected.to contain_class('pxe::tools') }
      it { is_expected.to contain_class('pxe::tools::memtest') }
    end
  end
end

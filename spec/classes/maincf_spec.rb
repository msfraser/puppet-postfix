require 'spec_helper'
describe 'postfix::maincf' do
  on_supported_os.each do |os, facts|
    let(:facts) do
      facts
    end

    let(:pre_condition) do
      [
        'class { "postfix": }',
      ]
    end

    context "on #{os}" do
      context 'with default values for all parameters' do
        it { is_expected.to contain_class('postfix::maincf') }
      end

      it 'main config' do
        is_expected.to contain_concat('/etc/postfix/main.cf')
        is_expected.to contain_concat__fragment('/etc/postfix/main.cf-head')
        is_expected.to contain_concat__fragment('/etc/postfix/main.cf-parameters')
      end
    end
  end
end

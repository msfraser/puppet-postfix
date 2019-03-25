require 'spec_helper'
describe 'postfix::mynetworks' do
  on_supported_os.each do |os, facts|
    let(:facts) do
      facts
    end

    let(:pre_condition) do
      [
        'class { "postfix":
          manage_mynetworks => false,
        }',
      ]
    end

    context "on #{os}" do
      context 'with default values for all parameters' do
        it { is_expected.to contain_class('postfix::mynetworks') }

        it 'mynetworks table' do
          is_expected.to contain_postfix__postmap('/etc/postfix/mynetworks')
          is_expected.to contain_concat('/etc/postfix/mynetworks')
          is_expected.to contain_concat__fragment('/etc/postfix/mynetworks-head')
          is_expected.to contain_exec('/etc/postfix/mynetworks-generate-postmap')
        end
      end
    end
  end
end

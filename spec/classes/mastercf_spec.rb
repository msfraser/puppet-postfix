require 'spec_helper'
describe 'postfix::mastercf' do
  on_supported_os.each do |os, facts|
    let(:facts) do
      facts
    end

    let(:pre_condition) do
      [
        'class { "postfix":
          manage_mastercf => false,
        }',
      ]
    end

    context "on #{os}" do
      context 'with default values for all parameters' do
        it { is_expected.to contain_class('postfix::mastercf') }

        it 'master config' do
          is_expected.to contain_concat('/etc/postfix/master.cf')
          is_expected.to contain_concat__fragment('/etc/postfix/master.cf-head')
          is_expected.to contain_concat__fragment('/etc/postfix/master.cf-default-processes')
        end

        it 'smtp server process' do
          is_expected.to contain_postfix__mastercf__process('smtp')
        end
      end

      context 'with manage_smtp=false' do
        let(:params) do
          {
            'manage_smtp' => false,
          }
        end

        it 'smtp server process' do
          is_expected.not_to contain_postfix__mastercf__process('smtp')
        end
      end
    end
  end
end

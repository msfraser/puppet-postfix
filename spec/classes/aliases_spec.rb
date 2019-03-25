require 'spec_helper'
describe 'postfix::aliases' do
  on_supported_os.each do |os, facts|
    let(:facts) do
      facts
    end

    let(:pre_condition) do
      [
        'class { "postfix":
          manage_aliases => false,
        }',
      ]
    end

    context "on #{os}" do
      context 'with default values for all parameters' do
        it { is_expected.to contain_class('postfix::aliases') }

        it 'aliases table' do
          is_expected.to contain_concat('/etc/aliases')
          is_expected.to contain_exec('/etc/aliases-generate-postmap')
          is_expected.to contain_postfix__postmap('/etc/aliases')
          is_expected.to contain_concat__fragment('/etc/aliases-head')
          is_expected.to contain_postfix__aliases__fragment('default_entries')
          is_expected.to contain_postfix__postmap__Fragment('/etc/aliases-default_entries')
          is_expected.to contain_concat__fragment('/etc/aliases-default_entries-fragment')
        end
      end

      context 'with manage_default_entries=false' do
        let(:params) do
          {
            'manage_default_entries' => false,
          }
        end

        it 'aliases table' do
          is_expected.not_to contain_postfix__postmap__Fragment('/etc/aliases-default_entries')
          is_expected.not_to contain_concat__fragment('/etc/aliases-default_entries-fragment')
        end
      end
    end
  end
end

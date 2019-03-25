require 'spec_helper'
describe 'postfix::install' do
  on_supported_os.each do |os, facts|
    let(:facts) do
      facts
    end

    context "on #{os}" do
      context 'with default values for all parameters' do
        let(:pre_condition) do
          [
            'class { "postfix": }',
          ]
        end

        it { is_expected.to contain_class('postfix::install') }

        it 'software installation' do
          is_expected.to contain_package('postfix')
        end
      end

      context 'with manage_install=false' do
        let(:pre_condition) do
          [
            'class { "postfix":
              manage_install => false,
            }',
          ]
        end

        it 'software installation' do
          is_expected.not_to contain_package('postfix')
        end
      end
    end
  end
end

require 'spec_helper'
describe 'postfix::service' do
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

        it { is_expected.to contain_class('postfix::service') }

        it 'system service' do
          is_expected.to contain_service('postfix')
        end
      end

      context 'with manage_service=false' do
        let(:pre_condition) do
          [
            'class { "postfix":
              manage_service => false,
            }',
          ]
        end

        it 'system service' do
          is_expected.not_to contain_service('postfix')
        end
      end
    end
  end
end

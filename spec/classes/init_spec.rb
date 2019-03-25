require 'spec_helper'
describe 'postfix' do
  on_supported_os.each do |os, facts|
    let(:facts) do
      facts
    end

    context "on #{os}" do
      context 'with default values for all parameters' do
        it { is_expected.to contain_class('postfix') }

        it 'base classes' do
          is_expected.to contain_class('postfix::defaults')
          is_expected.to contain_class('postfix::install')
          is_expected.to contain_class('postfix::service')
        end

        it 'optional features' do
          is_expected.to contain_class('postfix::maincf')
          is_expected.to contain_class('postfix::mastercf')
          is_expected.to contain_class('postfix::mynetworks')
          is_expected.to contain_postfix__maincf__param('mynetworks')
          is_expected.to contain_class('postfix::aliases')
        end
      end

      context 'with manage_maincf=false with manage_mynetworks=true' do
        let(:params) { { 'manage_maincf' => false } }

        it 'catalog' do
          is_expected.to compile.and_raise_error(%r{manage_maincf must be enabled})
        end
      end

      context 'with manage_maincf=false with manage_mynetworks=false' do
        let(:params) do
          {
            'manage_maincf' => false,
            'manage_mynetworks' => false,
          }
        end

        it 'optional features' do
          is_expected.not_to contain_class('postfix::maincf')
          is_expected.not_to contain_class('postfix::mynetworks')
          is_expected.not_to contain_postfix__maincf__param('mynetworks')
        end
      end

      context 'with manage_mastercf=false' do
        let(:params) { { 'manage_mastercf' => false } }

        it 'optional features' do
          is_expected.not_to contain_class('postfix::mastercf')
        end
      end

      context 'with manage_mynetworks=false' do
        let(:params) { { 'manage_mynetworks' => false } }

        it 'optional features' do
          is_expected.not_to contain_class('postfix::mynetworks')
          is_expected.not_to contain_postfix__maincf__param('mynetworks')
        end
      end

      context 'with manage_aliases=false' do
        let(:params) { { 'manage_aliases' => false } }

        it 'optional features' do
          is_expected.not_to contain_class('postfix::aliases')
        end
      end
    end
  end
end

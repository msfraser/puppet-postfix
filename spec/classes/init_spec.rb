require 'spec_helper'
describe 'postfix' do
  context 'with default values for all parameters' do
    let(:facts) do
      {
        osfamily: 'Debian',
        os: {
          name: 'Debian',
        },
      }
    end

    it { is_expected.to contain_class('postfix') }
  end
end

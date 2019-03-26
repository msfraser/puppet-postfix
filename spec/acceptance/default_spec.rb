require 'spec_helper_acceptance'

describe 'postfix class' do
  let(:manifest) { "class { 'postfix': }" }

  it 'runs without errors' do
    result = apply_manifest(manifest, catch_failures: true)
    expect(result.exit_code).to eq 2
  end

  describe package('postfix') do
    it { is_expected.to be_installed }
  end

  describe service('postfix') do
    it { is_expected.to be_enabled }
    it { is_expected.to be_running }
  end

  describe port(25) do
    it { is_expected.to be_listening.on('127.0.0.1').with('tcp') }
  end
end

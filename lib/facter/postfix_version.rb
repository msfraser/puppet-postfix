Facter.add(:postfix_version) do
  confine kernel: ['Linux']
  setcode do
    if Facter::Util::Resolution.which('postconf')
      mail_version = Facter::Util::Resolution.exec('postconf -d mail_version 2>&1')
      %r{^mail_version = ([\d\.]+)$}.match(mail_version)[1]
    end
  end
end

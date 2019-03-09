# configure a dovecot local delivery process
class postfix::dovecot_lda {
  postfix::maincf::param { 'dovecot_destination_recipient_limit':
    value => 1,
  }
  postfix::maincf::param { 'virtual_transport':
    value => 'dovecot',
  }

  postfix::mastercf::process { 'dovecot':
    type    => 'unix',
    private => true,
    unpriv  => false,
    chroot  => false,
    wakeup  => undef,
    maxproc => undef,
    comment => 'local dovecot mail delivery',
    command => "pipe
      flags=DRhu user=vmail:vmail argv=/usr/lib/dovecot/dovecot-lda -f \${sender} -d \${recipient}"
  }
}

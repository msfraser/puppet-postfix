# @api public
# @summary configure a submission service
class postfix::submission (
  $process_name = 'submission',
  $tls_security_level = 'encrypt',
  $sasl_authenticated_header = true,
  $client_restrictions = 'permit_sasl_authenticated,reject',
  $data_restrictions = '',
  $recipient_restrictions = 'permit_sasl_authenticated, reject',
  $sender_restrictions = 'reject_non_fqdn_sender, reject_sender_login_mismatch, permit_sasl_authenticated, reject',
  $smtpd_proxy_filter = '',
) {
  $syslog_name = "postfix/${process_name}"

  postfix::maincf::param { "${process_name}_tls_security_level":
    value => $tls_security_level,
  }
  postfix::maincf::param { "${process_name}_sasl_authenticated_header":
    value => $sasl_authenticated_header,
  }
  postfix::maincf::param { "${process_name}_client_restrictions":
    value => $client_restrictions,
  }
  postfix::maincf::param { "${process_name}_data_restrictions":
    value => $data_restrictions,
  }
  postfix::maincf::param { "${process_name}_recipient_restrictions":
    value => $recipient_restrictions,
  }
  postfix::maincf::param { "${process_name}_sender_restrictions":
    value => $sender_restrictions,
  }
  postfix::maincf::param { "${process_name}_smtpd_proxy_filter":
    value => $smtpd_proxy_filter,
  }

  postfix::mastercf::process { $process_name:
    type    => 'inet',
    private => false,
    unpriv  => true,
    chroot  => false,
    wakeup  => undef,
    maxproc => undef,
    comment => "${process_name} service",
    command => "smtpd
      -o syslog_name=${syslog_name}
      -o smtpd_tls_security_level=\$${process_name}_tls_security_level
      -o smtpd_sasl_auth_enable=yes
      -o smtpd_sasl_authenticated_header=\$${process_name}_sasl_authenticated_header
      -o smtpd_client_restrictions=\$${process_name}_client_restrictions
      -o smtpd_data_restrictions=\$${process_name}_data_restrictions
      -o smtpd_recipient_restrictions=\$${process_name}_recipient_restrictions
      -o smtpd_sender_restrictions=\$${process_name}_sender_restrictions
      -o smtpd_proxy_filter=\$${process_name}_smtpd_proxy_filter"
  }
}

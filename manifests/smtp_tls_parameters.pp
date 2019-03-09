# @api public
# @summary manage the smtp tls parameters
#
# This class manages the smtp client TLS settings.
#
# @example Basic usage
#
#   class { 'postfix::smtp_tls_parameters':
#     enable_dane => true,
#   }
#
# @param enable_dane
#   Set to `true` to enable DANE.
#
#   This will set `smtp_tls_security_level` to `dane`
#   and `smtp_dns_support_level` to `dnssec`.
class postfix::smtp_tls_parameters (
  $enable_dane = false,
) {
  $system_ca_bundle = $::postfix::install::system_ca_bundle

  postfix::maincf::param { 'smtp_tls_protocols':
    value => '!SSLv2,!SSLv3',
  }
  postfix::maincf::param { 'smtp_tls_mandatory_protocols':
    value => '!SSLv2,!SSLv3',
  }
  postfix::maincf::param { 'smtp_tls_loglevel':
    value => '1',
  }
  postfix::maincf::param { 'tls_disable_workarounds':
    value => '0xFFFFFFFF',
  }

  postfix::maincf::param { 'smtp_tls_CAfile':
    value => $system_ca_bundle,
  }

  if( $enable_dane ) {
    postfix::maincf::param { 'smtp_tls_security_level':
      value => 'dane'
    }
    postfix::maincf::param { 'smtp_dns_support_level':
      value => 'dnssec',
    }
  }
}

# @api public
# @summary use case for configuring sasl authentication
#
# This class will generate the settings required for SASL
# authentication.
#
# @example Basic usage for dovecot
#
#   class { 'postfix::sasl': }
#
# @param type
#   Postfix `smtpd_sasl_type` setting.
# @param path
#   Postfix `smtpd_sasl_path` setting.
# @param broken_clients
#   Postfix `broken_sasl_auth_clients` setting.
# @param security_options
#   Postfix `smtpd_sasl_security_options` setting.
# @param tls_security_options
#   Postfix `smtpd_sasl_tls_security_options` setting.
# @param smtpd_tls_auth_only
#   Postfix `smtpd_tls_auth_only` setting.
class postfix::sasl(
  $type = 'dovecot',
  $path = 'private/auth',
  $broken_clients = true,
  $security_options = 'noanonymous, noplaintext',
  $tls_security_options = 'noanonymous',
  $tls_auth_only = true,
) {
  postfix::maincf::param { 'smtpd_sasl_type':
    value => $type,
  }
  postfix::maincf::param { 'smtpd_sasl_path':
    value => $path,
  }
  postfix::maincf::param { 'broken_sasl_auth_clients':
    value => $broken_clients,
  }
  postfix::maincf::param { 'smtpd_sasl_security_options':
    value => $security_options,
  }
  postfix::maincf::param { 'smtpd_sasl_tls_security_options':
    value => $tls_security_options,
  }
  postfix::maincf::param { 'smtpd_tls_auth_only':
    value => $tls_auth_only,
  }
}

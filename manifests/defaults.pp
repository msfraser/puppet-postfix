# @api private
# @summary provide default values for module parameters
class postfix::defaults {
  $manage_install = true
  $manage_service = true
  $ensure_service = 'running'
  $enable_service = true
  $manage_maincf = true
  $manage_mastercf = true
  $manage_mynetworks = true

  case $facts['os']['name'] {
    'Debian': {
      $install_source = 'vendor'
      $package_name = 'postfix'
    }
    default: {
      fail('operating system not supported by module')
    }
  }

  # main.cf options
  $myorigin = $facts['fqdn']
  $smtpd_banner = "${::fqdn} ESMTP"
  $biff = 'no'
  $append_dot_mydomain = 'no'
  $compatibility_level = '2'
  $smtpd_use_tls = 'true'
  $smtpd_tls_cert_file = '/etc/ssl/certs/ssl-cert-snakeoil.pem'
  $smtpd_tls_key_file = '/etc/ssl/private/ssl-cert-snakeoil.key'
  $smtpd_tls_session_cache_database = 'btree:${data_directory}/smtpd_scache'
  $smtp_tls_session_cache_database = 'btree:${data_directory}/smtp_scache'
  $smtpd_relay_restrictions = [
    'permit_mynetworks',
    'permit_sasl_authenticated',
    'defer_unauth_destination'
  ]
  $myhostname = $facts['fqdn']
  $alias_maps = [ 'hash:/etc/aliases' ]
  $alias_database = [ 'hash:/etc/aliases' ]
  $mydestination = [
    $facts['fqdn'],
    "localhost.${::domain}",
    'localhost'
  ]
  $mynetworks = [
    '127.0.0.0/8',
    '[::ffff:127.0.0.0]/104',
    '[::1]/128'
  ]
  $mailbox_size_limit = '0'
  $recipient_delimiter = '+'
  $inet_interfaces = 'loopback-only'
  $inet_protocols = 'all'

  # mastercf options
  $smtpd_maxproc = undef
  $smtpd_options = []
  $manage_smtp = true
  $manage_default_processes = true
}

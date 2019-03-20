# @api public
# @summary manage postfix main.cf
class postfix::maincf (
  $ensure = 'present',
  $smtpd_banner = $::postfix::smtpd_banner,
  $biff = $::postfix::biff,
  $append_dot_mydomain = $::postfix::append_dot_mydomain,
  $compatibility_level = $::postfix::compatibility_level,
  $smtpd_tls_cert_file = $::postfix::smtpd_tls_cert_file,
  $smtpd_tls_key_file = $::postfix::smtpd_tls_key_file,
  $smtpd_use_tls = $::postfix::smtpd_use_tls,
  $smtpd_tls_session_cache_database = $::postfix::smtpd_tls_session_cache_database,
  $smtp_tls_session_cache_database = $::postfix::smtp_tls_session_cache_database,
  $myhostname = $::postfix::myhostname,
  $myorigin = $::postfix::myorigin,
  $mailbox_size_limit = $::postfix::mailbox_size_limit,
  $recipient_delimiter = $::postfix::recipient_delimiter,
  $inet_interfaces = $::postfix::inet_interfaces,
  $inet_protocols = $::postfix::inet_protocols,

  # lists
  $smtpd_relay_restrictions = $::postfix::smtpd_relay_restrictions,
  $alias_maps = $::postfix::alias_maps,
  $alias_database = $::postfix::alias_database,
  $mydestination = $::postfix::mydestination,
  $mynetworks = $::postfix::mynetworks,

  # installation paths
  $readme_directory = $::postfix::install::readme_directory,
) {
  $etc_dir = $::postfix::install::etc_dir
  $path = "${etc_dir}/main.cf"
  $manage_service = $::postfix::manage_service
  $service_name = $::postfix::install::service_name
  $have_postfix_3_0 = $postfix::have_postfix_3_0

  concat { $path:
    ensure => $ensure,
    owner  => 'root',
    group  => 'root',
    mode   => '0640',
  }
  if( $manage_service ) {
    Concat[$path] ~> Service[$service_name]
  }
  concat::fragment{ "${path}-head":
    target  => $path,
    content => template('postfix/maincf/head.erb'),
    order   => '01'
  }
  concat::fragment{ "${path}-parameters":
    target  => $path,
    content => template('postfix/maincf/parameters.erb'),
    order   => '02'
  }
}

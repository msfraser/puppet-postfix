# @api public
# @summary install, configure and manage postfix and tables
class postfix (
  $manage_install = $::postfix::defaults::manage_install,
  $manage_service = $::postfix::defaults::manage_service,
  $ensure_service = $::postfix::defaults::ensure_service,
  $enable_service = $::postfix::defaults::enable_service,
  $install_source = $::postfix::defaults::install_source,
  $package_name = $::postfix::defaults::package_name,
  $manage_maincf = $::postfix::defaults::manage_maincf,
  $manage_mastercf = $::postfix::defaults::manage_mastercf,
  $manage_mynetworks = $::postfix::defaults::manage_mynetworks,
  $manage_aliases = $::postfix::defaults::manage_aliases,
  $version = $::postfix::defaults::version,

  # main.cf options
  $myorigin = $::postfix::defaults::myorigin,
  $smtpd_banner = $::postfix::defaults::smtpd_banner,
  $biff = $::postfix::defaults::biff,
  $append_dot_mydomain = $::postfix::defaults::append_dot_mydomain,
  $compatibility_level = $::postfix::defaults::compatibility_level,
  $smtpd_use_tls = $::postfix::defaults::smtpd_use_tls,
  $smtpd_tls_cert_file = $::postfix::defaults::smtpd_tls_cert_file,
  $smtpd_tls_key_file = $::postfix::defaults::smtpd_tls_key_file,
  $smtpd_tls_session_cache_database = $::postfix::defaults::smtpd_tls_session_cache_database,
  $smtp_tls_session_cache_database = $::postfix::defaults::smtp_tls_session_cache_database,
  $smtpd_relay_restrictions = $::postfix::defaults::smtpd_relay_restrictions,
  $myhostname = $::postfix::defaults::myhostname,
  $alias_maps = $::postfix::defaults::alias_maps,
  $alias_database = $::postfix::defaults::alias_database,
  $mydestination = $::postfix::defaults::mydestination,
  $mynetworks = $::postfix::defaults::mynetworks,
  $mailbox_size_limit = $::postfix::defaults::mailbox_size_limit,
  $recipient_delimiter = $::postfix::defaults::recipient_delimiter,
  $inet_interfaces = $::postfix::defaults::inet_interfaces,
  $inet_protocols = $::postfix::defaults::inet_protocols,

  # mastercf options
  $smtpd_maxproc= $::postfix::defaults::smtpd_maxproc,
  $smtpd_options= $::postfix::defaults::smtpd_options,
  $manage_smtp= $::postfix::defaults::manage_smtp,
  $manage_default_processes= $::postfix::defaults::manage_default_processes,
  $chroot = $postfix::defaults::chroot
) inherits postfix::defaults {
  $have_postfix_3_0 = versioncmp($version, '3') >= 0

  class { 'postfix::install': }
  class { 'postfix::service': }

  if( $manage_maincf ) {
    class { 'postfix::maincf': }
  }
  if( $manage_mastercf ) {
    class { 'postfix::mastercf': }
  }
  if( $manage_mynetworks ) {
    if( ! $manage_maincf ) {
      fail('manage_maincf must be enabled for manage_mynetworks!')
    }

    class { 'postfix::mynetworks': }

    $this_mynetworks = $mynetworks << "${postfix::mynetworks::type}:${postfix::mynetworks::path}"
    postfix::maincf::param { 'mynetworks':
      value => inline_template('<%= @this_mynetworks.join(\' \') %>'),
    }
  }
  if( $manage_aliases ) {
    class { 'postfix::aliases': }
  }
}

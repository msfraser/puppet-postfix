# postfix use case for virtual hosting
class postfix::virtual_hosting (
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
  $inet_interfaces = 'all',
  $inet_protocols = $::postfix::defaults::inet_protocols,

  # mastercf options
  $smtpd_maxproc= $::postfix::defaults::smtpd_maxproc,
  $smtpd_options= $::postfix::defaults::smtpd_options,

  $message_size_limit = 52428800,
  
  $content_filter = false,
  $smtpd_proxy_filter = false,
  $enable_dane = false,
  $enable_submission = false,
  $submission_smtpd_proxy_filter = '',
) inherits postfix::defaults {
  class { 'postfix':
    myorigin => $myorigin,
    smtpd_banner => $smtpd_banner,
    biff => $biff,
    append_dot_mydomain => $append_dot_mydomain,
    compatibility_level => $compatibility_level,
    smtpd_use_tls => $smtpd_use_tls,
    smtpd_tls_cert_file => $smtpd_tls_cert_file,
    smtpd_tls_key_file => $smtpd_tls_key_file,
    smtpd_tls_session_cache_database => $smtpd_tls_session_cache_database,
    smtp_tls_session_cache_database => $smtp_tls_session_cache_database,
    smtpd_relay_restrictions => $smtpd_relay_restrictions,
    myhostname => $myhostname,
    alias_maps => $alias_maps,
    alias_database => $alias_database,
    mydestination => $mydestination,
    mynetworks => $mynetworks,
    mailbox_size_limit => $mailbox_size_limit,
    recipient_delimiter => $recipient_delimiter,
    inet_interfaces => $inet_interfaces,
    inet_protocols => $inet_protocols,
    smtpd_maxproc => $smtpd_maxproc,
    smtpd_options => $smtpd_options,
  }

  postfix::maincf::param { 'message_size_limit':
    value => $message_size_limit,
  }
  
  class { 'postfix::access': }
  postfix::maincf::param { 'smtpd_client_restrictions':
		value => "check_client_access hash:${::postfix::access::path}",
	}

  class { 'postfix::virtual_aliases':}
  postfix::maincf::param { 'virtual_alias_maps':
    value => "hash:${::postfix::virtual_aliases::path}",
  }
  class { 'postfix::virtual_alias_domains':}
  postfix::maincf::param { 'virtual_alias_domains':
    value => "hash:${::postfix::virtual_alias_domains::path}",
  }

  class { 'postfix::virtual_mailboxes':}
  postfix::maincf::param { 'virtual_mailbox_maps':
    value => "hash:${::postfix::virtual_mailboxes::path}",
  }
  class { 'postfix::virtual_mailbox_domains':}
  postfix::maincf::param { 'virtual_mailbox_domains':
    value => "hash:${::postfix::virtual_mailbox_domains::path}",
  }

  class { 'postfix::reject_bogus_ip': }
  postfix::maincf::param { 'smtpd_recipient_restrictions':
    value => "permit_mynetworks,
      reject_unauth_pipelining,
      check_sender_mx_access cidr:/etc/postfix/reject_bogus_ip.cidr
      check_sender_ns_access cidr:/etc/postfix/reject_bogus_ip.cidr
      reject_non_fqdn_recipient,
      reject_invalid_helo_hostname,
      reject_unknown_recipient_domain,
      reject_unauth_destination,
      check_policy_service { inet:127.0.0.1:12345, 
        timeout=10s,
        default_action=DUNNO
      },
      permit",
  }
  postfix::maincf::param { 'smtpd_sender_restrictions':
    value => 'reject_non_fqdn_sender,
      reject_unknown_sender_domain',
  }

  if( $content_filter ) {
    class { 'postfix::content_filter': }
  } elsif( $smtpd_proxy_filter ) {
    class { 'postfix::smtpd_proxy_filter': }
  }

  if( $enable_submission ) {
    class { 'postfix::submission':
      smtpd_proxy_filter => $submission_smtpd_proxy_filter,
    }
    class { 'postfix::sasl': }
    class { 'postfix::sender_login_map': }
    postfix::maincf::param { 'smtpd_sender_login_maps':
      value => "hash:${postfix::sender_login_map::path}",
    }
  }

  class { 'postfix::smtp_tls_parameters':
    enable_dane => $enable_dane,
  }
  class { 'postfix::dovecot_lda': }
}

# @api public
# @summary configure smtp proxy content filtering
class postfix::content_filter (
  $content_filter_name = 'smtp-amavis',
  $content_filter_host = '[127.0.0.1]',
  $content_filter_port = '10024',
  $content_filter_inject = '127.0.0.1:10025',
) {
  postfix::maincf::param { 'content_filter':
    value => "${content_filter_name}:${content_filter_host}:${content_filter_port}",
  }
  postfix::mastercf::process { $content_filter_name:
    type    => 'unix',
    private => true,
    unpriv  => true,
    chroot  => false,
    wakeup  => undef,
    maxproc => undef,
    comment => 'delivery for sending mail to content filter',
    command => "smtp
      -o smtp_data_done_timeout=1800
      -o disable_dns_lookups=yes
      -o smtp_send_xforward_command=yes
      -o max_use=20
      -o smtp_bind_address=127.0.0.1",
  }
  postfix::mastercf::process { $content_filter_inject:
    type    => 'inet',
    private => false,
    unpriv  => true,
    chroot  => false,
    wakeup  => undef,
    maxproc => 100,
    comment => 'Listener to re-inject email from content filter into Postfix',
    command => "smtpd
      -o content_filter=
      -o local_recipient_maps=
      -o relay_recipient_maps=
      -o smtpd_restriction_classes=
      -o smtpd_client_restrictions=
      -o smtpd_helo_restrictions=
      -o smtpd_sender_restrictions=
      -o smtpd_recipient_restrictions=permit_mynetworks,reject
      -o mynetworks=127.0.0.0/8
      -o smtpd_authorized_xforward_hosts=127.0.0.0/8
      -o smtpd_end_of_data_restrictions=",
  }
}

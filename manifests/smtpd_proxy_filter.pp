# @api public
# @summary configure smtp before-queue proxy filter
#
# This class will configure an smtp content filter to be used
# by postfix. For example amavisd-new.
#
# It will create an `smtpd_proxy_filter` entry in main.cf to
# send mail to the content filter and an incoming smtpd
# process in master.cf for mail re-injection.
#
# @example Basic usage
#
#   class { 'postfix::smtpd_proxy_filter':
#     # Send mail to an content filter
#     smtpd_proxy_filter => '127.0.0.1:10024',
#     # accept mail re-injection from content filter
#     smtpd_proxy_inject => '127.0.0.1:10025'
#   }
#
# @param smtpd_proxy_filter
#   Where to send mail for filtering.
# @param smtpd_proxy_inject
#   Listening port to accept mail re-injection.
class postfix::smtpd_proxy_filter (
  $smtpd_proxy_filter = '127.0.0.1:10024',
  $smtpd_proxy_inject = '127.0.0.1:10025',
) {
  postfix::maincf::param { 'smtpd_proxy_filter':
    value => $smtpd_proxy_filter,
  }
  postfix::mastercf::process { $smtpd_proxy_inject:
    type    => 'inet',
    private => false,
    unpriv  => true,
    chroot  => false,
    wakeup  => undef,
    maxproc => 100,
    comment => 'Listener to re-inject email from content filter into Postfix',
    command => "smtpd
      -o content_filter=
      -o smtpd_proxy_filter=
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

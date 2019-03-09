# @api public
# @summary creates the sender_login_map table
#
# @example Basic usage
#
#   postfix::maincf::param { 'smtpd_sender_login_maps':
#     value => "hash:${postfix::sender_login_map::path}",
#   }
#   class { 'postfix::sender_login_map': }
#   postfix::sender_login_map::row { 'root@mydomain.tld':
#     value => 'bob',
#   }
#
class postfix::sender_login_map {
  $etc_dir = $::postfix::install::etc_dir
  $path = "${etc_dir}/sender_login_map"

  postfix::postmap { $path:
    description => 'postfix sender_login_map table'
  }
}

# @api public
# @summary generate an entry in the sender_login_map table
#
# @example Basic usage
#
#   class { 'postfix::sender_login_map': }
#   postfix::sender_login_map::row { 'root@mydomain.tld':
#     value => 'bob',
#   }
define postfix::sender_login_map::row (
  $value,
  $order = 50,
  $comment = undef,
) {
  $sender_login_map_path = $::postfix::sender_login_map::path

  postfix::postmap::row { "${sender_login_map_path}-${name}":
    postmap => $sender_login_map_path,
    key     => $name,
    value   => $value,
    order   => $order,
    comment => $comment,
  }
}

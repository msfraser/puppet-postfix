# @api public
# @summary creates an entry in the virtual_mailbox_domains table
#
# @example Basic usage
#
#   class { 'postfix::virtual_mailbox_domains': }
#   postfix::virtual_mailbox_domains::row { 'mydomain.tld': }
#
define postfix::virtual_mailbox_domains::row (
  $value = 'OK',
  $order = 50,
  $comment = undef,
) {
  $virtual_mailbox_domains_path = $::postfix::virtual_mailbox_domains::path

  postfix::postmap::row { "${virtual_mailbox_domains_path}-${name}":
    postmap => $virtual_mailbox_domains_path,
    key     => $name,
    value   => $value,
    order   => $order,
    comment => $comment,
  }
}

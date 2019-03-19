# @api public
# @summary creates an entry in the virtual_mailboxes table
define postfix::virtual_mailboxes::row (
  $value,
  $order = 50,
  $comment = undef,
) {
  $virtual_mailboxes_path = $::postfix::virtual_mailboxes::path

  postfix::postmap::row { "${virtual_mailboxes_path}-${name}":
    postmap => $virtual_mailboxes_path,
    key     => $name,
    value   => $value,
    order   => $order,
    comment => $comment,
  }
}

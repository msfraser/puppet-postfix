# @api public
# @summary creates an entry in the virtual_aliases table
define postfix::virtual_aliases::row (
  $value,
  $order = 50,
  $comment = undef,
) {
  $virtual_aliases_path = $::postfix::virtual_aliases::path

  postfix::postmap::row { "${virtual_aliases_path}-${name}":
    postmap => $virtual_aliases_path,
    key     => $name,
    value   => $value,
    order   => $order,
    comment => $comment,
  }
}

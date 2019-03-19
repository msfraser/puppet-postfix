# @api public
# @summary creates an entry within the access table
define postfix::access::row (
  $value,
  $order = 50,
  $comment = undef,
) {
  $access_path = $::postfix::access::path

  postfix::postmap::row { "${access_path}-${name}":
    postmap => $access_path,
    key     => $name,
    value   => $value,
    order   => $order,
    comment => $comment,
  }
}

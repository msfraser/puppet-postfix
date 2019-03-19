# @api public
# @summary creates a row within an postfix::postmap
define postfix::postmap::row (
  $postmap,
  $key,
  $value,
  $comment = undef,
  $order = 50,
) {
  concat::fragment{ "${name}-row":
    target  => $postmap,
    content => template('postfix/postmap/row.erb'),
    order   => $order,
  }
}

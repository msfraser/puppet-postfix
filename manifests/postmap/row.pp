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

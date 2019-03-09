define postfix::mynetworks::row (
  $value = 'OK',
  $order = 50,
  $comment = undef,
) {
  $mynetworks_path = $::postfix::mynetworks::path

  postfix::postmap::row { "${mynetworks_path}-${name}":
    postmap => $mynetworks_path,
    key     => $name,
    value   => $value,
    order   => $order,
    comment => $comment,
  }
}

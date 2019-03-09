define postfix::reject_bogus_ip::row (
  $action = 'REJECT',
  $message = undef,
  $order = 50,
  $comment = undef,
) {
  $reject_bogus_ip_path = $::postfix::reject_bogus_ip::path
  if( $message ) {
    $value = "${action} ${message}"
  } else {
    $value = $action
  }

  postfix::postmap::row { "${reject_bogus_ip_path}-${name}":
    postmap => $reject_bogus_ip_path,
    key     => $name,
    value   => $value,
    order   => $order,
    comment => $comment,
  }
}

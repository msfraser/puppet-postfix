define postfix::access::fragment (
  $content,
  $order = 50,
) {
  $access_path = $::postfix::access::path

  postfix::postmap::fragment { "${access_path}-${name}":
    postmap => $access_path,
    content => $content,
    order   => $order,
  }
}

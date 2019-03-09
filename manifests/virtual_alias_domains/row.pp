define postfix::virtual_alias_domains::row (
  $value = 'OK',
  $order = 50,
  $comment = undef,
) {
  $virtual_alias_domains_path = $::postfix::virtual_alias_domains::path

  postfix::postmap::row { "${virtual_alias_domains_path}-${name}":
    postmap => $virtual_alias_domains_path,
    key     => $name,
    value   => $value,
    order   => $order,
    comment => $comment,
  }
}

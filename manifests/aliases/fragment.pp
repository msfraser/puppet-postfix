# @api public
# @summary creates a fragment within the aliases table
define postfix::aliases::fragment (
  $content,
  $order = 50,
) {
  $aliases_path = $::postfix::aliases::path

  postfix::postmap::fragment { "${aliases_path}-${name}":
    postmap => $aliases_path,
    content => $content,
    order   => $order,
  }
}

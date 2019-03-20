# @api public
# @summary creates a row within an postfix::postmap
define postfix::postmap::row (
  $postmap,
  $key,
  $value,
  $comment = undef,
  $order = 50,
  $template_file = 'postfix/postmap/row.erb',
) {
  concat::fragment{ "${postmap}-${name}-row":
    target  => $postmap,
    content => template($template_file),
    order   => $order,
  }
}

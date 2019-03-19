# @api public
# @summary creates an fragment with a postfix::postmap
define postfix::postmap::fragment (
  $postmap,
  $content,
  $order = 50,
) {
  concat::fragment{ "${name}-fragment":
    target  => $postmap,
    content => $content,
    order   => $order,
  }
}

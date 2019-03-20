# @api public
# @summary creates an entry within the aliases table
define postfix::aliases::row (
  $value,
  $order = 50,
  $comment = undef,
) {
  $aliases_path = $::postfix::aliases::path

  postfix::postmap::row { "${aliases_path}-${name}":
    postmap       => $aliases_path,
    key           => $name,
    value         => $value,
    order         => $order,
    comment       => $comment,
    template_file => 'postfix/postalias/row.erb',
  }
}

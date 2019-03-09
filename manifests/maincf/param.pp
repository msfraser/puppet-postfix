define postfix::maincf::param (
  $value,
  $comment = undef,
  $order = 50,
) {
  $maincf_path = $::postfix::maincf::path

  concat::fragment{ "${maincf_path}-${name}":
    target  => $maincf_path,
    content => template('postfix/maincf/param.erb'),
    order   => $order,
  }
}

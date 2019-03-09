class postfix::mynetworks (
  # you may want to switch to cidr
  $type = 'hash',
) {
  $etc_dir = $::postfix::install::etc_dir
  $path = "${etc_dir}/mynetworks"

  postfix::postmap { $path:
    description => 'postfix mynetworks table',
    type        => $type,
  }
}

class postfix::virtual_alias_domains {
  $etc_dir = $::postfix::install::etc_dir
  $path = "${etc_dir}/virtual_alias_domains"

  postfix::postmap { $path:
    description => 'table for postfix virtual alias domains'
  }
}

class postfix::virtual_aliases {
  $etc_dir = $::postfix::install::etc_dir
  $path = "${etc_dir}/virtual_aliases"

  postfix::postmap { $path:
    description => 'table for postfix virtual aliases'
  }
}

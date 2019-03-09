class postfix::virtual_mailbox_domains {
  $etc_dir = $::postfix::install::etc_dir
  $path = "${etc_dir}/virtual_mailbox_domains"

  postfix::postmap { $path:
    description => 'table for postfix virtual mailbox domains'
  }
}

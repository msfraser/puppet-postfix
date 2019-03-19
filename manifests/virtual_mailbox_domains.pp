# @api public
# @summary manage the virtual_mailbox_domains table
class postfix::virtual_mailbox_domains {
  $etc_dir = $::postfix::install::etc_dir
  $path = "${etc_dir}/virtual_mailbox_domains"

  postfix::postmap { $path:
    description => 'table for postfix virtual mailbox domains'
  }
}

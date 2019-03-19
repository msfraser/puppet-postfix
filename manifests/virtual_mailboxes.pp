# @api public
# @summary manages the virtual_mailboxes tables
class postfix::virtual_mailboxes {
  $etc_dir = $::postfix::install::etc_dir
  $path = "${etc_dir}/virtual_mailboxes"

  postfix::postmap { $path:
    description => 'table for postfix virtual mailboxes'
  }
}

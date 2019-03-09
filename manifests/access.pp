# @api public
# @summary manage postfix access table
class postfix::access {
  $etc_dir = $::postfix::install::etc_dir
  $path = "${etc_dir}/access"

  postfix::postmap { $path:
    description => 'postfix access table'
  }
}

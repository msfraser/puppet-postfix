# @api public
# @summary manage the virtual_alias_domains table
#
# @example Basic usage
#
#   class { 'postfix::virtual_alias_domains': }
#   postfix::virtual_alias_domains::row { 'mydomain.tld': }
#
class postfix::virtual_alias_domains {
  $etc_dir = $::postfix::install::etc_dir
  $path = "${etc_dir}/virtual_alias_domains"

  postfix::postmap { $path:
    description => 'table for postfix virtual alias domains'
  }
}

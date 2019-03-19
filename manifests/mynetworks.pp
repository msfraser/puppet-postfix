# @api public
# @summary manage the mynetworks table
#
# @example Basic usage
#
#   class { 'postfix::mynetworks': }
#   postfix::mynetworks::row { '123.234.234': }
#
# @param type
#   By default uses an hash type table.
#
#   You may want to change this to 'cidr'.
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

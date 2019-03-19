# @api public
# @summary resource for an mynetworks entry
#
# @example Basic usage
#
#   postfix::mynetworks::row { '192.168.2.3/24' }
#
# @param value
#   The value for this key.
# @param order
#   Use this priority if ordering is required.
#   Otherwise stay with the default.
# @param comment
#   An optional comment to insert into mynetworks
#   for this entry.
define postfix::mynetworks::row (
  $value = 'OK',
  $order = 50,
  $comment = undef,
) {
  $mynetworks_path = $::postfix::mynetworks::path

  postfix::postmap::row { "${mynetworks_path}-${name}":
    postmap => $mynetworks_path,
    key     => $name,
    value   => $value,
    order   => $order,
    comment => $comment,
  }
}

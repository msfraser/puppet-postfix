# @api public
# @summary resource for an virtual_alias_domains entry
#
# @example Basic usage
#
#   postfix::virtual_alias_domains::row { 'mydomain.tld' }
#
# @param value
#   The value for this key.
# @param order
#   Use this priority if ordering is required.
#   Otherwise stay with the default.
# @param comment
#   An optional comment to insert into mynetworks
#   for this entry.
define postfix::virtual_alias_domains::row (
  $value = 'OK',
  $order = 50,
  $comment = undef,
) {
  $virtual_alias_domains_path = $::postfix::virtual_alias_domains::path

  postfix::postmap::row { "${virtual_alias_domains_path}-${name}":
    postmap => $virtual_alias_domains_path,
    key     => $name,
    value   => $value,
    order   => $order,
    comment => $comment,
  }
}

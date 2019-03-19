# @api public
# @summary add a domain for virtual_hosting
#
# @example Basic usage
#
#   class { 'postfix::virtual_hosting': }
#   postfix::virtual_hosting::domain { 'mydomain.tld': }
#
define postfix::virtual_hosting::domain (
) {
  postfix::virtual_mailbox_domains::row { $name: }
}

# @api public
# @summary creates an user in an postfix::virtual_hosting setup
#
# @example Basic usage
#
#   postfix::virtual_hosting::user { 'user@mydomain.tld':
#     aliases => ['bob@mydomain.tld'],
#   }
#
# @param comment
#   An optional comment to leave in postfix tables for this entry
# @param aliases
#   A list of aliases for this user.
# @param incoming
#   By default will setup entries in
#
#   * virtual_mailboxes
#   * virtual_aliases
#
#   tables for incoming mail configuration.
# @param outgoing
#   By default will setup entries in
#
#   * sender_login_map
#
#   for outgoing mail configuration.
define postfix::virtual_hosting::user (
  $comment = undef,
  $aliases = [],
  $incoming = true,
  $outgoing = true,
) {
  if( $incoming ) {
    postfix::virtual_mailboxes::row { $name:
      value   => $name,
      comment => $comment,
    }
    $aliases.each |String $alias| {
      postfix::virtual_aliases::row { $alias:
        value => $name,
      }
    }
  }

  if( $outgoing ) {
    postfix::sender_login_map::row { $name:
      value   => $name,
      comment => $comment,
    }
    $aliases.each |String $alias| {
      postfix::sender_login_map::row { $alias:
        value => $name,
      }
    }
  }
}

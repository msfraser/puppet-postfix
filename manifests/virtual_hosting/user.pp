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

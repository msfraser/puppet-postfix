# @api public
# @summary configure hosts for relay access
#
# Will create an entry in the mynetworks table for each address.
# It requires that the mynetworks table is configured by
# `postfix::mynetworks`.
#
# @param addresses
#   Array of addresses to add for relay access.
define postfix::relay_access (
  $addresses = [],
) {
  $addresses.each |String $address| {
    postfix::mynetworks::row { $address:
      comment => "relay access for ${name}",
    }
  }
}

# @api public
# @summary configure an reject_bogus_ip table
#
# The generated table will contain entries to reject
# invalid and private network addresses.
#
# @param manage_default_entries
#   By default the table will contain a default preset.
#   Set to false to disable default preset.
class postfix::reject_bogus_ip (
  $manage_default_entries = true,
) {
  $etc_dir = $::postfix::install::etc_dir
  $path = "${etc_dir}/reject_bogus_ip.cidr"

  postfix::postmap { $path:
    description => 'reject private address ranges',
    type        => 'cidr',
  }

  if( $manage_default_entries ) {
    postfix::reject_bogus_ip::row { '0.0.0.0/8':
      message => 'Bogus NS/MX in broadcast network',
      comment => 'IPv4 networks'
    }
    postfix::reject_bogus_ip::row { '10.0.0.0/8':
      message => 'Bogus NS/MX in RFC 1918 private network',
    }
    postfix::reject_bogus_ip::row { '127.0.0.0/8':
      message => 'Bogus NS/MX in loopback network',
    }
    postfix::reject_bogus_ip::row { '169.254.0.0/16':
      message => 'Bogus NS/MX in link lokal network',
    }
    postfix::reject_bogus_ip::row { '172.16.0.0/12':
      message => 'Bogus NS/MX in RFC 1918 private network',
    }
    postfix::reject_bogus_ip::row { '192.0.2.0/24':
      message => 'Bogus NS/MX in TEST-NET network',
    }
    postfix::reject_bogus_ip::row { '192.168.0.0/16':
      message => 'Bogus NS/MX in RFC 1918 private network',
    }
    postfix::reject_bogus_ip::row { '198.18.0.0/15':
      message => 'Bogus NS/MX in RFC 2544 benchmark network',
    }
    postfix::reject_bogus_ip::row { '224.0.0.0/4':
      message => 'Bogus NS/MX in class D multicast network',
    }
    postfix::reject_bogus_ip::row { '240.0.0.0/5':
      message => 'Bogus NS/MX in class E reserved network',
    }
    postfix::reject_bogus_ip::row { '248.0.0.0/5':
      message => 'Bogus NS/MX in reserved network',
    }

    postfix::reject_bogus_ip::row { '2000::/3':
      action  => 'DUNNO',
      order   => '60',
      comment => 'IPv6 networks'
    }
    postfix::reject_bogus_ip::row { '::/0':
      message => 'Bogus NS/MX not in 2000::/3',
      order   => '61',
    }
  }
}

# postfix

#### Table of Contents

1. [Description](#description)
1. [Setup - The basics of getting started with postfix](#setup)
    * [What postfix affects](#what-postfix-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with postfix](#beginning-with-postfix)
1. [Usage - Configuration options and additional functionality](#usage)
1. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
1. [Limitations - OS compatibility, etc.](#limitations)
1. [Development - Guide for contributing to the module](#development)

## Description

This module will install, configure and manage the postfix MTA
and its tables.

It also provides helpers and abstaction for common use cases:

* `postfix::content_filter` - configure a smtp content filter
* `postfix::dovecot_lda` - configure local delivery to dovecot mailboxes
* `postfix::nullmailer` - configure a local MTA for delivery to smart hosts
* `postfix::sasl` - configure SASL authentication
* `postfix::smtpd_proxy_filter` - configure a before-queue smtp content filter
* `postfix::submission` - configure a submission service
* `postfix::virtual_hosting` - configure virtual domain/mailbox hosting
* `postfix::smtp_tls_parameters` - configure TLS, DANE

## Setup

### What postfix affects

The module will configure and install postfix.

In the default configuration it will:

* manage the `postfix` packages
* manage the `postfix` services
* postfix configuration files
 * main.cf
 * master.cf

### Setup Requirements

Nothing special.

### Beginning with postfix

The module class `postfix` is used in all use case configuration
and can be used to start with an basic postfix configuration.

## Usage

Install, configure and start postfix.

```puppet
class { 'postfix': }
```

The core class contains parameters for basic main.cf settings:

```puppet
class { 'postfix':
  smtpd_banner = 'mymta',
}
```

Additional parameters can be set using `postfix::maincf::param`:

```puppet
class { 'postfix': }
postfix::maincf::param { 'message_size_limit':
  value => '10240',
  # optional comment...
  # comment => 'small is beautiful'
}
```

Or additional entries for the `master.cf` configuration:

```puppet
class { 'postfix': }
postfix::maincf::param { 'custom_smtpd_syslog_name':
  value => 'custom_mta',
}
postfix::mastercf::process { '127.0.0.1:10025':
  type    => 'inet',
  private => false,
  unpriv  => true,
  chroot  => false,
  wakeup  => undef,
  maxproc => undef,
	comment => "custom smtpd service",
  command => "smtpd
    -o syslog_name=\$custom_smtpd_syslog_name",
}
```

The module provides generic classes for generating postmap tables:

```puppet
$postmap = '/etc/postfix/mytable'
postfix::postmap { $postmap:
  # optional description
  description => 'my custom map'
}
postfix::postmap::row { 'example-mytable':
  postmap = $postmap,
  key => 'mykey',
  value => 'myvalue',
  # optional comment
  comment => 'just an example',
}
# or a complete fragment of entries
postfix::postmap::fragment { 'example-mytable':
  postmap => $postmap,
  content => template('mytemplate.postmap.erb'),
}
```

But it also provide specialized resources for common tables:

* `postfix::access`
* `postfix::mynetworks`
* `postfix::sender_login_map`
* `postfix::virtual_alias_domains`
* `postfix::virtual_aliases`
* `postfix::virtual_mailbox_domains`
* `postfix::virtual_mailboxes`

Example for using `postfix::mynetworks`:

```puppet
class { 'postfix::mynetworks': }
postfix::maincf::param { 'mynetworks':
  value => "127.0.0.0/8 [::1]/128 ${postfix::mynetworks::type}:${postfix::mynetworks::path}",
}
postfix::mynetworks::row { '192.168.3.32': }
postfix::mynetworks::row { '192.168.5.35': }
```

### Use cases

The module provides classes for specific use cases which will provide
the required parameters for `main.cf` and `master.cf` and also setup
the required tables with common presets.

Read the individual documentation of these classes on how they work.

Both the core module and the use case configurations can be extended
with additional resources.

This module provides predefined resources for additional
settings, to create common or individual tables, etc.

#### Use case: Basic local MTA

```puppet
class { 'postfix': }

class { 'postfix::access': }
postfix::access::row { 'root':
  value => 'bob@mydomain.tld',
}

postfix::maincf::param { 'relayhost':
  value => '[relayhost.mydomain.com]'
}
```

#### Use case example: nullmailer

An local MTA for relaying all mail to a smart host can be configured
using the `postfix::nullmailer` class:

```puppet
classe { 'postfix::nullmailer':
  relayhost => '[relay.example.com]'
}
```

#### Use case example: virtual_hosting

To setup a mailserver with virtual_hosting:

```puppet
class { 'postfix::virtual_hosting': }
# create domain in virtual_mailbox_domains
postfix::virtual_hosting::domain { 'mydomain.tld': }
postfix::virtual_hosting::user { 'bob@mydomain.tld':
  comment => 'This is bob',
  aliases => [ 'webmaster@mydomain.tld' ],
  # By default:
  #
  # * incoming => true,
  #   create entry in virtual_mailboxes
  #   create aliases in virtual_aliases
  # * outgoing => true,
  #   create sender_login_map entries for $name and aliases
}
```

## Reference

See [REFERENCE.md](REFERENCE.md)

## Limitations

The module is currently only tested on Debian systems.

No full coverage of documentation and automated tests yet.

## Development

This module is developed as an open source project.
Everyone is welcome to provide improvements.

The prefered way to contribute things is:

* Create an Issue to describe your problem, feature, bug
* Fork the repository to a private repository
* Create a feature branch to contain your changes
* If done create a Pull Request for integration of your changes


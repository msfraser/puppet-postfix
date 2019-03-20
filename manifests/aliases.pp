# @api public
# @summary manage system aliases table
class postfix::aliases (
  $manage_default_entries = true,
  $type = 'hash',
) {
  $path = $postfix::install::aliases_file
  $postalias_cmd = $postfix::install::postalias_cmd

  postfix::postmap { $path:
    description   => 'mail system local aliases',
    generator_cmd => $postalias_cmd,
    type          => $type,
  }

  if( $manage_default_entries ) {
    postfix::aliases::fragment { 'default_entries':
      order   => '10',
      content => '# default system aliases
mailer-daemon: postmaster
postmaster: root
nobody: root
hostmaster: root
usenet: root
news: root
webmaster: root
www: root
ftp: root
abuse: root
noc: root
security: root

',
    }
  }
}

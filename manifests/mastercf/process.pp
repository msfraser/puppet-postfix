# @api public
# @summary manage an process entry in the master.cf configuration
define postfix::mastercf::process (
  # process options
  $command,
  $type = 'inet',
  $private = true,
  $unpriv = true,
  $chroot = true,
  $wakeup = undef,
  $maxproc = undef,
  $options = [],
  # resource options
  $comment = undef,
  $order = 50,
) {
  $mastercf_path = $::postfix::mastercf::path

  concat::fragment{ "${mastercf_path}-${name}":
    target  => $mastercf_path,
    content => template('postfix/mastercf/process.erb'),
    order   => $order,
  }
}

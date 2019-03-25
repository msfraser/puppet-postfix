# @api public
# @summary manage postfix master.cf
#
# @example Basic usage
#
#   class { 'postfix::mastercf': }
#   postfix::mastercf::process { '127.0.0.1:10025':
#     type    => 'inet',
#     private => false,
#     unpriv  => true,
#     chroot  => false,
#     wakeup  => undef,
#     maxproc => undef,
#   	comment => "custom smtpd service",
#     command => "smtpd
#       -o syslog_name=\$custom_smtpd_syslog_name",
#   }
#
# @param ensure
#   Ensure status. Set to `present` or `absent`.
# @param smtpd_maxproc
#   Number of processes for the smtp process.
# @param smtpd_options
#   Options for the smtp process.
# @param manage_smtp
#   Could be used to disable the default smtp service line (port 25).
#   In case you want to manage it yourself.
# @param manage_default_processes
#   Could be used to disable the default master.cf processes.
#   In case you want to manage everything yourself.
#   Does not include the smtp process. See `manage_smtp` option.
# @param chroot
#   Enable chroot for service processes.
class postfix::mastercf (
  $ensure = 'present',
  $smtpd_maxproc = $postfix::smtpd_maxproc,
  $smtpd_options = $postfix::smtpd_options,
  $manage_smtp = $postfix::manage_smtp,
  $manage_default_processes= $postfix::manage_default_processes,
  $chroot = $postfix::chroot,
) {
  $etc_dir = $::postfix::install::etc_dir
  $path = "${etc_dir}/master.cf"
  $manage_service = $::postfix::manage_service
  $service_name = $::postfix::install::service_name

  concat { $path:
    ensure => $ensure,
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
  }
  if( $manage_service ) {
    Concat[$path] ~> Service[$service_name]
  }
  concat::fragment{ "${path}-head":
    target  => $path,
    content => template('postfix/mastercf/head.erb'),
    order   => '01'
  }
  if( $manage_smtp ) {
    postfix::mastercf::process { 'smtp':
      type    => 'inet',
      private => false,
      unpriv  => undef,
      chroot  => $chroot,
      wakeup  => undef,
      maxproc => $smtpd_maxproc,
      command => 'smtpd',
      options => $smtpd_options,
    }
  }
  if( $manage_default_processes ) {
    concat::fragment{ "${path}-default-processes":
      target  => $path,
      content => template('postfix/mastercf/default-processes.erb'),
      order   => '99'
    }
  }
}

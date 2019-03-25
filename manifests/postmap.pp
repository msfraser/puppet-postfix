# @api public
# @summary generic resource type to manage postmap tables
define postfix::postmap (
  $path = $name,
  $ensure = 'present',
  $content = undef,
  $description = 'postfix map',
  $type = 'hash',
  $generator_cmd = $postfix::install::postmap_cmd,
) {
  $etc_dir = $::postfix::install::etc_dir
  $generator = "${name}-generate-postmap"
  $manage_service = $::postfix::manage_service
  $service_name = $::postfix::install::service_name

  $generate = $type ? {
    'cidr'   => false,
    'pcre'   => false,
    'regexp' => false,
    default  => true,
  }

  if( $content ) {
    file { $path:
      ensure => $ensure,
      owner  => 'root',
      group  => 'root',
      mode   => '0644',
    }
    $map_resource = File[$path]
  } else {
    concat { $path:
      ensure => $ensure,
      owner  => 'root',
      group  => 'root',
      mode   => '0644',
    }
    concat::fragment{ "${name}-head":
      target  => $path,
      content => template('postfix/postmap/head.erb'),
      order   => '01'
    }
    $map_resource = Concat[$path]
  }
  if( $manage_service ) {
    $map_resource -> Service[$service_name]
  }
  if( $generate ) {
    exec { $generator:
      refreshonly => true,
      command     => "${generator_cmd} ${type}:${path}",
      path        => ['/usr/bin', '/usr/sbin'],
      cwd         => $etc_dir,
      subscribe   => $map_resource,
    }
    if( $manage_service ) {
      Exec[$generator] -> Service[$service_name]
    }
  }
}

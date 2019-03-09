# @api private
# @summary manage postfix installation
class postfix::install {
  $manage_install = $::postfix::manage_install
  $manage_service = $::postfix::manage_service
  $install_source = $::postfix::install_source
  $package_name = $::postfix::package_name

  if( $manage_install ) {
    if( $install_source == 'vendor' ) {
      $service_name = 'postfix'
      $etc_dir = '/etc/postfix'
      $postmap_cmd = '/usr/sbin/postmap'
      $readme_directory = 'no'
      $system_ca_bundle = '/etc/ssl/certs/ca-certificates.crt'
      package { $package_name:
        ensure        => 'present',
        allow_virtual => false,
      }
      if( $manage_service ) {
        Package[$package_name] ~> Service[$service_name]
      }
    }
  } else {
    $etc_dir = '/etc/postfix'
    $postmap_cmd = 'postmap'
  }
}

# @api private
# @summary manage postfix installation
class postfix::install {
  $manage_install = $::postfix::manage_install
  $manage_service = $::postfix::manage_service
  $install_source = $::postfix::install_source
  $package_name = $::postfix::package_name

  $etc_dir = '/etc/postfix'
  $aliases_file = '/etc/aliases'

  if( $manage_install ) {
    if( $install_source == 'vendor' ) {
      $service_name = 'postfix'
      $postmap_cmd = '/usr/sbin/postmap'
      $postalias_cmd = '/usr/sbin/postalias'
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
    $postmap_cmd = 'postmap'
    $postalias_cmd = 'postalias'
  }
}

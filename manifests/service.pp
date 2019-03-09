# @api private
# @summary manage the postfix system service
class postfix::service {
  $manage_service = $::postfix::manage_service
  $ensure_service = $::postfix::ensure_service
  $enable_service = $::postfix::enable_service
  $service_name = $::postfix::install::service_name

  if( $manage_service ) {
    service { $service_name:
      ensure => $ensure_service,
      enable => $enable_service,
    }
  }
}

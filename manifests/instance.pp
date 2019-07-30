# Definition: karaf::instance
define karaf::instance (
  $ensure                       = 'present',
  $install_from                 = $karaf::install_from,
  $rootdir                      = $karaf::rootdir,
  $service_name                 = undef,
  $service_group_name           = $karaf::service_group_name,
  $service_group_id             = $karaf::service_group_id,
  $service_user_name            = $karaf::service_user_name,
  $service_user_id              = $karaf::service_user_id,
  $file_maven_settings          = $karaf::file_maven_settings,
  $mvn_repositories             = $karaf::mvn_repositories,
  $file_karaf_logging           = $karaf::file_karaf_logging,
  $karaf_zip_url                = $karaf::karaf_zip_url,
  $karaf_file_name              = $karaf::karaf_file_name,
  $karaf_custom_properties      = $karaf::karaf_custom_properties,
  $karaf_users_definition       = $karaf::karaf_users_definition,
  $java_home                    = $karaf::java_home,
  $default_env_vars             = $karaf::default_env_vars,
  $karaf_version                = $karaf::version,
  $karaf_startup_feature_repos  = $karaf::karaf_startup_feature_repos,
  $karaf_startup_feature_boots  = $karaf::karaf_startup_feature_boots,
  $karaf_ssh_port               = $karaf::karaf_ssh_port,
  $karaf_ssh_host               = $karaf::karaf_ssh_host,
  $karaf_rmi_registry_host      = $karaf::karaf_rmi_registry_host,
  $karaf_rmi_registry_port      = $karaf::karaf_rmi_registry_port,
  $karaf_rmi_server_host        = $karaf::karaf_rmi_server_host,
  $karaf_rmi_server_port        = $karaf::karaf_rmi_server_port,
  $karaf_additional_repos       = $karaf::karaf_additional_repos,
  $karaf_configuration_properties = $karaf::karaf_configuration_properties,
) {

# ensure
  if ! ($ensure in [ 'present', 'absent' ]) {
    fail("\"${ensure}\" is not a valid ensure parameter value")
  }

  $_service_name = pick($service_name, $name)

  $_instance_root = "${rootdir}/${name}"

  karaf::instance::install { $name:
    ensure             => $ensure,
    install_from       => $install_from,
    instance_root      => $_instance_root,
    service_name       => $_service_name,
    service_group_name => $service_group_name,
    service_group_id   => $service_group_id,
    service_user_name  => $service_user_name,
    service_user_id    => $service_user_id,
    karaf_zip_url      => $karaf_zip_url,
    karaf_file_name    => $karaf_file_name,
  }

  if ($ensure == 'present') {
    karaf::instance::configuration { $name:
      instance_root                  => $_instance_root,
      service_user_name              => $service_user_name,
      service_group_name             => $service_group_name,
      file_maven_settings            => $file_maven_settings,
      mvn_repositories               => $mvn_repositories,
      java_home                      => $java_home,
      default_env_vars               => $default_env_vars,
      karaf_version                  => $karaf_version,
      karaf_startup_feature_repos    => $karaf_startup_feature_repos,
      karaf_startup_feature_boots    => $karaf_startup_feature_boots,
      karaf_configuration_properties => $karaf_configuration_properties,
    }
  }

  karaf::instance::service { $name:
    ensure             => $ensure,
    instance_root      => $_instance_root,
    service_name       => $_service_name,
    service_user_name  => $service_user_name,
    service_group_name => $service_group_name,
  }
}

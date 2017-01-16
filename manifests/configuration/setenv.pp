# PRIVATE CLASS - do not use directly
#
# Karaf set env variables.
class karaf::configuration::setenv inherits karaf {
  file { "${rootdir}/karaf/bin/setenv":
    ensure  => file,
    content => template("karaf/karaf/bin/setenv.erb"),
    owner   => $service_user_name,
    group   => $service_group_name
  }
}
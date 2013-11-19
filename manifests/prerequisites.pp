# Class: pgpool::prerequisites
#
# This class installs postgresql prerequisites
#
# == Variables
#
# Refer to pgpool class for the variables defined here.
#
# == Usage
#
# This class is not intended to be used directly.
# It's automatically included by pgpool if the parameter
# install_prerequisites is set to true
# Note: This class may contain resources available on the
# Example42 modules set
#
class pgpool::prerequisites {

  if $pgpool::bool_use_postgresql_repo {
    case $::operatingsystem {
      redhat,centos,scientific,oraclelinux : {
        require yum::repo::pgdg92
      }
      ubuntu,debian : {
        require apt::repo::postgresql
      }
      default: { }
    }
  }
}

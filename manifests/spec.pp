# Class: pgpool::spec
#
# This class is used only for rpsec-puppet tests
# Can be taken as an example on how to do custom classes but should not
# be modified.
#
# == Usage
#
# This class is not intended to be used directly.
# Use it as reference
#
class pgpool::spec inherits pgpool {

  # This just a test to override the arguments of an existing resource
  # Note that you can achieve this same result with just:
  # class { "pgpool": template => "pgpool/spec.erb" }

  File['pgpool.conf'] {
    content => template('pgpool/spec.erb'),
  }

}

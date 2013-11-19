# This define APPENDS a line entry to the pg_hba.conf file
#
define pgpool::hba (
  $type,
  $database,
  $user,
  $method,
  $ensure  = 'present',
  $order   = '50',
  $address = false,
  $option  = '' ) {

  include pgpool::hbaconcat

  $content = $type ? {
    'local' => "${type} ${database} ${user} ${method} ${option}\n",
    default => "${type} ${database} ${user} ${address}  ${method}   ${option}\n",
  }

  concat::fragment { "hba_fragment_${name}":
    ensure  => $ensure,
    target  => $pgpool::real_config_file_hba,
    content => $content,
    order   => $order,
    notify  => Service['pgpool'],
  }

}


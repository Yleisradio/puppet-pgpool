# Class: pgpool::hbaconcat
#
class pgpool::hbaconcat {

  include pgpool

  concat { $pgpool::real_config_file_hba:
    mode    => '0600',
    owner   => $pgpool::config_file_owner,
    group   => $pgpool::config_file_group,
    require => Package['pgpool'],
  }

  # The File Header. With Puppet comment
  concat::fragment { 'pgpool_hba_header':
    target  => $pgpool::real_config_file_hba,
    content => template($pgpool::template_hba_header),
    order   => '01',
    notify  => Service['pgpool'],
  }

  # The File Footer. With default acls
  concat::fragment { 'pgpool_hba_footer':
    target  => $pgpool::real_config_file_hba,
    content => template($pgpool::template_hba_footer),
    order   => '90',
    notify  => Service['pgpool'],
  }

}

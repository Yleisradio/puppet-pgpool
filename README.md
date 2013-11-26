# Puppet module: pgpool

This is a Puppet module for pgpool based on the second generation layout ("NextGen") of Example42 Puppet Modules.

Made by Andrew N Golovkov

Official site: http://github.com/andor/puppet-pgpool

Official git repository: http://github.com/andor/puppet-pgpool

Released under the terms of Apache 2 License.

This module requires functions provided by the Example42 Puppi module (you need it even if you don't use and install Puppi)

For detailed info about the logic and usage patterns of Example42 modules check the DOCS directory on Example42 main modules set.

## USAGE - Basic management

* Install pgpool with default settings

        class { 'pgpool': }

* Install a specific version of pgpool package

        class { 'pgpool':
          version => '1.0.1',
        }

* Disable pgpool service.

        class { 'pgpool':
          disable => true
        }

* Remove pgpool package

        class { 'pgpool':
          absent => true
        }

* Enable auditing without without making changes on existing pgpool configuration files

        class { 'pgpool':
          audit_only => true
        }


## USAGE - Overrides and Customizations
* Use custom sources for main config file 

        class { 'pgpool':
          source => [ "puppet:///modules/lab42/pgpool.conf-${hostname}" , "puppet:///modules/lab42/pgpool/pgpool.conf" ], 
        }


* Use custom source directory for the whole configuration dir

        class { 'pgpool':
          source_dir       => 'puppet:///modules/lab42/pgpool/conf/',
          source_dir_purge => false, # Set to true to purge any existing file not present in $source_dir
        }

* Use custom template for main config file. Note that template and source arguments are alternative. 

        class { 'pgpool':
          template => 'pgpool/pgpool.conf.erb',
        }

* Automatically include a custom subclass

        class { 'pgpool':
          my_class => 'pgpool::example42',
        }


## USAGE - Example42 extensions management 
* Activate puppi (recommended, but disabled by default)

        class { 'pgpool':
          puppi    => true,
        }

* Activate puppi and use a custom puppi_helper template (to be provided separately with a puppi::helper define ) to customize the output of puppi commands 

        class { 'pgpool':
          puppi        => true,
          puppi_helper => 'myhelper', 
        }

* Activate automatic monitoring (recommended, but disabled by default). This option requires the usage of Example42 monitor and relevant monitor tools modules

        class { 'pgpool':
          monitor      => true,
          monitor_tool => [ 'nagios' , 'monit' , 'munin' ],
        }

* Activate automatic firewalling. This option requires the usage of Example42 firewall and relevant firewall tools modules

        class { 'pgpool':
          firewall      => true,
          firewall_tool => 'iptables',
          firewall_src  => '10.42.0.0/24',
          firewall_dst  => $ipaddress_eth0,
        }


[![Build Status](https://travis-ci.org/Andor/puppet-pgpool.png?branch=master)](https://travis-ci.org/Andor/puppet-pgpool)

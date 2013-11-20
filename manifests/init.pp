# = Class: pgpool
#
# This is the main pgpool class
#
#
# == Parameters
#
# Module's specific parameters
#
# [*install_prerequisites*]
#   Set to false if you don't want install this module's prerequisites.
#   They include the addition of PostgreSQL repos (when use_postgresql_repo=true)
#   Via Example42 apt or yum modules.
#
# [*config_file_hba*]
#    Location of the hba file
#
# [*source_hba*]
#   Sets the content of source parameter for the hba configuration file
#   Note that single lines of hba file can be managed also (and alternatively)
#   by pgpool::hba
#
# [*template_hba*]
#   Sets the path to the template to use as content for hba configuration file
#   If defined, pgpool hba config file has: content => content("$template_hba")
#   Note source_hba and template_hba parameters are mutually exclusive: don't use both
#
# [*template_hba_header*]
#   Path to the header's template when using concat
#
# [*template_hba_footer*]
#   Path to the footer's template when using concat
#
# [*config_file_pcp*]
#    Location of the pcp file
#
# [*source_pcp*]
#   Sets the content of source parameter for the pcp configuration file
#
# [*template_pcp*]
#   Sets the path to the template to use as content for pcp configuration file
#   If defined, pgpool pcp config file has: content => content("$template_pcp")
#   Note source_pcp and template_pcp parameters are mutually exclusive: don't use both
#
# Standard class parameters
# Define the general class behaviour and customizations
#
# [*my_class*]
#   Name of a custom class to autoload to manage module's customizations
#   If defined, pgpool class will automatically "include $my_class"
#   Can be defined also by the (top scope) variable $pgpool_myclass
#
# [*source*]
#   Sets the content of source parameter for main configuration file
#   If defined, pgpool main config file will have the param: source => $source
#   Can be defined also by the (top scope) variable $pgpool_source
#
# [*source_dir*]
#   If defined, the whole pgpool configuration directory content is retrieved
#   recursively from the specified source
#   (source => $source_dir , recurse => true)
#   Can be defined also by the (top scope) variable $pgpool_source_dir
#
# [*source_dir_purge*]
#   If set to true (default false) the existing configuration directory is
#   mirrored with the content retrieved from source_dir
#   (source => $source_dir , recurse => true , purge => true)
#   Can be defined also by the (top scope) variable $pgpool_source_dir_purge
#
# [*template*]
#   Sets the path to the template to use as content for main configuration file
#   If defined, pgpool main config file has: content => content("$template")
#   Note source and template parameters are mutually exclusive: don't use both
#   Can be defined also by the (top scope) variable $pgpool_template
#
# [*options*]
#   An hash of custom options to be used in templates for arbitrary settings.
#   Can be defined also by the (top scope) variable $pgpool_options
#
# [*service_autorestart*]
#   Automatically restarts the pgpool service when there is a change in
#   configuration files. Default: true, Set to false if you don't want to
#   automatically restart the service.
#
# [*version*]
#   The package version, used in the ensure parameter of package type.
#   Default: present. Can be 'latest' or a specific version number.
#   Note that if the argument absent (see below) is set to true, the
#   package is removed, whatever the value of version parameter.
#   Please check [*use_postgresql_repo*] to see the expected behaviour when
#   both set.
#
# [*absent*]
#   Set to 'true' to remove package(s) installed by module
#   Can be defined also by the (top scope) variable $pgpool_absent
#
# [*disable*]
#   Set to 'true' to disable service(s) managed by module
#   Can be defined also by the (top scope) variable $pgpool_disable
#
# [*disableboot*]
#   Set to 'true' to disable service(s) at boot, without checks if it's running
#   Use this when the service is managed by a tool like a cluster software
#   Can be defined also by the (top scope) variable $pgpool_disableboot
#
# [*monitor*]
#   Set to 'true' to enable monitoring of the services provided by the module
#   Can be defined also by the (top scope) variables $pgpool_monitor
#   and $monitor
#
# [*monitor_tool*]
#   Define which monitor tools (ad defined in Example42 monitor module)
#   you want to use for pgpool checks
#   Can be defined also by the (top scope) variables $pgpool_monitor_tool
#   and $monitor_tool
#
# [*monitor_target*]
#   The Ip address or hostname to use as a target for monitoring tools.
#   Default is the fact $ipaddress
#   Can be defined also by the (top scope) variables $pgpool_monitor_target
#   and $monitor_target
#
# [*puppi*]
#   Set to 'true' to enable creation of module data files that are used by puppi
#   Can be defined also by the (top scope) variables $pgpool_puppi and $puppi
#
# [*puppi_helper*]
#   Specify the helper to use for puppi commands. The default for this module
#   is specified in params.pp and is generally a good choice.
#   You can customize the output of puppi commands for this module using another
#   puppi helper. Use the define puppi::helper to create a new custom helper
#   Can be defined also by the (top scope) variables $pgpool_puppi_helper
#   and $puppi_helper
#
# [*firewall*]
#   Set to 'true' to enable firewalling of the services provided by the module
#   Can be defined also by the (top scope) variables $pgpool_firewall
#   and $firewall
#
# [*firewall_tool*]
#   Define which firewall tool(s) (ad defined in Example42 firewall module)
#   you want to use to open firewall for pgpool port(s)
#   Can be defined also by the (top scope) variables $pgpool_firewall_tool
#   and $firewall_tool
#
# [*firewall_src*]
#   Define which source ip/net allow for firewalling pgpool. Default: 0.0.0.0/0
#   Can be defined also by the (top scope) variables $pgpool_firewall_src
#   and $firewall_src
#
# [*firewall_dst*]
#   Define which destination ip to use for firewalling. Default: $ipaddress
#   Can be defined also by the (top scope) variables $pgpool_firewall_dst
#   and $firewall_dst
#
# [*debug*]
#   Set to 'true' to enable modules debugging
#   Can be defined also by the (top scope) variables $pgpool_debug and $debug
#
# [*audit_only*]
#   Set to 'true' if you don't intend to override existing configuration files
#   and want to audit the difference between existing files and the ones
#   managed by Puppet.
#   Can be defined also by the (top scope) variables $pgpool_audit_only
#   and $audit_only
#
# Default class params - As defined in pgpool::params.
# Note that these variables are mostly defined and used in the module itself,
# overriding the default values might not affected all the involved components.
# Set and override them only if you know what you're doing.
# Note also that you can't override/set them via top scope variables.
#
# [*package*]
#   The name of pgpool package
#
# [*service*]
#   The name of pgpool service
#
# [*service_status*]
#   If the pgpool service init script supports status argument
#
# [*process*]
#   The name of pgpool process
#
# [*process_args*]
#   The name of pgpool arguments. Used by puppi and monitor.
#   Used only in case the pgpool process name is generic (java, ruby...)
#
# [*process_user*]
#   The name of the user pgpool runs with. Used by puppi and monitor.
#
# [*config_dir*]
#   Main configuration directory. Used by puppi
#
# [*config_file*]
#   Main configuration file path
#
# [*config_file_mode*]
#   Main configuration file path mode
#
# [*config_file_owner*]
#   Main configuration file path owner
#
# [*config_file_group*]
#   Main configuration file path group
#
# [*config_file_init*]
#   Path of configuration file sourced by init script
#
# [*pid_file*]
#   Path of pid file. Used by monitor
#
# [*data_dir*]
#   Path of application data directory. Used by puppi
#
# [*log_dir*]
#   Base logs directory. Used by puppi
#
# [*log_file*]
#   Log file(s). Used by puppi
#
# [*port*]
#   The listening port, if any, of the service.
#   This is used by monitor, firewall and puppi (optional) components
#   Note: This doesn't necessarily affect the service configuration file
#   Can be defined also by the (top scope) variable $pgpool_port
#
# [*protocol*]
#   The protocol used by the the service.
#   This is used by monitor, firewall and puppi (optional) components
#   Can be defined also by the (top scope) variable $pgpool_protocol
#
#
# == Examples
#
# You can use this class in 2 ways:
# - Set variables (at top scope level on in a ENC) and "include pgpool"
# - Call pgpool as a parametrized class
#
# See README for details.
#
#
# == Author
#   Andrew N Golovkov <andrew.golovkov@gmail.com>
#
class pgpool (
  $install_prerequisites = params_lookup( 'install_prerequisites' ),
  $config_file_hba       = params_lookup( 'config_file_hba' ),
  $source_hba            = params_lookup( 'source_hba' ),
  $template_hba          = params_lookup( 'template_hba' ),
  $template_hba_header   = params_lookup( 'template_hba_header' ),
  $template_hba_footer   = params_lookup( 'template_hba_footer' ),
  $template_pcp          = params_lookup( 'template_pcp' ),
  $config_file_pcp       = params_lookup( 'config_file_pcp' ),
  $source_pcp            = params_lookup( 'source_pcp' ),
  $my_class              = params_lookup( 'my_class' ),
  $source                = params_lookup( 'source' ),
  $source_dir            = params_lookup( 'source_dir' ),
  $source_dir_purge      = params_lookup( 'source_dir_purge' ),
  $template              = params_lookup( 'template' ),
  $service_autorestart   = params_lookup( 'service_autorestart' , 'global' ),
  $options               = params_lookup( 'options' ),
  $version               = params_lookup( 'version' ),
  $absent                = params_lookup( 'absent' ),
  $disable               = params_lookup( 'disable' ),
  $disableboot           = params_lookup( 'disableboot' ),
  $monitor               = params_lookup( 'monitor' , 'global' ),
  $monitor_tool          = params_lookup( 'monitor_tool' , 'global' ),
  $monitor_target        = params_lookup( 'monitor_target' , 'global' ),
  $puppi                 = params_lookup( 'puppi' , 'global' ),
  $puppi_helper          = params_lookup( 'puppi_helper' , 'global' ),
  $firewall              = params_lookup( 'firewall' , 'global' ),
  $firewall_tool         = params_lookup( 'firewall_tool' , 'global' ),
  $firewall_src          = params_lookup( 'firewall_src' , 'global' ),
  $firewall_dst          = params_lookup( 'firewall_dst' , 'global' ),
  $debug                 = params_lookup( 'debug' , 'global' ),
  $audit_only            = params_lookup( 'audit_only' , 'global' ),
  $package               = params_lookup( 'package' ),
  $service               = params_lookup( 'service' ),
  $service_status        = params_lookup( 'service_status' ),
  $process               = params_lookup( 'process' ),
  $process_args          = params_lookup( 'process_args' ),
  $process_user          = params_lookup( 'process_user' ),
  $config_dir            = params_lookup( 'config_dir' ),
  $config_file           = params_lookup( 'config_file' ),
  $config_file_mode      = params_lookup( 'config_file_mode' ),
  $config_file_owner     = params_lookup( 'config_file_owner' ),
  $config_file_group     = params_lookup( 'config_file_group' ),
  $config_file_init      = params_lookup( 'config_file_init' ),
  $pid_file              = params_lookup( 'pid_file' ),
  $data_dir              = params_lookup( 'data_dir' ),
  $log_dir               = params_lookup( 'log_dir' ),
  $log_file              = params_lookup( 'log_file' ),
  $port                  = params_lookup( 'port' ),
  $protocol              = params_lookup( 'protocol' )
  ) inherits pgpool::params {

  $bool_use_postgresql_repo=any2bool($postgresql::use_postgresql_repo)
  $bool_install_prerequisites = any2bool($install_prerequisites)
  $bool_source_dir_purge=any2bool($source_dir_purge)
  $bool_service_autorestart=any2bool($service_autorestart)
  $bool_absent=any2bool($absent)
  $bool_disable=any2bool($disable)
  $bool_disableboot=any2bool($disableboot)
  $bool_monitor=any2bool($monitor)
  $bool_puppi=any2bool($puppi)
  $bool_firewall=any2bool($firewall)
  $bool_debug=any2bool($debug)
  $bool_audit_only=any2bool($audit_only)

  ### Definition of some variables used in the module
  $manage_package = $pgpool::bool_absent ? {
    true  => 'absent',
    false => 'present',
  }

  $manage_service_enable = $pgpool::bool_disableboot ? {
    true    => false,
    default => $pgpool::bool_disable ? {
      true    => false,
      default => $pgpool::bool_absent ? {
        true  => false,
        false => true,
      },
    },
  }

  $manage_service_ensure = $pgpool::bool_disable ? {
    true    => 'stopped',
    default =>  $pgpool::bool_absent ? {
      true    => 'stopped',
      default => 'running',
    },
  }

  $manage_service_autorestart = $pgpool::bool_service_autorestart ? {
    true    => Service[pgpool],
    false   => undef,
  }

  $manage_file = $pgpool::bool_absent ? {
    true    => 'absent',
    default => 'present',
  }

  if $pgpool::bool_absent == true
  or $pgpool::bool_disable == true
  or $pgpool::bool_disableboot == true {
    $manage_monitor = false
  } else {
    $manage_monitor = true
  }

  if $pgpool::bool_absent == true
  or $pgpool::bool_disable == true {
    $manage_firewall = false
  } else {
    $manage_firewall = true
  }

  $manage_audit = $pgpool::bool_audit_only ? {
    true  => 'all',
    false => undef,
  }

  $manage_file_replace = $pgpool::bool_audit_only ? {
    true  => false,
    false => true,
  }

  $manage_file_source = $pgpool::source ? {
    ''        => undef,
    default   => $pgpool::source,
  }

  $manage_file_content = $pgpool::template ? {
    ''        => undef,
    default   => template($pgpool::template),
  }

  $manage_file_source_hba = $pgpool::source_hba ? {
    ''        => undef,
    default   => $pgpool::source_hba,
  }

  $manage_file_content_hba = $pgpool::template_hba ? {
    ''        => undef,
    default   => template($pgpool::template_hba),
  }

  $manage_file_source_pcp = $pgpool::source_pcp ? {
    ''        => undef,
    default   => $pgpool::source_pcp,
  }

  $manage_file_content_pcp = $pgpool::template_pcp ? {
    ''        => undef,
    default   => template($pgpool::template_pcp),
  }

### Calculation of internal variables according to user input
  $real_version = $pgpool::version ? {
    ''      => $pgpool::bool_use_postgresql_repo ? {
      true  => '3.3.1',
      false => $::osfamily ? {
        'Debian' => '3.2.4-2',
        'RedHat' => '3.3.1',
        default  => '3.3.1',
      },
    },
    default => $pgpool::version,
  }
  $postgresql_version_short = regsubst($postgresql::version,'\.','')

  $real_package = $pgpool::package ? {
    ''          => $::operatingsystem ? {
      /(?i:RedHat|Centos|Scientific)/ => "pgpool-II-${postgresql_version_short}",
      default                         => "pgpool",
    },
    default     => $pgpool::package,
  }

  $real_service = $pgpool::service ? {
    ''          => $::operatingsystem ? {
      /(?i:RedHat|Centos|Scientific)/ => $pgpool::bool_use_postgresql_repo ? {
        true  => "pgpool-II-${postgresql_version_short}",
        false => 'pgpool',
      },
      default                         => 'pgpool',
    },
    default     => $pgpool::service,
  }

  $real_config_dir = $pgpool::config_dir ? {
    ''          => $::operatingsystem ? {
      /(?i:Debian|Ubuntu|Mint)/       => "/etc/pgpool2",
      /(?i:RedHat|Centos|Scientific)/ => "/etc/pgpool-II-${postgresql_version_short}",
      default                         => '/etc/pgpool',
    },
    default     => $pgpool::config_dir,
  }

  $real_config_file = "${real_config_dir}/pgpool.conf"

  $real_config_file_hba = "${real_config_dir}/pool_hba.conf"

  $real_config_file_pcp = "${real_config_dir}/pcp.conf"

  $real_pid_file = $pgpool::pid_file ? {
    ''          => $::operatingsystem ? {
      /(?i:Debian|Ubuntu|Mint)/ => "/var/run/postgresql/pgpool.pid",
      default                   => "/var/run/pgpool/pgpool.pid",
    },
    default     => $pgpool::pid_file,
  }

  $real_log_dir = $pgpool::log_dir ? {
    ''        => $::operatingsystem ? {
      /(?i:Debian|Ubuntu|Mint)/       => '/var/log/postgresql',
      /(?i:RedHat|Centos|Scientific)/ => "/var/log/pgpool-II",
      default                         => "/var/log/pgpool",
    },
    default   => $pgpool::log_file,
  }

  $real_log_file = $pgpool::log_file ? {
    ''        => $::operatingsystem ? {
      /(?i:RedHat|Centos|Scientific)/ => "/var/log/pgpool-II-${postgresql_version_short}.log",
      default                         => "/var/log/pgpool.log",
    },
    default   => $pgpool::log_file,
  }

  ### Managed resources

  if $pgpool::bool_install_prerequisites {
    require pgpool::prerequisites
  }

  package { 'pgpool':
    ensure => $pgpool::manage_package,
    name   => $pgpool::real_package,
  }

  service { 'pgpool':
    ensure     => $pgpool::manage_service_ensure,
    name       => $pgpool::real_service,
    enable     => $pgpool::manage_service_enable,
    hasstatus  => $pgpool::service_status,
    pattern    => $pgpool::process,
    require    => Package['pgpool'],
  }

  file { 'pgpool.conf':
    ensure  => $pgpool::manage_file,
    path    => $pgpool::real_config_file,
    mode    => $pgpool::config_file_mode,
    owner   => $pgpool::config_file_owner,
    group   => $pgpool::config_file_group,
    require => Package['pgpool'],
    notify  => $pgpool::manage_service_autorestart,
    source  => $pgpool::manage_file_source,
    content => $pgpool::manage_file_content,
    replace => $pgpool::manage_file_replace,
    audit   => $pgpool::manage_audit,
  }

  if $pgpool::source_hba or $pgpool::template_hba {
    file { 'pgpool_hba.conf':
      ensure  => $pgpool::manage_file,
      path    => $pgpool::real_config_file_hba,
      mode    => $pgpool::config_file_mode,
      owner   => $pgpool::config_file_owner,
      group   => $pgpool::config_file_group,
      require => Package['pgpool'],
      notify  => $pgpool::manage_service_autorestart,
      source  => $pgpool::manage_file_source_hba,
      content => $pgpool::manage_file_content_hba,
      replace => $pgpool::manage_file_replace,
      audit   => $pgpool::manage_audit,
    }
  }

  if $pgpool::source_pcp or $pgpool::template_pcp {
    file { 'pcp.conf':
      ensure  => $pgpool::manage_file,
      path    => $pgpool::real_config_file_pcp,
      mode    => $pgpool::config_file_mode,
      owner   => $pgpool::config_file_owner,
      group   => $pgpool::config_file_group,
      require => Package['pgpool'],
      notify  => $pgpool::manage_service_autorestart,
      source  => $pgpool::manage_file_source_pcp,
      content => $pgpool::manage_file_content_pcp,
      replace => $pgpool::manage_file_replace,
      audit   => $pgpool::manage_audit,
    }
  }

  # The whole pgpool configuration directory can be recursively overriden
  if $pgpool::source_dir {
    file { 'pgpool.dir':
      ensure  => directory,
      path    => $pgpool::real_config_dir,
      require => Package['pgpool'],
      notify  => $pgpool::manage_service_autorestart,
      source  => $pgpool::source_dir,
      recurse => true,
      purge   => $pgpool::bool_source_dir_purge,
      replace => $pgpool::manage_file_replace,
      audit   => $pgpool::manage_audit,
    }
  }


  ### Include custom class if $my_class is set
  if $pgpool::my_class {
    include $pgpool::my_class
  }


  ### Provide puppi data, if enabled ( puppi => true )
  if $pgpool::bool_puppi == true {
    $classvars=get_class_args()
    puppi::ze { 'pgpool':
      ensure    => $pgpool::manage_file,
      variables => $classvars,
      helper    => $pgpool::puppi_helper,
    }
  }


  ### Service monitoring, if enabled ( monitor => true )
  if $pgpool::bool_monitor == true {
    monitor::port { "pgpool_${pgpool::protocol}_${pgpool::port}":
      protocol => $pgpool::protocol,
      port     => $pgpool::port,
      target   => $pgpool::monitor_target,
      tool     => $pgpool::monitor_tool,
      enable   => $pgpool::manage_monitor,
    }
    monitor::process { 'pgpool_process':
      process  => $pgpool::process,
      service  => $pgpool::real_service,
      pidfile  => $pgpool::real_pid_file,
      user     => $pgpool::process_user,
      argument => $pgpool::process_args,
      tool     => $pgpool::monitor_tool,
      enable   => $pgpool::manage_monitor,
    }
  }


  ### Firewall management, if enabled ( firewall => true )
  if $pgpool::bool_firewall == true {
    firewall { "pgpool_${pgpool_protocol}_${pgpool::port}":
      source      => $pgpool::firewall_src,
      destination => $pgpool::firewall_dst,
      protocol    => $pgpool::protocol,
      port        => $pgpool::port,
      action      => 'allow',
      direction   => 'input',
      tool        => $pgpool::firewall_tool,
      enable      => $pgpool::manage_firewall,
    }
  }


  ### Debugging, if enabled ( debug => true )
  if $pgpool::bool_debug == true {
    file { 'debug_pgpool':
      ensure  => $pgpool::manage_file,
      path    => "${settings::vardir}/debug-pgpool",
      mode    => '0640',
      owner   => 'root',
      group   => 'root',
      content => inline_template('<%= scope.to_hash.reject { |k,v| k.to_s =~ /(uptime.*|path|timestamp|free|.*password.*|.*psk.*|.*key)/ }.to_yaml %>'),
    }
  }

}

$resource = hiera('{{ resource_name }}')

$ip = $resource['input']['ip']['value']

$db_user = $resource['input']['db_user']['value']
$db_password = $resource['input']['db_password']['value']
$db_name = $resource['input']['db_name']['value']

$database_connection          = $resource['input']['database_connection']['value']
$database_idle_timeout        = $resource['input']['database_idle_timeout']['value']
$database_min_pool_size       = $resource['input']['database_min_pool_size']['value']
$database_max_pool_size       = $resource['input']['database_max_pool_size']['value']
$database_max_retries         = $resource['input']['database_max_retries']['value']
$database_retry_interval      = $resource['input']['database_retry_interval']['value']
$database_max_overflow        = $resource['input']['database_max_overflow']['value']
$rpc_backend                  = $resource['input']['rpc_backend']['value']
$control_exchange             = $resource['input']['control_exchange']['value']
$rabbit_host                  = $resource['input']['rabbit_host']['value']
$rabbit_port                  = $resource['input']['rabbit_port']['value']
$rabbit_hosts                 = $resource['input']['rabbit_hosts']['value']
$rabbit_virtual_host          = $resource['input']['rabbit_virtual_host']['value']
$rabbit_userid                = $resource['input']['rabbit_userid']['value']
$rabbit_password              = $resource['input']['rabbit_password']['value']
$rabbit_use_ssl               = $resource['input']['rabbit_use_ssl']['value']
$kombu_ssl_ca_certs           = $resource['input']['kombu_ssl_ca_certs']['value']
$kombu_ssl_certfile           = $resource['input']['kombu_ssl_certfile']['value']
$kombu_ssl_keyfile            = $resource['input']['kombu_ssl_keyfile']['value']
$kombu_ssl_version            = $resource['input']['kombu_ssl_version']['value']
$amqp_durable_queues          = $resource['input']['amqp_durable_queues']['value']
$qpid_hostname                = $resource['input']['qpid_hostname']['value']
$qpid_port                    = $resource['input']['qpid_port']['value']
$qpid_username                = $resource['input']['qpid_username']['value']
$qpid_password                = $resource['input']['qpid_password']['value']
$qpid_sasl_mechanisms         = $resource['input']['qpid_sasl_mechanisms']['value']
$qpid_reconnect               = $resource['input']['qpid_reconnect']['value']
$qpid_reconnect_timeout       = $resource['input']['qpid_reconnect_timeout']['value']
$qpid_reconnect_limit         = $resource['input']['qpid_reconnect_limit']['value']
$qpid_reconnect_interval_min  = $resource['input']['qpid_reconnect_interval_min']['value']
$qpid_reconnect_interval_max  = $resource['input']['qpid_reconnect_interval_max']['value']
$qpid_reconnect_interval      = $resource['input']['qpid_reconnect_interval']['value']
$qpid_heartbeat               = $resource['input']['qpid_heartbeat']['value']
$qpid_protocol                = $resource['input']['qpid_protocol']['value']
$qpid_tcp_nodelay             = $resource['input']['qpid_tcp_nodelay']['value']
$package_ensure               = $resource['input']['package_ensure']['value']
$use_ssl                      = $resource['input']['use_ssl']['value']
$ca_file                      = $resource['input']['ca_file']['value']
$cert_file                    = $resource['input']['cert_file']['value']
$key_file                     = $resource['input']['key_file']['value']
$api_paste_config             = $resource['input']['api_paste_config']['value']
$use_syslog                   = $resource['input']['use_syslog']['value']
$log_facility                 = $resource['input']['log_facility']['value']
$log_dir                      = $resource['input']['log_dir']['value']
$verbose                      = $resource['input']['verbose']['value']
$debug                        = $resource['input']['debug']['value']
$storage_availability_zone    = $resource['input']['storage_availability_zone']['value']
$default_availability_zone    = $resource['input']['default_availability_zone']['value']
$mysql_module                 = $resource['input']['mysql_module']['value']
$sql_connection               = $resource['input']['sql_connection']['value']
$sql_idle_timeout             = $resource['input']['sql_idle_timeout']['value']

class {'cinder':
  database_connection          => "mysql://${db_user}:${db_password}@${ip}/${db_name}",
  database_idle_timeout        => $database_idle_timeout,
  database_min_pool_size       => $database_min_pool_size,
  database_max_pool_size       => $database_max_pool_size,
  database_max_retries         => $database_max_retries,
  database_retry_interval      => $database_retry_interval,
  database_max_overflow        => $database_max_overflow,
  rpc_backend                  => $rpc_backend,
  control_exchange             => $control_exchange,
  rabbit_host                  => $rabbit_host,
  rabbit_port                  => $rabbit_port,
  rabbit_hosts                 => $rabbit_hosts,
  rabbit_virtual_host          => $rabbit_virtual_host,
  rabbit_userid                => $rabbit_userid,
  rabbit_password              => $rabbit_password,
  rabbit_use_ssl               => $rabbit_use_ssl,
  kombu_ssl_ca_certs           => $kombu_ssl_ca_certs,
  kombu_ssl_certfile           => $kombu_ssl_certfile,
  kombu_ssl_keyfile            => $kombu_ssl_keyfile,
  kombu_ssl_version            => $kombu_ssl_version,
  amqp_durable_queues          => $amqp_durable_queues,
  qpid_hostname                => $qpid_hostname,
  qpid_port                    => $qpid_port,
  qpid_username                => $qpid_username,
  qpid_password                => $qpid_password,
  qpid_sasl_mechanisms         => $qpid_sasl_mechanisms,
  qpid_reconnect               => $qpid_reconnect,
  qpid_reconnect_timeout       => $qpid_reconnect_timeout,
  qpid_reconnect_limit         => $qpid_reconnect_limit,
  qpid_reconnect_interval_min  => $qpid_reconnect_interval_min,
  qpid_reconnect_interval_max  => $qpid_reconnect_interval_max,
  qpid_reconnect_interval      => $qpid_reconnect_interval,
  qpid_heartbeat               => $qpid_heartbeat,
  qpid_protocol                => $qpid_protocol,
  qpid_tcp_nodelay             => $qpid_tcp_nodelay,
  package_ensure               => $package_ensure,
  use_ssl                      => $use_ssl,
  ca_file                      => $ca_file,
  cert_file                    => $cert_file,
  key_file                     => $key_file,
  api_paste_config             => $api_paste_config,
  use_syslog                   => $use_syslog,
  log_facility                 => $log_facility,
  log_dir                      => $log_dir,
  verbose                      => $verbose,
  debug                        => $debug,
  storage_availability_zone    => $storage_availability_zone,
  default_availability_zone    => $default_availability_zone,
  mysql_module                 => $mysql_module,
  sql_connection               => $sql_connection,
  sql_idle_timeout             => $sql_idle_timeout,
}
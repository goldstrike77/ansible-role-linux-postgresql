![](https://img.shields.io/badge/Ansible-PostgreSQL-green.svg?logo=angular&style=for-the-badge)

>__Please note that the original design goal of this role was more concerned with the initial installation and bootstrapping environment, which currently does not involve performing continuous maintenance, and therefore are only suitable for testing and development purposes,  should not be used in production environments.__

>__请注意，此角色的最初设计目标更关注初始安装和引导环境，目前不涉及执行连续维护，因此仅适用于测试和开发目的，不应在生产环境中使用。__
___

<p><img src="https://raw.githubusercontent.com/goldstrike77/goldstrike77.github.io/master/img/logo/logo_PostgreSQL.png" align="right" /></p>

__Table of Contents__

- [Overview](#overview)
- [Requirements](#requirements)
  * [Operating systems](#operating-systems)
  * [PostgreSQL Versions](#PostgreSQL-versions)
- [ Role variables](#Role-variables)
  * [Minimal Configuration](#minimal-configuration)
  * [Main Configuration](#Main-parameters)
  * [Other Configuration](#Other-parameters)
- [Dependencies](#dependencies)
- [Example Playbook](#example-playbook)
  * [Hosts inventory file](#Hosts-inventory-file)
  * [Vars in role configuration](#vars-in-role-configuration)
  * [Combination of group vars and playbook](#combination-of-group-vars-and-playbook)
- [License](#license)
- [Author Information](#author-information)
- [Contributors](#Contributors)

## Overview
This Ansible role installs PostgreSQL on linux operating system, including establishing a filesystem structure and server configuration with some common operational features.

## Requirements
### Operating systems
This role will work on the following operating systems:

  * CentOS 6/7

### PostgreSQL versions

The following list of supported the PostgreSQL releases:

*  PostgreSQL 9.6

## Role variables
### Main parameters #
There are some variables in defaults/main.yml which can (Or needs to) be overridden:

##### General parameters
* `pgsql_is_install`: A boolean value, whether install the PostgreSQL.
* `pgsql_version`:  Specify the PostgreSQL version.
* `pgsql_releases`: pgsql for PostgreSQL / pgpro for PostgresPro
* `pgsql_sa_pass`: PostgreSQL root account password
* `pgsql_mailto`: PostgreSQL report mail recipient

##### Service Mesh
* `environments`: Define the service environment.
* `consul_is_register`: Whether register a client service with consul.
* `consul_exporter_token`: Consul client ACL token.
* `consul_clients`: List of consul clients.
* `consul_http_port`:The consul HTTP API port.

##### Listen port
* `pgsql_port`: PostgreSQL instance communication ports.
* `pgsql_exporter_port`: Prometheus exporter communication ports.

##### Server System Variables
* `pgsql_path`: Specify the PostgreSQL data directory.
* `pgsql_archive_mode`: Completed WAL segments are sent to archive storage when archive_mode is enabled.
* `pgsql_checkpoint_completion_target`: Specifies the target of checkpoint completion.
* `pgsql_commit_delay`: Time delay before a WAL flush is initiated in microseconds.
* `pgsql_commit_siblings`: Minimum number of concurrent open transactions to require before performing the commit_delay.
* `pgsql_default_statistics_target`: Default statistics target for table columns without a column-specific target set via ALTER TABLE SET STATISTICS.
* `pgsql_effective_io_concurrency`: Number of concurrent disk I/O operations that PostgreSQL expects can be executed simultaneously.
* `pgsql_fsync`: Turning off often a performance benefit.
* `pgsql_full_page_writes`:Writes the entire content of each disk page to WAL during the first modification of that page after a checkpoint.
* `pgsql_hot_standby`: Specifies whether or not you can connect and run queries during recovery.
* `pgsql_lc_messages`: The language of system messages.
* `pgsql_listen_addresses`: pecifies the TCP/IP address(es) on which the server is to listen.
* `pgsql_log_autovacuum_min_duration`: Executed by autovacuum to be logged of milliseconds.
* `pgsql_log_checkpoints`: Logged checkpoints and restartpoints.
* `pgsql_log_connections`: Logged connection to the server.
* `pgsql_log_disconnections`: Logged diconnection to the server.
* `pgsql_log_line_prefix`: Output string at the beginning of each log.
* `pgsql_log_lock_waits`: Logged session waits longer than deadlock_timeout.
* `pgsql_log_min_duration_statement`: Logged statement ran for at least the specified number in milliseconds.
* `pgsql_log_statement`: Logged SQL statements.
* `pgsql_log_temp_files`: Logged temporary file names and sizes.
* `pgsql_log_timezone`: Time zone used for timestamps written in the server log.
* `pgsql_max_wal_senders`: The number of simultaneously running WAL sender processes.
* `pgsql_max_wal_size`: Maximum size to let the WAL grow to between automatic WAL checkpoints.
* `pgsql_min_wal_size`: Old WAL files are always recycled below this setting, rather than removed.
* `pgsql_random_page_cost`: The cost of a non-sequentially-fetched disk page.
* `pgsql_synchronous_commit`: Transaction commit will wait for WAL records to be written to disk before the command returns a "success".
* `pgsql_wal_buffers`: The amount of shared memory used for WAL data that has not yet been written to disk.
* `pgsql_wal_level`: Determines how much information is written to the WAL.

### Other parameters
There are some variables in vars/main.yml:
* `pgsql_folder`: Specify the PostgreSQL sub data directory.
* `pgsql_kernel_parameters`: Operating system variables.

## Dependencies
There are no dependencies on other roles.

## Example

### Hosts inventory file
See tests/inventory for an example.

    node01 ansible_host='192.168.1.10' pgsql_version='96' pgsql_releases='PostgreSQL'
    node02 ansible_host='192.168.1.11' pgsql_version='96' pgsql_releases='PostgreSQL'
    node03 ansible_host='192.168.1.12' pgsql_version='96' pgsql_releases='PostgreSQL'

### Vars in role configuration
Including an example of how to use your role (for instance, with variables passed in as parameters) is always nice for users too:

    - hosts: all
      roles:
         - role: ansible-role-linux-PostgreSQL
           pgsql_version: '96'

### Combination of group vars and playbook
You can also use the group_vars or the host_vars files for setting the variables needed for this role. File you should change: group_vars/all or host_vars/`group_name`

    pgsql_version: '96'
    pgsql_releases: 'PostgreSQL'
    pgsql_sa_pass: 'password'
    pgsql_mailto: 'somebody@example.com'
    environments: 'SIT'
    consul_is_register: false
    consul_exporter_token: '00000000-0000-0000-0000-000000000000'
    consul_clients: 'localhost'
    consul_http_port: '8500'
    pgsql_port: '5432'
    pgsql_exporter_port: '9187'
    pgsql_path: '/data'
    pgsql_archive_mode: 'on'
    pgsql_checkpoint_completion_target: '0.9'
    pgsql_commit_delay: '10'
    pgsql_commit_siblings: '5'
    pgsql_default_statistics_target: '100'
    pgsql_effective_io_concurrency: '2'
    pgsql_fsync: 'off'
    pgsql_full_page_writes: 'on'
    pgsql_hot_standby: 'on'
    pgsql_lc_messages: 'C'
    pgsql_listen_addresses: "'0.0.0.0'"
    pgsql_log_autovacuum_min_duration: '0'
    pgsql_log_checkpoints: 'on'
    pgsql_log_connections: 'on'
    pgsql_log_disconnections: 'on'
    pgsql_log_line_prefix: "'%t [%p]: [%l-1] user=%u,db=%d,app=%a,client=%h '"
    pgsql_log_lock_waits: 'on'
    pgsql_log_min_duration_statement: '1000'
    pgsql_log_statement: 'ddl'
    pgsql_log_temp_files: '0'
    pgsql_log_timezone: 'PRC'
    pgsql_max_wal_senders: '3'
    pgsql_max_wal_size: '4GB'
    pgsql_min_wal_size: '2GB'
    pgsql_random_page_cost: '4'
    pgsql_synchronous_commit: 'off'
    pgsql_wal_buffers: '16MB'
    pgsql_wal_level: 'logical'

## License
![](https://img.shields.io/badge/MIT-purple.svg?style=for-the-badge)

## Author Information
Please send your suggestions to make this role better.

## Contributors
Special thanks to the [Connext Information Technology](http://www.connext.com.cn) for their contributions to this role.

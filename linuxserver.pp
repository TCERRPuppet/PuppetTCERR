class linuxserver {
	
	#APT-UPDATE
	exec {'apt-update':
        command =>      '/usr/bin/apt-get update'
	}
        
	#NFS
	class {'::nfs':
                client_enabled  =>      true,
        }
	
	#RSYNC
        class {'rsync':
                package_ensure  =>      'latest',
        }
        exec {'rsyslog':
                command =>      '/usr/bin/printf "*.* @10.10.210.161:1514" >> /etc/rsyslog.conf',
        }
        exec {'restartrsyslog':
                command =>      '/etc/init.d/rsync restart',
        }
	
	#NTP
        class {'ntp':
                servers =>      ['10.10.210.156'],
                before  =>      Exec["cronntp"],
        }
        exec {'cronntp':
                command =>      '/usr/bin/printf "00 5 * * * root /usr/sbin/ntpdate-debian" >> /etc/crontab',
        }
        
	#OPENSSH
	class { '::openssh':
		config => {
			'Port'	=>	'223',
			'PermitRootLogin'	=>	'no',
		},
		exporttag	=>	false,
		collecttag	=>	false,
        }
        exec {'ssh_config':
                command =>      '/usr/bin/printf "AllowUsers sroot\n" >> /etc/ssh/sshd_config',
        }
        exec {'restartssh':
                command =>      '/etc/init.d/ssh restart',
        }
	#ZABBIXAGENT
        class {'zabbix::agent':
                server  =>      '10.10.210.152',
                listenport      =>      '10050',
                serveractive    =>      '10.10.210.152',
        }
	#USUARIO
	user {'sroot':
                ensure  =>      present,
                password        =>      '$1$YDTutTEq$XcqgGTBdD8Ug/WtJ/3VU81',
        }
        user {'root':
                ensure  =>      present,
                password        =>      '$1$YDTutTEq$XcqgGTBdD8Ug/WtJ/3VU81',
        }
}

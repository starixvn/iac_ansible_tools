###### Local
```bash
keepalived_version: 2.0.20
keepalived_source_url: "http://www.keepalived.org/software/keepalived-{{ keepalived_version }}.tar.gz"
keepalived_install_dir: "/tmp/keepalived-{{ keepalived_version }}"
keepalived_conf_path: /etc/keepalived/keepalived.conf
keepalived_ip_switch_script_path: /etc/keepalived/master.sh
keepalived_network_interface: eth0
VIRTUAL_IP
/lib/systemd/system/keepalived.service
```
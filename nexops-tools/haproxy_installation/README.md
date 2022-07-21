###### **HAProxy**

- HAProxy alone

```bash
ansible-playbook install_haproxy_alone.yml -i inventories/dev/hosts -e "server=10.70.70.144" -e "env=dev"
```

- HAProxy + Keepalived (need update variable such as Interface, VIP,...)

```bash
ansible-playbook install_haproxy_keepalived.yml -i inventories/prod/hosts -e "server=10.99.99.28" -e "env=prod" -e "keepalived_bind_interface=ens160" -e "keepalived_priority=99" -e "keepalived_vip=10.99.99.29"
```
###keepalived
ip addr show | grep global
cat /etc/keepalived/keepalived_status

###glusterfs
/var/www/gluster/web
/var/www/gluster/nexops

###docker-swarm
docker swarm join-token --quiet manager
docker swarm join-token --quiet worker
docker swarm join --token ip:2377

docker swarm leave -f
docker node demote <node name>
docker node promote <node name>
docker node rm <node name> (id)

######### Proxy setting
########
mkdir -p /etc/systemd/system/docker.service.d
vi /etc/systemd/system/docker.service.d/proxy.conf
[Service]
Environment="HTTP_PROXY=http://10.40.40.245:3128"
Environment="HTTPS_PROXY=http://10.40.40.245:3128"
Environment="NO_PROXY="localhost,127.0.0.1,::1"

systemctl daemon-reload
service docker restart

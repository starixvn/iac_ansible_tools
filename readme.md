###keepalived
ip addr show | grep global
cat /etc/keepalived/keepalived_status

###glusterfs
/var/www/gluster/web
/var/www/gluster/nexops

###docker-swarm
show labels
docker node ls -q | xargs docker node inspect -f '{{ .ID }} [{{ .Description.Hostname }}]: {{ .Spec.Labels }}'

docker swarm join-token --quiet manager
docker swarm join-token --quiet worker
docker swarm join --token ip:2377

docker login --username=gitlab-ci --password=Vv3AQX-aaSZ3M6PtvyD4 registry.nexdev.net:5050

docker swarm leave -f
docker node demote <node name>
docker node promote <node name>
docker node rm <node name> (id)
docker node update --label-add SENTRY=yes ip-10-2-27-27
docker node update --label-add SENTRY_NEW=yes ub-70-31

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

#######Docker After an upgrade I got the permission denied
sudo chmod 666 /var/run/docker.sock

############

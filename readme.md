###keepalived or cluster: run 3-5-7
ip addr show | grep global
cat /etc/keepalived/keepalived_status

###glusterfs
/var/www/gluster/web
/var/www/gluster/nexops

###docker-swarm
show labels
docker node ls -q | xargs docker node inspect -f '{{ .ID }} [{{ .Description.Hostname }}]: {{ .Spec.Labels }}'
docker network ls|grep swarm_nexcel_local > /dev/null || docker network create --attachable --driver overlay swarm_nexcel_local

docker swarm join-token --quiet manager
docker swarm join-token --quiet worker
docker swarm join --token ip:2377

docker login --username=gitlab-ci --password=Vv3AQX-aaSZ3M6PtvyD4 registry.nexdev.net:5050
docker login --username=gitlab-ci --password=H5nF5ywy262wt881ZWpq  git3.nexdev.net:5050

docker swarm leave -f
docker node demote <node name>
docker node promote <node name>
docker node rm <node name> (id)
docker node update --label-add SENTRY=yes ip-10-2-27-27
docker node update --label-add SENTRY_NEW=yes ub-70-31

#backup swarm data /var/lib/docker/swarm
service docker restart
docker swarm init --force-new-cluster --advertise-addr xx.xx.xx.xx
docker node leave -f
docker swarm join --token ip:2377

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
##Remove/Clean
To delete all containers including its volumes use,
-->docker rm -vf $(docker ps -a -q)
To delete all the images,
-->docker rmi -f $(docker images -a -q)

#show lable node
docker node ls -q | xargs docker node inspect -f '{{ .ID }} [{{ .Description.Hostname }}]: {{ .Spec.Labels }}'

#########FTP
pure-pw useradd olympus -f /etc/pure-ftpd/passwd/pureftpd.passwd -m -u ftpuser -d /home/ftpusers/olympus

host: 10.99.99.96
user: nexus
pass: Pro_nexus_@1234aa
port: 2121


host: 10.18.200.131
host: 10.2.189.41
host: 10.2.27.8
port: 2121
user: olympus
pass: Pro_olympus_@1234aa

###
export http_proxy="http://10.40.40.245:3128"
export https_proxy="http://10.40.40.245:3128"
export no_proxy=localhost,127.0.0.0,127.0.1.1,127.0.1.1,local.home

systemctl show docker --property Environment
##docker version
apt-cache madison docker-ce
####websocket 
wscat -c "ws://l1-proxy1.lumigame.com/dragontiger/socket.io/?EIO=4&transport=websocket"

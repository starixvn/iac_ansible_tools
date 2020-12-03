#docker swarm leave
docker swarm leave -f

#docker node demote
docker node demote <node name>

#docker node promote
docker node promote <node name>

#Remove a stopped node from the swarm
docker node rm <node name> (id)


docker service update haproxy-service \
--publish-add published=82,target=82,protocol=tcp,mode=ingress \
--publish-add published=83,target=83,protocol=tcp,mode=ingress

#####

docker kill --signal USR2 $(docker container ls --filter name=haproxy-service 

####### Swarm labels
sudo docker node update --label-add Demo-Service1=yes ub-70-30
sudo docker node update --label-add HAPROXY=yes ub-70-32
sudo docker node update --label-add HAPROXY --label-add HAPROXY2 ub-70-32

sudo docker node update --label-rm HAPROXY2 ub-70-32

docker service update --constraint-add node.labels.Demo-Service1 ==yes webapp-core-LOCAL

Or on an existing service with the docker service update command:

$ docker service update --constraint-add node.labels.HAPROXY haproxy-service


- name: set Labels 
  shell: |
    sudo docker node update --label-add HAPROXY=yes {{ansible_hostname}}
  become: yes
##### Swarm create service


sudo docker node update --label-add HAPROXY=yes {{ansible_hostname}}
docker service create \
--mode global \
--name haproxy-service \
--network nexdev \
--publish published=8082,target=8086,protocol=tcp,mode=ingress \
--publish published=8087,target=8087,protocol=tcp,mode=host \
--publish published=8088,target=8088,protocol=tcp,mode=ingress \
--publish published=8089,target=8089,protocol=tcp,mode=ingress \
--publish published=8888,target=8888,protocol=tcp,mode=ingress \
--mount type=volume,src=haproxy,dst=/usr/local/etc/haproxy/,ro=true \
--dns=127.0.0.11 \
--constraint node.labels.HAPROXY==yes \
haproxytech/haproxy-debian:2.2



version: '3.6'

services:
  redis:
    image: redis:5.0.3
    command:
      - "redis-server"
      - "--cluster-enabled yes"
      - "--cluster-config-file nodes.conf"
      - "--cluster-node-timeout 5000"
      - "--appendonly yes"
    deploy:
      mode: global
      restart_policy:
        condition: on-failure
    networks:
      hostnet: {}

networks:
  hostnet:
    external: true
    name: host
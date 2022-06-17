#!/bin/bash
echo "--------------------------------------------------------------------------------------------------------------"
echo "             REDIS STACK DEPLOYMENT                                                                           "
echo "--------------------------------------------------------------------------------------------------------------"

export SENTINEL_HOSTNAME=$1 #serveur17
export REDIS_MASTER_HOSTNAME=$2 #serveur17
export REDIS_SLAVE_NODE1_HOSTNAME=$3 #serveur18
export REDIS_SLAVE_NODE2_HOSTNAME=$4 #serveur19
export REDIS_FUNCTION=NAP_
export REDIS_MASTER_PORT=6311
export REDIS_MASTER_PORT_DEPLOY=6311
export REDIS_SENTINEL_PORT=26111
export REDIS_PYTHON_PORT=33003
export REDIS_VERSION_DEPLOY=5
export STACK_NAME=nap_redis

if [ -z $SENTINEL_HOSTNAME ] || [ -z $REDIS_MASTER_HOSTNAME ] || [ -z $REDIS_SLAVE_NODE1_HOSTNAME ]  || [ -z $REDIS_SLAVE_NODE2_HOSTNAME ] ; then
  echo "Status: Arguments missing. Cannot continue to build the stack. Missing SENTINEL_HOSTNAME, REDIS_MASTER_HOSTNAME, REDIS_SLAVE_NODE1_HOSTNAME, REDIS_SLAVE_NODE1_HOSTNAME" >&2
  exit 1;
fi

echo "4- Start to deploy the stack..."
#export SENTINEL_IP=`docker node inspect --format {{.ManagerStatus.Addr}} $SENTINEL_HOSTNAME | sed 's/:2377//'`
#export REDIS_MASTER_IP=`docker node inspect --format {{.ManagerStatus.Addr}} $REDIS_MASTER_HOSTNAME | sed 's/:2377//'`
export SENTINEL_IP=`docker node inspect --format {{.Status.Addr}} $SENTINEL_HOSTNAME`
export REDIS_MASTER_IP=`docker node inspect --format {{.Status.Addr}} $REDIS_MASTER_HOSTNAME`
echo "Sentinel hostname and IP: $SENTINEL_HOSTNAME -  $SENTINEL_IP"
echo "Redis Master hostname and IP: $REDIS_MASTER_HOSTNAME - $REDIS_MASTER_IP"
echo "Redis slave 1 hostname: $REDIS_SLAVE_NODE1_HOSTNAME"
echo "Redis slave 2 hostname: $REDIS_SLAVE_NODE2_HOSTNAME"

docker stack deploy -c redis-stack.yml $STACK_NAME
printf "(4)End to deploy the stack... Please wait until the services started\n\n\n"
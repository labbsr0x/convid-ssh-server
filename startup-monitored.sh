#!/bin/sh

set -x
set -e

if [ "$REGISTRY_ETCD_URL" != "" ];then

    echo ""
    echo "Discovering self instance public ip/port..."
    CONTAINERID=$(hostname)
    echo "CONTAINERID=$CONTAINERID"

    #wait for docker-info to have data about this new container
    sleep 1
    PUBLIC_IP=$(curl --fail --silent http://docker-info:5000/info/$CONTAINERID/publicIp)
    PUBLIC_PORT=$(curl --fail --silent http://docker-info:5000/info/$CONTAINERID/publicPort:0)

    echo "PUBLIC_IP=$PUBLIC_IP"
    echo "PUBLIC_PORT=$PUBLIC_PORT"

    echo ""
    echo "Starting ETCD Registrar..."
    etcd-registrar \
        --loglevel=$LOG_LEVEL \
        --etcd-url=$REGISTRY_ETCD_URL \
        --etcd-base=$REGISTRY_ETCD_BASE \
        --service=$REGISTRY_SERVICE \
        --port=22 \
        --info="{\"publicIp\":\"$PUBLIC_IP\", \"publicPort\":\"$PUBLIC_PORT\"}" \
        --ttl=$REGISTRY_TTL&

    sleep 1
    if [ ! ps -p $! >&- ]; then
        echo "Error launching ETCD registrar. Aborting."
        exit 2
    fi

else
    echo "No REGISTRY_ETCD_URL defined. Skipping ETCD service registration."
fi

echo ""
echo "Starting ssh server..."
/startup.sh


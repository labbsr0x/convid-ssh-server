# convid-ssh-server
SSH server for supporting Convid communications between NAT'd stations with NAT's remote clients

## Usage

* Create a docker-compose.yml file

* Follow instructions at http://github.com/flaviostutz/ssh-jwt on how to create JWT public, private keys and tokens

```yml
version: '3.5'
services:
  convid-ssh-server:
    image: labbsr0x/convid-ssh-server
    ports:
      - "2222:22"
    environment:
      - LOG_LEVEL=debug
      - REGISTRY_ETCD_URL=http://etcd0:2379
      - JWT_ALGORITHM=RS512
      - JWT_KEY_SECRET_NAME=rs-pub-key
      - ENABLE_LOCAL_FORWARDING=true
      - ENABLE_REMOTE_FORWARDING=true
      - ENABLE_PTY=true
    restart: always

  etcd0:
    image: quay.io/coreos/etcd:v3.2.25
    environment:
      - ETCD_LISTEN_CLIENT_URLS=http://0.0.0.0:2379
      - ETCD_ADVERTISE_CLIENT_URLS=http://etcd0:2379
    restart: always
```

* Run

```bash
docker-compose up -d

curl --location --request POST 'http://localhost:4000/account/23456/machine' \
--header 'Content-Type: application/json' \
--data-raw '{"test":"test"}'
```

* Get recently created machine ID

* Use machine ID as user for SSH connections. Example:

```bash
ssh 9c707773-3360-4460-923b-f919c63ce20b@localhost -p 2222 -L 12345:localhost:23456
```

* Use accountId as password. Ex.: "23456"

* You should see something like "Auth succeeded for user '9c707773-3360-4460-923b-f919c63ce20b'"


## Usage - complete example

* Run [/docker-compose.yml](docker-compose.yml) with by cloning this repo and then ```docker-compose up```

* Scale ssh-server with ```docker-compose scale convid-ssh-server=5```

* Open http://localhost:5000 and double click on nodes until you see all registered nodes in ETCD

* Open http://localhost:3000/config/ABC123 to view the supposed configuration returned to a client identified by ABC123

* Try other client identifications and see how publicPort changes depending on the client Id


## Development annotations

ssh -L 192.168.20.23:13389:127.0.0.1:30000 root@localhost -p 2222

ssh -R 127.0.0.1:30000:192.168.20.21:3389 root@localhost -p 2222

mstsc -v:192.168.20.23:13389

Docker host = 192.168.20.23
Controlled Machine = 192.168.20.21

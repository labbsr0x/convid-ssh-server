# convid-ssh-server
SSH server for supporting Convid communications between NAT'd stations with NAT's remote clients

## Usage

* Create a docker-compose.yml file

```yml
version: '3.5'
services:
  convid-ssh-server:
    image: labbsr0x/convid-ssh-server
    ports:
      - "2222:22"
    environment:
      - LOG_LEVEL=debug
      - ACCOUNTS_API_URL=http://simple-file-server:4000

  simple-file-server:
    image: flaviostutz/simple-file-server
    ports:
      - "4000:4000"
    environment:
      - LOG_LEVEL=info
      - LOCATION_BASE_URL=http://localhost:4000
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

## Development annotations

ssh -L 192.168.20.23:13389:127.0.0.1:30000 root@localhost -p 2222

ssh -R 127.0.0.1:30000:192.168.20.21:3389 root@localhost -p 2222

mstsc -v:192.168.20.23:13389

Docker host = 192.168.20.23
Controlled Machine = 192.168.20.21

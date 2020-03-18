# convid-ssh-server
SSH server for supporting Convid communications between NAT'd stations with NAT's remote clients

## Test

ssh -L 192.168.20.23:13389:127.0.0.1:30000 root@localhost -p 2222

ssh -R 127.0.0.1:30000:192.168.20.21:3389 root@localhost -p 2222

mstsc -v:192.168.20.23:13389

Docker host = 192.168.20.23
Controlled Machine = 192.168.20.21

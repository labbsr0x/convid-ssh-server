# convid-ssh-server
SSH server for supporting Convid communications between NAT'd stations with NAT's remote clients

## Test

ssh -L 13389:localhost:12345 root@localhost -p 2222

ssh -R 12345:192.168.20.8:3389 root@localhost -p 2222


FROM alpine:3.11.3

EXPOSE 22

RUN apk add --no-cache openssh-server-pam

RUN sed -i s/#PermitRootLogin.*/PermitRootLogin\ yes/ /etc/ssh/sshd_config \
    && sed -i s/#UsePAM.*/UsePAM\ yes/ /etc/ssh/sshd_config \
    && sed -i s/AllowTcpForwarding\ no/AllowTcpForwarding\ yes/ /etc/ssh/sshd_config \
    && sed -i s/#LogLevel\ INFO/LogLevel\ DEBUG1/ /etc/ssh/sshd_config \
    && cat /etc/ssh/sshd_config \
    && touch /etc/pam_debug \
    && echo "root:root" | chpasswd

ADD sshd /etc/pam.d/

ADD / /

CMD [ "/startup.sh" ]


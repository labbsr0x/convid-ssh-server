FROM ubuntu:19.10

ENV ACCOUNTS_API_URL ''

RUN apt-get update && apt-get install -y --no-install-recommends git gcc vim locales make libc6-dev apt-utils
RUN apt-get install -y openssh-server curl

RUN useradd -ms /bin/bash test
RUN echo "t:x:1000:1000:Test User:/home/test:/bin/bash" > /etc/libnss-ato.conf 

WORKDIR /tmp
RUN git clone https://github.com/donapieppo/libnss-ato.git

WORKDIR /tmp/libnss-ato
# RUN adduser --home /bin/sh test
RUN make && make install
ADD nsswitch.conf /etc/
 
# RUN rm /etc/pam.d/*
ADD sshd /etc/pam.d/
ADD sshd_config /etc/ssh/

ADD / /

CMD [ "/startup.sh" ]




# FROM alpine:3.11.3

# EXPOSE 22

# RUN apk add --no-cache openssh-server openssh-server-pam curl

# RUN apk add --no-cache build-base git nss-dev

# WORKDIR /tmp
# RUN git clone https://github.com/donapieppo/libnss-ato.git

# WORKDIR /tmp/libnss-ato
# RUN adduser --home /bin/sh -D test
# RUN make && make install
# ADD nsswitch.conf /etc/

# # RUN echo "root:root" | chpasswd

# #sed -i s/#LogLevel\ INFO/LogLevel\ DEBUG1/ /etc/ssh/sshd_config \

# ENV ACCOUNTS_API_URL ''

# # RUN rm /etc/pam.d/*
# ADD sshd /etc/pam.d/
# ADD sshd_config /etc/ssh/

# ADD / /

# CMD [ "/startup.sh" ]


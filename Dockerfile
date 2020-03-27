FROM flaviostutz/etcd-registrar:1.0.1 AS BUILD

FROM flaviostutz/ssh-jwt:1.0.2

RUN apk add --no-cache curl

ENV REGISTRY_ETCD_URL ''
ENV REGISTRY_ETCD_BASE '/registry/'
ENV REGISTRY_SERVICE 'convid-ssh-server'
ENV REGISTRY_TTL '60'

COPY --from=BUILD /bin/etcd-registrar /bin/

ADD startup-monitored.sh /

CMD [ "/startup-monitored.sh" ]

FROM registry.fedoraproject.org/fedora-minimal:34 
RUN microdnf -y install tang curl socat && microdnf clean all
COPY tang-socat /usr/bin
ENV PORT=7500
ENV DBDIR=/var/db/tang
ENV EXEDIR=/usr/libexec
EXPOSE ${PORT}/tcp
CMD /usr/bin/tang-socat ${PORT} ${DBDIR} ${EXEDIR}

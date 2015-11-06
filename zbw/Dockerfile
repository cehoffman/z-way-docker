FROM cehoffman/z-way-base:2.1.1

RUN apt-get install -qqy --no-install-recommends \
      openssh-client

COPY ssh_config /tmp/
COPY start.sh /tmp/

ENTRYPOINT ["/tmp/start.sh"]

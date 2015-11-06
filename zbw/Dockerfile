FROM resin/rpi-raspbian

RUN apt-get install -qqy --no-install-recommends \
      openssh-client

COPY ssh_config /tmp/
COPY start.sh /tmp/

ENTRYPOINT ["/tmp/start.sh"]

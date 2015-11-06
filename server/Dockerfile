FROM cehoffman/z-way-base:2.1.1

ENV ZWAY_VERSION 2.1.1

RUN apt-get install -qqy --no-install-recommends \
      libarchive13 \
      libavahi-compat-libdnssd-dev && \
    curl -L http://razberry.z-wave.me/z-way-server/z-way-server-RaspberryPiXTools-v$ZWAY_VERSION.tgz | tar -zxf - -C /opt && \
    sed -i -e 's/\/var\/log\/z-way-server\.log/\/dev\/stdout/' /opt/z-way-server/config.xml && \
    sed -i -e 's/0/6/' /opt/z-way-server/config.xml && \
    mkdir -p /etc/z-way && \
    echo razberry > /etc/z-way/box_type && \
    echo v$ZWAY_VERSION > /etc/z-way/VERSION && \
    ln -sf /usr/lib/arm-linux-gnueabihf/libarchive.so.13 /usr/lib/arm-linux-gnueabihf/libarchive.so.12

ENV LD_LIBRARY_PATH /opt/z-way-server/libs

WORKDIR /opt/z-way-server
VOLUME /etc/z-way

EXPOSE 8083

ENTRYPOINT ["./z-way-server"]

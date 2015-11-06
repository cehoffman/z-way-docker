FROM z-way/base:2

RUN curl -L http://razberry.z-wave.me/webif_raspberry.tar.gz | tar -zxf - -C / && \
    curl -L http://razberry.z-wave.me/mongoose.pkg.rPi.tgz | tar -zxf - -C / && \
    cd /usr/lib/arm-linux-gnueabihf && \
    ln -sf libssl.so.1.0.0 libssl.so && \
    ln -sf libcrypto.so.1.0.0 libcrypto.so

EXPOSE 8084

ENTRYPOINT ["/usr/sbin/mongoose"]
CMD ["/etc/mongoose/mongoose.conf"]

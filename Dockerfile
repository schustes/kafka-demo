FROM alpine:latest
MAINTAINER Stephan

RUN apk add --no-cache --update-cache bash
CMD ["/bin/bash"]

ENV JAVA_VERSION_MAJOR=8 \
    JAVA_VERSION_MINOR=162 \
    JAVA_VERSION_BUILD=12 \
    JAVA_PACKAGE=server-jre \
    GLIBC_PKG_VERSION=2.23-r1 \
    GLIBC_VERSION=2.23-r3 \
    PATH=${PATH}:/opt/jdk/bin \
    LANG=C.UTF-8

RUN apk add --no-cache --update-cache curl ca-certificates bash && \
    apk add --update libstdc++ curl ca-certificates bash && \
    for pkg in glibc-${GLIBC_VERSION} glibc-bin-${GLIBC_VERSION} glibc-i18n-${GLIBC_VERSION}; do curl -sSL https://github.com/andyshinn/alpine-pkg-glibc/releases/download/${GLIBC_VERSION}/${pkg}.apk -o /tmp/${pkg}.apk; done && \
  apk add --allow-untrusted /tmp/*.apk && \
  rm -v /tmp/*.apk && \
  ( /usr/glibc-compat/bin/localedef --force --inputfile POSIX --charmap UTF-8 C.UTF-8 || true ) && \
  echo "export LANG=C.UTF-8" > /etc/profile.d/locale.sh && \
  /usr/glibc-compat/sbin/ldconfig /lib /usr/glibc-compat/lib && \
  mkdir /opt && \
  cd /opt && \
  curl -jksSLH "Cookie: oraclelicense=accept-securebackup-cookie" \
  "http://download.oracle.com/otn-pub/java/jdk/${JAVA_VERSION_MAJOR}u${JAVA_VERSION_MINOR}-b${JAVA_VERSION_BUILD}/0da788060d494f5095bf8624735fa2f1/jdk-${JAVA_VERSION_MAJOR}u${JAVA_VERSION_MINOR}-linux-x64.tar.gz" | gunzip -c - | tar -xf - && \
  apk del curl ca-certificates && \
  mv jdk1.${JAVA_VERSION_MAJOR}.0_${JAVA_VERSION_MINOR}/jre /jre && \
  rm /jre/bin/jjs && \
  rm /jre/bin/keytool && \
  rm /jre/bin/orbd && \
  rm /jre/bin/pack200 && \
  rm /jre/bin/policytool && \
  rm /jre/bin/rmid && \
  rm /jre/bin/rmiregistry && \
  rm /jre/bin/servertool && \
  rm /jre/bin/tnameserv && \
  rm /jre/bin/unpack200 && \
  rm /jre/lib/ext/nashorn.jar && \
  rm /jre/lib/jfr.jar && \
  rm -rf /jre/lib/jfr && \
  rm -rf /jre/lib/oblique-fonts && \
  rm -rf /tmp/* /var/cache/apk/* && \
  echo 'hosts: files mdns4_minimal [NOTFOUND=return] dns mdns4' >> /etc/nsswitch.conf

#ENV JAVA_HOME=/jre
#ENV PATH=${PATH}:${JAVA_HOME}/bin
# Set environment
ENV JAVA_HOME /opt/jdk
ENV PATH ${PATH}:${JAVA_HOME}/bin
           
# Set environment
#ENV JAVA_HOME /opt/jdk
#ENV PATH ${PATH}:${JAVA_HOME}/bin

RUN mkdir -p /opt/kafka-demo

COPY kafka-demo.jar /opt/kafka-demo/kafka-demo.jar

RUN chmod 755 /opt/kafka-demo/kafka-demo.jar

EXPOSE 9100
ENTRYPOINT exec ls -all /opt/ && java -jar -Xmx1024m -Xms2048m /opt/kafka-demo/kafka-demo.jar

FROM amd64/openjdk:24-slim
MAINTAINER Sergey
USER root
SHELL ["/bin/bash", "-c"]
LABEL FstLbl="Small server on small container"
EXPOSE 80
ENV PatForADD=/
VOLUME ["/volum"]
WORKDIR /myApp/
STOPSIGNAL 9
#ARG LIBRARY_VERSION=2.32
ONBUILD RUN echo "Sergey"
RUN apt-get update && \
 apt-get install git -y && \
 apt-get install nginx -y && \
 apt-get install curl -y &&\
 apt-get install nano -y &&\
 git clone https://github.com/Ezidal/dockerTest.git && \
 rm /etc/nginx/sites-enabled/default
WORKDIR /myApp/dockerTest/
COPY default /etc/nginx/sites-enabled/
RUN nginx && \
 javac SimpleHttpServer1.java && \
 chmod +x /myApp/dockerTest/start.sh
ADD default $PatForADD
HEALTHCHECK --interval=5s --timeout=10s --retries=3 \
    CMD curl -f http://localhost/ || exit 1

ENTRYPOINT ["/myApp/dockerTest/start.sh"]

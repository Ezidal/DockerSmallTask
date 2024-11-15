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
ARG LIBRARY_VERSION=2.32
ONBUILD RUN echo "Sergey"
RUN apt-get update && \
 apt-get install nginx -y && \
 rm /etc/nginx/sites-enabled/default
COPY SimpleHttpServer.java /myApp/
COPY start.sh .
COPY default /etc/nginx/sites-enabled/
RUN chmod +x /myApp/start.sh
ADD default $PatForADD
HEALTHCHECK --interval=5s --timeout=10s --retries=3 \
    CMD curl -f http://localhost/ || exit 1

ENTRYPOINT ["/myApp/start.sh"]

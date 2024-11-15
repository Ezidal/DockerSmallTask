# Инструкция для запуска:
1. Склонировать репозиторий в свободную директорию 
```
git clone https://github.com/Ezidal/DockerSmallTask.git
```
2. Перейти в директорию DockerSmallTask
3. Запустить команду для сборки образа:
```
docker build -t sergeyapp:9.11 .
```
4. Дождаться сборки образа
5. После сборки образа - запустить контейнер командой:
```
docker run --name containerBySergey --rm -it -d -p 80:80 sergeyapp:9.11
```
Результат работы контейнера можно отследить вбив "localhost" в браузере, при условии что больше ничего не работает на 80 порту - перед взором предстанет приветственная строка Nginx'a
Также обратившись к "localhost/java" выведется ответ от java приложения


### Содержимое Dockerfile
```
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
```



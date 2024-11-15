#!/bin/bash

# Запуск Nginx
/usr/sbin/nginx -g "daemon off;" &

# Запуск Java приложения
java /myApp/SimpleHttpServer.java &

wait
#!/bin/bash

# Запуск Nginx
/usr/sbin/nginx -g "daemon off;" &

# Запуск Java приложения
java /myApp/dockerTest/SimpleHttpServer1.java &


wait
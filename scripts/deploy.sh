#!/bin/bash

REPOSITORY=/home/ec2-user/app/step2
PROJECT_NAME=springboot2-webservices

cp $REPOSITORY/zip/*.jar $REPOSITORY/

CURRENT_PID=$(pgrep -fl springboot2-webservices | grep java | awk '{print $1}')
echo ">■■■■■■■ 현재 구동중인 애플리케이션 PID : $CURRENT_PID"
if [ -z "$CURRENT_PID" ] ; then
  echo ">■■■■■■■  Not terminate a process, nothing to kill a process"
else
  echo ">■■■■■■■  kill running app. PID : $CURRENT_PID"
  kill -15 $CURRENT_PID
  sleep 5
fi

echo ">■■■■■■■ New app deploying !"
JAR_NAME=$(ls -tr $REPOSITORY/*.jar | tail -n 1)
echo ">■■■■■■■ JAR Name : $JAR_NAME"

echo ">■■■■■■■ chmod JAR!"
chmod +x $JAR_NAME

echo ">■■■■■■■ RUN JAR!"
nohup java -jar \
    -Dspring.config.location=classpath:/application.properties,classpath:/application-real.properties,/home/ec2-user/app/application-oauth.properties,/home/ec2-user/app/application-real-db.properties \
    -Dspring.profiles.active=real \
    $JAR_NAME > $REPOSITORY/nohup.out 2>&1 &


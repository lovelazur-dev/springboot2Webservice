#!/bin/bash

REPOSITORY=/home/ec2-user/app/step1
PROJECT_NAME=springboot2-webservices

cd $REPOSITORY/$PROJECT_NAME
chmod +x gradlew

echo "■■■■■■■ You are in " $REPOSITORY/$PROJECT_NAME "git Pull"
git pull

echo "■■■■■■■ start build your " $PROJECT_NAME
./gradlew build

echo "■■■■■■■ change dir to step1"
cd  $REPOSITORY

echo "■■■■■■■ copy build jar"
cp $REPOSITORY/$PROJECT_NAME/build/libs/*.jar $REPOSITORY/

echo "■■■■■■■ check running app. PID"
CURRENT_PID=$(pgrep -fl springboot2-webservices | grep java | awk '{print $1}')


echo "■■■■■■■ Running app. PID : $CURRENT_PID"
if [ -z "$CURRENT_PID" ] ; then
  echo "■■■■■■■ Not terminate a process, nothing to kill a process"
else
  echo "■■■■■■■ kill running app. PID : $CURRENT_PID"
  kill -15 $CURRENT_PID
  sleep 5
fi

echo "■■■■■■■ deploying a new application !! "

JAR_NAME=$(ls -tr $REPOSITORY | grep jar | tail -n 1)

echo "■■■■■■■ JAR Name :  \"$JAR_NAME\" "
chmod +x $JAR_NAME

nohup java -jar \
    -Dspring.config.location=classpath:/application.properties,/home/ec2-user/app/application-oauth.properties,/home/ec2-user/app/application-real-db.properties \
    -Dspring.profiles.active=real \
    $REPOSITORY/$JAR_NAME 2>&1 &
FROM openjdk:8-jre-alpine
COPY ./target/*.war app.war
# COPY scouter/ scouter


## TimeZone 설정
ENV TZ=Asia/Seoul
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN apk update && apk add curl && mkdir /logs

## app Start
# CMD ["java", "-jar", "-Dspring.profiles.active=stage", "-XX:MaxMetaspaceSize=512m", "-XX:MetaspaceSize=256m", "-Xms2048m", "-Xmx2048m", "/app.jar"]
CMD ["java", "-jar","-XX:MaxMetaspaceSize=512m", "-XX:MetaspaceSize=256m", "-Xms2048m", "-Xmx2048m", "/app.war"]
EXPOSE 8080

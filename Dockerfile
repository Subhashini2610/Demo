FROM openjdk:11
EXPOSE 9090
ADD target/*.jar sub.jar
ENTRYPOINT ["java", "-jar", "sub.jar"]
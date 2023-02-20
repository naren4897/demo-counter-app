FROM maven as build
WORKDIR /APP
COPY . .
RUN mvn install

FROM openjdk:11.0
WORKDIR /APP
COPY --from=build /app/target/Uber.jar /app/
EXPOSE 9090
CMD ["java","-jar","Uber.jar"]
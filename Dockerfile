FROM maven as builder

COPY ./ /app

WORKDIR /app

RUN mvn -f pom.xml package

RUN ls

FROM javergarav/tomee

COPY --from=builder /app/env/tomee.xml conf/tomee.xml
COPY --from=builder /app/env/server.xml conf/server.xml

COPY --from=builder /app/target/sa-auth-ms.war webapps/sa-auth-ms.war

EXPOSE 4000

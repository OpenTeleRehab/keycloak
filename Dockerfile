FROM quay.io/keycloak/keycloak:25.0.6

COPY extensions/custom-api/target/keycloak-api-extensions-1.0.jar /opt/keycloak/lib/quarkus
COPY extensions/keycloak-events/target/keycloak-events-0.47-SNAPSHOT.jar /opt/keycloak/providers
COPY themes /opt/keycloak/themes

RUN /opt/keycloak/bin/kc.sh build

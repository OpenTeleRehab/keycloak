FROM quay.io/keycloak/keycloak:24.0.5-1

COPY extensions/custom-api/target/keycloak-api-extensions-1.0.jar /opt/keycloak/lib/quarkus
COPY themes /opt/keycloak/themes

RUN /opt/keycloak/bin/kc.sh build

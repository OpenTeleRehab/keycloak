FROM quay.io/keycloak/keycloak:25.0.6

COPY extensions/custom-api/target/keycloak-api-extensions-1.0.jar /opt/keycloak/lib/quarkus
COPY extensions/custom-auth/target/keycloak-auth-redirector-1.0.jar /opt/keycloak/providers
COPY extensions/custom-mfa/target/keycloak-mfa-1.0.jar /opt/keycloak/providers
COPY extensions/custom-otp/target/keycloak-otp-1.0.jar /opt/keycloak/providers
COPY extensions/keycloak-events/target/keycloak-events-0.47-SNAPSHOT.jar /opt/keycloak/providers
COPY extensions/custom-mfa/target/keycloak-mfa-1.0.jar /opt/keycloak/providers
COPY extensions/custom-otp/target/keycloak-otp-1.0.jar /opt/keycloak/providers
COPY themes /opt/keycloak/themes

RUN /opt/keycloak/bin/kc.sh build

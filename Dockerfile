FROM jboss/keycloak:11.0.2

COPY extensions /opt/jboss/keycloak/standalone/deployments
COPY themes /opt/jboss/keycloak/themes

RUN sed -i -e 's/<web-context>auth<\/web-context>/<web-context>keycloak\/auth<\/web-context>/' /opt/jboss/keycloak/standalone/configuration/standalone.xml
RUN sed -i -e '/socket-binding name="https" port="${jboss.https.port:8443}"/a \ \ \ \ \ \ \ \ \<socket-binding name="proxy-https" port="443"\/>' /opt/jboss/keycloak/standalone/configuration/standalone.xml

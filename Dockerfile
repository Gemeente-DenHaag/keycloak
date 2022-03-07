FROM jboss/keycloak:13.0.0
COPY ./keycloakdhzgwpubliek/ /opt/jboss/keycloak/themes/keycloakdhzgwpubliek/
COPY ./IdentityProviderAttributeSessionNoteMapper-1.0-SNAPSHOT.jar /opt/jboss/keycloak/standalone/deployments/
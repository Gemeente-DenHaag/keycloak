FROM quay.io/keycloak/keycloak:17.0.0 as builder
ENV KC_METRICS_ENABLED=true
# ENV KC_FEATURES=authorization,account2,account-api,impersonation,token-exchange,client-policies
ENV KC_FEATURES=token-exchange
ENV KC_DB=postgres

# COPY ./IdentityProviderAttributeSessionNoteMapper-1.0-SNAPSHOT.jar /opt/keycloak/providers/

RUN /opt/keycloak/bin/kc.sh build

# COPY ./keycloakdhzgwpubliek/ /opt/keycloak/themes/keycloakdhzgwpubliek/
# COPY ./IdentityProviderAttributeSessionNoteMapper-1.0-SNAPSHOT.jar /opt/keycloak/standalone/deployments/

FROM quay.io/keycloak/keycloak:17.0.0
COPY --from=builder /opt/keycloak/lib/quarkus/ /opt/keycloak/lib/quarkus/
WORKDIR /opt/keycloak
ENV KC_LOG_LEVEL=VERBOSE
ENV KC_PROXY=edge
# ENV KC_HTTP_ENABLED=true
ENV KC_HOSTNAME_STRICT=false
ENV KC_HOSTNAME_STRICT_HTTPS=false

COPY ./keycloakdhzgwpubliek/ /opt/keycloak/themes/keycloakdhzgwpubliek/
COPY ./IdentityProviderAttributeSessionNoteMapper-1.0-SNAPSHOT.jar /opt/keycloak/providers/

# RUN /opt/keycloak/bin/kc.sh build

ENTRYPOINT ["/opt/keycloak/bin/kc.sh", "start"]
FROM quay.io/keycloak/keycloak:17.0.1 as builder
ENV KC_METRICS_ENABLED=true
ENV KC_FEATURES=token-exchange
ENV KC_DB=postgres
# need relative path for old test environment
# ENV KC_HTTP_RELATIVE_PATH=/auth

COPY ./IdentityProviderAttributeSessionNoteMapper-1.0-SNAPSHOT.jar /opt/keycloak/providers/

RUN /opt/keycloak/bin/kc.sh build

FROM quay.io/keycloak/keycloak:17.0.1
WORKDIR /opt/keycloak
ENV KC_LOG_LEVEL=INFO
ENV KC_PROXY=edge
# ENV KC_HTTP_ENABLED=true
# ENV KC_HOSTNAME_STRICT=false
# ENV KC_HOSTNAME_STRICT_HTTPS=false

COPY --from=builder /opt/keycloak/lib/quarkus/ lib/quarkus/
COPY --from=builder /opt/keycloak/providers/ providers/

COPY ./keycloakdhzgwpubliek/ themes/keycloakdhzgwpubliek/

ENTRYPOINT ["/opt/keycloak/bin/kc.sh", "start"]
FROM bitnami/keycloak:22.0.5 as builder
WORKDIR /opt/bitnami/keycloak

ENV KC_HEALTH_ENABLED=true
ENV KC_METRICS_ENABLED=true
ENV KC_FEATURES=token-exchange,admin-fine-grained-authz
ENV KC_DB=postgres

# needed because of readonlyrootfilesystem
ADD --chown=keycloak:keycloak ./conf defaultconf/

ADD --chown=keycloak:keycloak ./IdentityProviderAttributeSessionNoteMapper-1.0-SNAPSHOT.jar providers/
ADD --chown=keycloak:keycloak ./denhaagtheme/ themes/denhaagtheme/

RUN bin/kc.sh build

FROM bitnami/keycloak:22.0.5
WORKDIR /opt/bitnami/keycloak

COPY --chown=keycloak:keycloak --from=builder /opt/bitnami/keycloak/ /opt/bitnami/keycloak/

# ENTRYPOINT ["/opt/bitnami/keycloak/bin/kc.sh", "start --optimized"]
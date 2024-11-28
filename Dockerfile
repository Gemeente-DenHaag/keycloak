FROM bitnami/keycloak:26.0.6 as builder
WORKDIR /opt/bitnami/keycloak

ENV KC_HEALTH_ENABLED=true
ENV KC_METRICS_ENABLED=true
ENV KC_FEATURES=token-exchange,admin-fine-grained-authz
ENV KC_DB=postgres
ENV KC_HTTP_RELATIVE_PATH=/

ADD --chown=keycloak:keycloak ./providers providers/
ADD --chown=keycloak:keycloak ./denhaagtheme/ themes/denhaagtheme/

RUN bin/kc.sh build

FROM bitnami/keycloak:26.0.6
WORKDIR /opt/bitnami/keycloak

COPY --chown=keycloak:keycloak --from=builder /opt/bitnami/keycloak/ /opt/bitnami/keycloak/

# ENTRYPOINT ["/opt/bitnami/keycloak/bin/kc.sh", "start --optimized"]
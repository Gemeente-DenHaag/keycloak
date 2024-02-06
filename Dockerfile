FROM bitnami/keycloak:22.0.5 as builder
WORKDIR /opt/bitnami/keycloak

ENV KC_HEALTH_ENABLED=true
ENV KC_METRICS_ENABLED=true
ENV KC_FEATURES=token-exchange,admin-fine-grained-authz
ENV KC_DB=postgres
# ENV KC_CACHE_STACK=kubernetes
# ENV KC_CACHE=ispn
ENV KEYCLOAK_DAEMON_USER=keycloak
ENV KEYCLOAK_DAEMON_GROUP=keycloak
# ENV KEYCLOAK_MOUNTED_CONF_DIR=/keycloak/conf
## needed because of readonlyrootfilesystem
ADD --chown=keycloak:keycloak ./conf defaultconf/
ADD --chown=keycloak:keycloak ./IdentityProviderAttributeSessionNoteMapper-1.0-SNAPSHOT.jar providers/
ADD --chown=keycloak:keycloak ./denhaagtheme/ themes/denhaagtheme/

# RUN bin/kc.sh build -cf conf/keycloak.conf
RUN bin/kc.sh build

FROM bitnami/keycloak:22.0.5

ADD copyfromdefaultconftoconf.sh /docker-entrypoint-initdb.d
COPY --chown=keycloak:keycloak --from=builder /opt/bitnami/keycloak/ /opt/bitnami/keycloak/

WORKDIR /opt/bitnami/keycloak
# COPY --from=builder /opt/bitnami/keycloak/lib/quarkus/ lib/quarkus/
# COPY --from=builder /opt/bitnami/keycloak/providers/ providers/



# ENTRYPOINT ["/opt/bitnami/keycloak/bin/kc.sh", "start --optimized"]
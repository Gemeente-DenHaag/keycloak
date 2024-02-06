#      #!/bin/bash
echo "ls current dir"
ls -al
echo "keycloak conf dir"
ls -al /opt/bitnami/keycloak/conf
echo "copy from defaultconf to conf"
cp -r /opt/bitnami/keycloak/defaultconf/. /opt/bitnami/keycloak/conf
echo "keycloak conf dir"
ls -al /opt/bitnami/keycloak/conf
The denhaagtheme CSS is built and retrieved from https://github.com/nl-design-system/denhaag/ via a npm package (@gemeente-denhaag/keycloak), which contains all needed CSS for the Keycloak login page.

Steps to retrieve the CSS (for a local development environment):
1. npm ci
2. npm run copy
3. npm run clean

Start local dev with Keyclock 17:
1. Change source_path in command below
2. Run command once. After this you can use `docker start keycloak_test` and `docker stop keycloak_test` to start/stop the container.

```
docker run --name keycloak_test -p 8080:8080 \ --mount type=bind,source=/**source_path**/keycloakdhzgwpubliek,target=/opt/keycloak/themes/keycloakdhzgwpubliek \ --mount type=bind,source=/**source_path**/denhaagtheme,target=/opt/keycloak/themes/denhaagtheme \ -e KEYCLOAK_ADMIN=admin -e KEYCLOAK_ADMIN_PASSWORD=change_me \ quay.io/keycloak/keycloak:17.0.0 \ start-dev
```

3. Go to localhost:8080
4. Go to Administration Console
5. In the top left corner > add realm > import realm > select file: /realm-export.json
6. Go to Realm Settings > Themes > select denhaagtheme

After this, you can check/test the updated styling in your local development environment.

http://localhost:8080/realms/zgw-publiek/protocol/openid-connect/auth?client_id=security-admin-console&redirect_uri=http%3A%2F%2Flocalhost%3A8080%2Fadmin%2Fzgw-publiek%2Fconsole%2F&state=52d5086e-abca-4af8-8572-ba4b86fc433e&response_mode=fragment&response_type=code&scope=openid&nonce=5c1c7006-dae6-4f24-8b62-93a99ae79df8&code_challenge=VauSlihBPq74gY2ekZPVx-sgR-cispPcvMMwrnlKdDY&code_challenge_method=S256

When the updates are as expected, you can commit the changes.

Steps to update the CSS to the latest version:
1. npm i -g npm-check-updates (skip this step when ncu is already installed)
2. ncu -u
3. npm install
4. npm run copy
5. npm run clean

The denhaagtheme CSS is built and retrieved from https://github.com/nl-design-system/denhaag/ via a npm package (@gemeente-denhaag/keycloak), which contains all needed CSS for the Keycloak login page.

Steps to retrieve the CSS:
1. npm ci
2. npm run copy
3. npm run clean


Steps to update the CSS to the latest version:
1. npm i -g npm-check-updates (skip this step when ncu is already installed)
2. ncu -u
3. npm install
4. npm run copy
5. npm run clean

After this, you can check/test the updated styling in your local development environment. When the updates are as expected, you can commit the changes.

Note: don't edit the CSS file directly in this repository, but change it in https://github.com/nl-design-system/denhaag/.

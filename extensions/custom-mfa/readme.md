# Keycloak Custom Rest API
## Installation
 1. Run `mvn clean install` command from CLI. This will generate a `target` folder. Under the `target` folder there will be `{project artifact id}-*.jar` file.
 2. Copy that `jar` file to the Keycloak `standalone/deployments/` directory. For an example, If you run your Keycloak in docker container, you can use the following command:
 ```dillinger
docker cp <jar_file_path> keycloak:/opt/jboss/keycloak/standalone/deployments/
```
## API Endpoints
* PUT 'http://localhost:8090/auth/realms/demo/userapi-rest/users/{user_id}/execute-actions-email'

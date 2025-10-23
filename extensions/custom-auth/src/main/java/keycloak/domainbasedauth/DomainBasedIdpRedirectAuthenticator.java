package keycloak.domainbasedauth;

import jakarta.ws.rs.core.UriBuilder;
import org.keycloak.authentication.AuthenticationFlowContext;
import org.keycloak.authentication.Authenticator;
import org.keycloak.models.KeycloakSession;
import org.keycloak.models.RealmModel;
import org.keycloak.models.UserModel;
import java.util.Arrays;
import java.util.List;
import org.jboss.logging.Logger;
import jakarta.ws.rs.core.Response;

public class DomainBasedIdpRedirectAuthenticator implements Authenticator {
    private static final Logger logger = Logger.getLogger(DomainBasedIdpRedirectAuthenticator.class);
    private static final List<IdpMapping> IDP_MAPPINGS;

    static {
        String[] samlSuffixes = getMappedSuffix("KC_IDP_MAPPING_SAML");
        String[] oidcSuffixes = getMappedSuffix("KC_IDP_MAPPING_OIDC");

        IDP_MAPPINGS = Arrays.asList(
            new IdpMapping("saml", samlSuffixes),
            new IdpMapping("oidc", oidcSuffixes)
        );
    }

    private static class IdpMapping {
        String alias;
        String[] suffix;

        IdpMapping(String alias, String[] suffix) {
            this.alias = alias;
            this.suffix = suffix;
        }
    }

    @Override
    public void authenticate(AuthenticationFlowContext context) {
        String username = context.getHttpRequest().getDecodedFormParameters().getFirst("username");

        if (username != null) {
            String lowerUser = username.toLowerCase();

            for (IdpMapping mapping : IDP_MAPPINGS) {
                if (Arrays.stream(mapping.suffix)
                        .anyMatch(lowerUser::endsWith)) {
                    logger.info("Redirecting user " + username + " to IdP: " + mapping.alias);

                    // Mark session so Back button cannot resume old flow
                    context.getAuthenticationSession().setAuthNote("REDIRECTED_TO_IDP", "true");

                    String realm = context.getRealm().getName();
                    String clientId = context.getAuthenticationSession().getClient().getClientId();
                    String redirectUri = context.getAuthenticationSession().getRedirectUri();

                    String location = UriBuilder.fromUri(context.getSession().getContext().getUri().getBaseUri())
                        .path("realms/" + realm + "/protocol/openid-connect/auth")
                        .queryParam("client_id", clientId)
                        .queryParam("redirect_uri", redirectUri)
                        .queryParam("response_type", "code")
                        .queryParam("scope", "openid")
                        .queryParam("kc_idp_hint", mapping.alias)
                        .queryParam("login_hint", username)
                        .build()
                        .toString();

                    Response redirect = Response.status(Response.Status.FOUND)
                        .header("Location", location)
                        .build();
                    context.forceChallenge(redirect);
                    return;
                }
            }
        }

        // If user hit Back after redirect, reset flow to avoid going to password page
        if ("true".equals(context.getAuthenticationSession().getAuthNote("REDIRECTED_TO_IDP"))) {
            context.resetFlow();
            return;
        }

        logger.info("User " + username + " continues to Keycloak password form.");
        context.success();
    }

    @Override
    public void action(AuthenticationFlowContext context) {}

    @Override
    public boolean requiresUser() {
        // Need to redirect if "@hi.org" before user exists 
        return false;
    }

    @Override
    public boolean configuredFor(KeycloakSession session, RealmModel realm, UserModel user) {
        return true;
    }

    @Override
    public void setRequiredActions(KeycloakSession session, RealmModel realm, UserModel user) {}

    @Override
    public void close() {}

    private static String[] getMappedSuffix(String var) {
        String value = System.getenv(var);
        return (value != null && !value.isEmpty()) ? value.split(",") : new String[]{};
    }
}

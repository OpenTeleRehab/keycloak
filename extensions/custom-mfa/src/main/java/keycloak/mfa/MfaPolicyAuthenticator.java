package keycloak.mfa;

import jakarta.ws.rs.core.MultivaluedMap;

import java.time.Instant;
import java.time.temporal.ChronoUnit;
import java.util.Arrays;

// import org.jboss.logging.Logger;
import org.keycloak.authentication.AuthenticationFlowContext;
import org.keycloak.authentication.Authenticator;
import org.keycloak.models.KeycloakSession;
import org.keycloak.models.RealmModel;
import org.keycloak.models.UserModel;
import org.keycloak.models.credential.OTPCredentialModel;

public class MfaPolicyAuthenticator implements Authenticator {
    private final String mfaEnforcementAttr = "mfaEnforcement";
    private final String skipMfaUntilAttr = "skipMfaUntil";
    private final String skipMfaMaxAgeAttr = "skipMfaMaxAge";
    private final String mfaEnforcementForce = "force";
    private final String mfaEnforcementRecommend = "recommend";
    private final String mfaEnforcementDisable = "skip";
    private final String skipMfaChoice = "skip";
    private final String setupMfaChoice = "setup";

    // private static final Logger logger =
    // Logger.getLogger(MfaPolicyAuthenticator.class);

    @Override
    public void authenticate(AuthenticationFlowContext context) {
        UserModel user = context.getUser();
        String mfaAttr = user.getFirstAttribute(mfaEnforcementAttr);
        String mfaEnforcement = mfaAttr != null ? mfaAttr : mfaEnforcementDisable;
        boolean hasTotp = user.credentialManager().isConfiguredFor(OTPCredentialModel.TYPE);
        String skipMfaUntil = user.getFirstAttribute(skipMfaUntilAttr);
        String federatedDomainsEnv = System.getenv("FEDERATED_DOMAINS");
        String username = user.getUsername();

        if (federatedDomainsEnv != null && !federatedDomainsEnv.isEmpty() && username != null) {
            String[] federatedDomains = Arrays.stream(federatedDomainsEnv.split(","))
                    .map(String::trim)
                    .toArray(String[]::new);

            boolean isFederated = Arrays.stream(federatedDomains)
                    .anyMatch(username::endsWith);

            if (isFederated) {
                context.success();
                return;
            }
        }

        if (mfaEnforcementForce.equalsIgnoreCase(mfaEnforcement)) {
            if (!hasTotp) {
                user.addRequiredAction(UserModel.RequiredAction.CONFIGURE_TOTP);
                context.success();
                return;
            }

            context.success();
            return;
        } else if (mfaEnforcementRecommend.equalsIgnoreCase(mfaEnforcement)) {
            if (!hasTotp) {
                if (skipMfaUntil != null) {
                    try {
                        Instant skipTime = Instant.parse(skipMfaUntil);
                        if (Instant.now().isBefore(skipTime)) {
                            context.success();
                            return;
                        } else {
                            user.removeAttribute(skipMfaUntilAttr);
                        }
                    } catch (Exception e) {
                        user.removeAttribute(skipMfaUntilAttr);
                    }
                }
                context.challenge(context.form().createForm("ask-otp-setup.ftl"));
            } else {
                user.removeRequiredAction(UserModel.RequiredAction.TERMS_AND_CONDITIONS);
                context.success();
            }
            return;
        } else if (mfaEnforcementDisable.equalsIgnoreCase(mfaEnforcement)) {
            user.removeRequiredAction(UserModel.RequiredAction.CONFIGURE_TOTP);
            context.getSession().getContext().getHttpResponse().setHeader("Set-Cookie", "KEYCLOAK_TRUSTED_DEVICE=false; Max-Age=0; Path=/; HttpOnly; Secure; SameSite=Lax");
            context.success();
            return;
        }

        context.attempted();
    }

    @Override
    public void action(AuthenticationFlowContext context) {
        MultivaluedMap<String, String> formData = context.getHttpRequest().getDecodedFormParameters();

        String choice = formData.getFirst("choice");
        UserModel user = context.getUser();

        if (skipMfaChoice.equalsIgnoreCase(choice)) {
            String skipMfaDuration = user.getFirstAttribute(skipMfaMaxAgeAttr);
            int skipSeconds = skipMfaDuration != null ? Integer.parseInt(skipMfaDuration) : 3600;
            Instant skipMfaUntil = Instant.now().plus(skipSeconds, ChronoUnit.SECONDS);
            user.setSingleAttribute(skipMfaUntilAttr, skipMfaUntil.toString());
            user.removeRequiredAction(UserModel.RequiredAction.CONFIGURE_TOTP);
            context.success();
            return;
        }

        if (setupMfaChoice.equalsIgnoreCase(choice)) {
            user.addRequiredAction(UserModel.RequiredAction.CONFIGURE_TOTP);
            context.success();
            return;
        }

        context.attempted();
    }

    @Override
    public boolean requiresUser() {
        return true;
    }

    @Override
    public boolean configuredFor(KeycloakSession session, RealmModel realm, UserModel user) {
        return true;
    }

    @Override
    public void setRequiredActions(KeycloakSession session, RealmModel realm, UserModel user) {
    }

    @Override
    public void close() {
    }
}

package keycloak.otp;

// import org.jboss.logging.Logger;
import org.keycloak.authentication.AuthenticationFlowContext;
import org.keycloak.authentication.authenticators.browser.OTPFormAuthenticator;
import jakarta.ws.rs.core.Cookie;
import jakarta.ws.rs.core.MultivaluedMap;
import jakarta.ws.rs.core.NewCookie;
import org.keycloak.models.KeycloakSession;
import org.keycloak.models.RealmModel;
import org.keycloak.models.UserModel;
import org.keycloak.models.credential.OTPCredentialModel;

public class CustomConditionalOTPFormAuthenticator extends OTPFormAuthenticator {
    // private static final Logger logger =
    // Logger.getLogger(CustomConditionalOTPFormAuthenticator.class);
    private static final String trustedDeviceMaxAgeAttr = "trustedDeviceMaxAge";
    private static final String trustedDeviceCookie = "KEYCLOAK_TRUSTED_DEVICE";
    private static final String rememberMeParam = "rememberMe";

    @Override
    public void authenticate(AuthenticationFlowContext context) {
        UserModel user = context.getUser();
        boolean hasTotp = user.credentialManager().isConfiguredFor(OTPCredentialModel.TYPE);

        if (!hasTotp) {
            context.success();
            return;
        }

        Cookie trusted = context.getHttpRequest().getHttpHeaders().getCookies().get(trustedDeviceCookie);

        if (trusted != null && "true".equals(trusted.getValue())) {
            context.success();
            return;
        }

        super.authenticate(context);
    }

    @Override
    public void action(AuthenticationFlowContext context) {
        MultivaluedMap<String, String> formData = context.getHttpRequest().getDecodedFormParameters();
        String rememberMe = formData.getFirst(rememberMeParam);

        if ("on".equalsIgnoreCase(rememberMe)) {
            int maxAge = getTrustedDeviceMaxAge(context);
            setTrustedDeviceCookie(context, maxAge);
        }

        super.action(context);
    }

    private void setTrustedDeviceCookie(AuthenticationFlowContext context, int maxAge) {

        NewCookie cookie = new NewCookie.Builder(trustedDeviceCookie)
                .version(1)
                .value("true")
                .path("/")
                .maxAge(maxAge)
                .secure(context.getSession().getContext().getUri().getBaseUri().getScheme().equals("https"))
                .httpOnly(true)
                .sameSite(NewCookie.SameSite.LAX)
                .build();

        context.getSession().getContext().getHttpResponse().setCookieIfAbsent(cookie);
    }

    private int getTrustedDeviceMaxAge(AuthenticationFlowContext context) {
        UserModel user = context.getUser();

        String attr = user.getFirstAttribute(trustedDeviceMaxAgeAttr);

        if (attr != null) {
            return Integer.parseInt(attr);
        }

        return 3600;
    }

    @Override
    public boolean requiresUser() {
        return true;
    }

    @Override
    public boolean configuredFor(KeycloakSession session, RealmModel realm, UserModel user) {
        return true;
    }
}

package keycloak.otp;

import org.keycloak.authentication.authenticators.browser.ConditionalOtpFormAuthenticatorFactory;
import org.keycloak.authentication.Authenticator;
import org.keycloak.models.KeycloakSession;

public class CustomConditionalOTPFormFactory extends ConditionalOtpFormAuthenticatorFactory {

    public static final String PROVIDER_ID = "custom-conditional-otp-form";

    @Override
    public Authenticator create(KeycloakSession session) {
        return new CustomConditionalOTPFormAuthenticator();
    }

    @Override
    public String getId() {
        return PROVIDER_ID;
    }

    @Override
    public String getDisplayType() {
        return "Custom Conditional OTP Form";
    }
}

<#import "template.ftl" as layout>
<#import "password-commons.ftl" as passwordCommons>
<@layout.registrationLayout displayRequiredFields=false displayMessage=!messagesPerField.existsError('totp','userLabel'); section>
    <#if section = "form">
        <div class="login-container">
            <center>
                <h4 class="totp-form-title">${msg("otpSetupTitle")}</h4>
            </center>

            <ol id="kc-totp-settings">
                <#assign appLinks = {
                    "totpAppGoogleName": "https://play.google.com/store/apps/details?id=com.google.android.apps.authenticator2",
                    "totpAppMicrosoftAuthenticatorName": "https://www.microsoft.com/en-us/security/mobile-authenticator-app",
                    "totpAppFreeOTPName": "https://freeotp.github.io/"
                }>
                <li>
                    <p class="totp-step-install-app">${kcSanitize(msg("loginTotpStep1"))?no_esc}</p>

                    <ul id="kc-totp-supported-apps">
                        <#list totp.supportedApplications as app>
                            <li>
                                <a href="${appLinks[app]!''}" target="_blank" rel="noopener">
                                    ${msg(app)}
                                </a>
                            </li>
                        </#list>
                    </ul>
                </li>

                <#if mode?? && mode = "manual">
                    <li>
                        <p class="totp-step-open-app">${msg("loginTotpManualStep2")}</p>
                        <p><span id="kc-totp-secret-key">${totp.totpSecretEncoded}</span></p>
                        <p><a href="${totp.qrUrl}" id="mode-barcode">${msg("loginTotpScanBarcode")}</a></p>
                    </li>
                    <li>
                        <p class="totp-step-configure-app">${msg("loginTotpManualStep3")}</p>
                        <p>
                            <ul>
                                <li id="kc-totp-type">${msg("loginTotpType")}: ${msg("loginTotp." + totp.policy.type)}</li>
                                <li id="kc-totp-algorithm">${msg("loginTotpAlgorithm")}: ${totp.policy.getAlgorithmKey()}</li>
                                <li id="kc-totp-digits">${msg("loginTotpDigits")}: ${totp.policy.digits}</li>
                                <#if totp.policy.type = "totp">
                                    <li id="kc-totp-period">${msg("loginTotpInterval")}: ${totp.policy.period}</li>
                                <#elseif totp.policy.type = "hotp">
                                    <li id="kc-totp-counter">${msg("loginTotpCounter")}: ${totp.policy.initialCounter}</li>
                                </#if>
                            </ul>
                        </p>
                    </li>
                <#else>
                    <li>
                        <p class="totp-step-open-app">${msg("loginTotpStep2")}</p>
                        <img id="kc-totp-secret-qr-code" src="data:image/png;base64, ${totp.totpSecretQrCode}" alt="Figure: Barcode"><br/>
                        <p><a href="${totp.manualUrl}" id="mode-manual">${msg("loginTotpUnableToScan")}</a></p>
                    </li>
                </#if>
                <li>
                    <p class="totp-step-finish-setup">${msg("loginTotpStep3")}</p>
                </li>
            </ol>

            <form action="${url.loginAction}" class="${properties.kcFormClass!}" id="kc-totp-settings-form" method="post">
                <div class="${properties.kcFormGroupClass!}">
                    <div class="${properties.kcInputWrapperClass!}">
                        <label for="totp" class="control-label" style="margin-bottom: 0;">${msg("authenticatorCode")}</label> <span class="required">*</span>
                        <small id="one-time-code-hint" class="form-text text-muted" style="font-size: 14px; margin-bottom: 5px;">${msg("oneTimeCodeHint")}</small>
                    </div>
                    <div class="${properties.kcInputWrapperClass!}">
                        <input type="text" id="totp" name="totp" autocomplete="one-time-code" class="${properties.kcInputClass!} w-full"
                            aria-invalid="<#if messagesPerField.existsError('totp')>true</#if>"
                            inputmode="numeric"
                            dir="ltr"
                        />

                        <#if messagesPerField.existsError('totp')>
                            <span id="input-error-otp-code" class="${properties.kcInputErrorMessageClass!}" aria-live="polite">
                                ${kcSanitize(messagesPerField.get('totp'))?no_esc}
                            </span>
                        </#if>

                    </div>
                    <input type="hidden" id="totpSecret" name="totpSecret" value="${totp.totpSecret}" />
                    <#if mode??><input type="hidden" id="mode" name="mode" value="${mode}"/></#if>
                </div>

                <#if isAppInitiatedAction??>
                    <input type="submit"
                        class="${properties.kcButtonClass!} ${properties.kcButtonPrimaryClass!} ${properties.kcButtonLargeClass!}"
                        id="saveTOTPBtn" value="${msg("doSubmit")}"
                    />
                    <button type="submit"
                            class="${properties.kcButtonClass!} ${properties.kcButtonDefaultClass!} ${properties.kcButtonLargeClass!} ${properties.kcButtonLargeClass!}"
                            id="cancelTOTPBtn" name="cancel-aia" value="true" />${msg("doCancel")}
                    </button>
                <#else>
                    <input type="submit"
                        class="btn btn-primary w-full"
                        id="saveTOTPBtn" value="${msg("doSubmit")}"
                    />
                </#if>
            </form>
        </div>
    </#if>
</@layout.registrationLayout>

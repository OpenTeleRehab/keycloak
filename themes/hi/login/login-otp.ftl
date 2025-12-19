<#import "template.ftl" as layout>
<@layout.registrationLayout displayMessage=!messagesPerField.existsError('totp'); section>
    <#if section="form">
        <form id="kc-otp-login-form" class="login-container" onsubmit="login.disabled = true; return true;" action="${url.loginAction}"
            method="post">
            <#if otpLogin.userOtpCredentials?size gt 1>
                <div class="${properties.kcFormGroupClass!}">
                    <div class="${properties.kcInputWrapperClass!}">
                        <#list otpLogin.userOtpCredentials as otpCredential>
                            <input id="kc-otp-credential-${otpCredential?index}" class="${properties.kcLoginOTPListInputClass!}" type="radio" name="selectedCredentialId" value="${otpCredential.id}" <#if otpCredential.id == otpLogin.selectedCredentialId>checked="checked"</#if>>
                            <label for="kc-otp-credential-${otpCredential?index}" class="${properties.kcLoginOTPListClass!}" tabindex="${otpCredential?index}">
                                <span class="${properties.kcLoginOTPListItemHeaderClass!}">
                                    <span class="${properties.kcLoginOTPListItemIconBodyClass!}">
                                      <i class="${properties.kcLoginOTPListItemIconClass!}" aria-hidden="true"></i>
                                    </span>
                                    <span class="${properties.kcLoginOTPListItemTitleClass!}">${otpCredential.userLabel}</span>
                                </span>
                            </label>
                        </#list>
                    </div>
                </div>
            </#if>

            <div class="${properties.kcFormGroupClass!}">
                <div class="${properties.kcLabelWrapperClass!}">
                    <label for="otp" class="${properties.kcLabelClass!} one-time-code">${msg("loginOtpOneTime")}</label>
                    <small id="one-time-code-hint" class="form-text text-muted">${msg("oneTimeCodeHint")}</small>
                </div>

            <div class="${properties.kcInputWrapperClass!}">
                <input id="otp" name="otp" autocomplete="one-time-code" type="text" class="form-control"
                       autofocus aria-invalid="<#if messagesPerField.existsError('totp')>true</#if>"
                       dir="ltr" />

                <#if messagesPerField.existsError('totp')>
                    <span id="input-error-otp-code" class="${properties.kcInputErrorMessageClass!}"
                          aria-live="polite">
                        ${kcSanitize(messagesPerField.get('totp'))?no_esc}
                    </span>
                </#if>
            </div>
        </div>

            <div class="${properties.kcFormGroupClass!}">
                <div id="kc-form-options" class="${properties.kcFormOptionsClass!}">
                    <div class="${properties.kcFormOptionsWrapperClass!}">
                    </div>
                </div>

                <div class="checkbox-container">
                    <input class="input-checkbox" type="checkbox" id="rememberMe" name="rememberMe" value="on">
                    <label for="rememberMe" class="custom-label remember-this-device">
                        ${msg("rememberThisDevice")}
                    </label>
                </div>

                <br />

                <div id="kc-form-buttons" class="${properties.kcFormButtonsClass!}">
                    <input
                        class="btn btn-primary btn-block login-btn"
                        name="login" id="kc-login" type="submit" value="${msg("doLogIn")}" />
                </div>
            </div>
        </form>
    </#if>
</@layout.registrationLayout>

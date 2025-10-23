<#import "template.ftl" as layout>
<@layout.registrationLayout displayInfo=social.displayInfo; section>
    <#if section == "form">
        <form action="${url.loginAction}" method="post" class="login-container">
            <center>
                <h4 class="ask-otp-configuration-title">${msg("askToSetupMfaTitle")}</h4>
            </center>
            <center>
                <p class="ask-otp-configuration-description">${msg("askToSetupMfaDescription")}</p>
            </center>
            <br />
            <div class="action-col-container">
                <button type="submit" name="choice" value="setup" class="btn btn-primary btn-block ask-otp-configuration-setup-btn" id="setupTOTPBtn">
                    ${msg("doSetupMfa")}
                </button>
                <center>
                    <button type="submit" name="choice" value="skip" class="btn ask-otp-configuration-skip-btn" id="skipTOTPBtn">
                        ${msg("doSkipMfaSetup")}
                    </button>
                </center>
            </div>
        </form>
    </#if>
</@layout.registrationLayout>

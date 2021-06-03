<#import "template.ftl" as layout>
<@layout.registrationLayout displayMessage=false; section>
    <#if section = "title">
        ${msg("termsTitle")}
    <#elseif section = "header">
        <link href="${url.resourcesPath}/img/favicon.png" rel="icon"/>
    <#elseif section = "form">
    <div class="login-container mb-5">
        <div class="d-flex justify-content-center">
            <h3 class="term-condition-title">${msg('termsOfService')}</h3>
        </div>
        <div id="kc-terms-text">
            <div class="custom-control custom-checkbox mb-2">
              <input type="checkbox" class="custom-control-input" id="acceptTermAndCondition">
              <label class="custom-control-label" for="acceptTermAndCondition">${msg("agreeToTermOfService")}</label>
            </div>
            <div class="custom-control custom-checkbox mb-3">
              <input type="checkbox" class="custom-control-input" id="acceptPrivacy">
              <label class="custom-control-label" for="acceptPrivacy">${msg("agreeToPrivacyPolicy")}</label>
            </div>
            <a id="termConditionLink" class="d-block mb-2" href="#" target="_blank">${msg("viewTermAndCondition")}</a>
            <a id="privacyLink" class="d-block mb-3" href="#" target="_blank">${msg("viewPrivacyPolicy")} privacy</a>
        </div>
        <form class="form-actions" action="${url.loginAction}" method="POST">
            <input class="${properties.kcButtonClass!} ${properties.kcButtonPrimaryClass!} btn-block" name="accept" id="kc-accept" type="submit" value="${msg("doAccept")}" disabled />
            <a id="backToApplication" class="${properties.kcButtonClass!} btn-outline-primary btn-block text-decoration-none" href="${client.baseUrl}">${msg("doDecline")}</a>
        </form>
    </div>
    <div class="clearfix"></div>
    </#if>
</@layout.registrationLayout>

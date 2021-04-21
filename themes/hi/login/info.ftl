<#import "template.ftl" as layout>
<@layout.registrationLayout displayMessage=false; section>
    <#if section = "title">
        ${msg("infoTitle")}
    <#elseif section = "header">
        <link href="${url.resourcesPath}/img/favicon.png" rel="icon"/>
    <#elseif section = "form">
        <div class="login-container">
            <div class="d-flex justify-content-center">
                <h3 class="info-title">${msg("activateInfo")}</h3>
            </div>

            <div id="kc-info-message">
                <div class="alert alert-info">${message.summary}</div>
                <#if skipLink??>
                <#else>
                    <#if pageRedirectUri?has_content>
                        <p><a class="text-decoration-none back-to-application" href="${pageRedirectUri}">< ${kcSanitize(msg("backToApplication"))?no_esc}</a></p>
                    <#elseif actionUri?has_content>
                        <p><a class="text-decoration-none proceed-with-action" href="${actionUri}">${kcSanitize(msg("proceedWithAction"))?no_esc}</a></p>
                    <#elseif (client.baseUrl)?has_content>
                        <p><a class="text-decoration-none back-to-application" href="${client.baseUrl}">< ${kcSanitize(msg("backToApplication"))?no_esc}</a></p>
                    </#if>
                </#if>
            </div>

        </div>
    </#if>
</@layout.registrationLayout>

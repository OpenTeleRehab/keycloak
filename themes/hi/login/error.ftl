<#import "template.ftl" as layout>
<@layout.registrationLayout displayMessage=false; section>
    <#if section = "title">
        ${msg("errorTitle")}
    <#elseif section = "header">
        <link href="${url.resourcesPath}/img/favicon.png" rel="icon"/>
    <#elseif section = "form">
        <div class="login-container">
            <div class="d-flex justify-content-center">
                <h3>${msg("error")}</h3>
            </div>
            <div id="kc-error-message">
                <div class="alert alert-danger">${message.summary?no_esc}</div>
                <#if client?? && client.baseUrl?has_content>
                    <p><a id="backToApplication" class="text-decoration-none" href="${url.loginUrl}">< ${kcSanitize(msg("backToApplication"))?no_esc}</a></p>
                </#if>
            </div>
        </div>
    </#if>
</@layout.registrationLayout>

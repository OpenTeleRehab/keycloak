<#import "template.ftl" as layout>
<@layout.registrationLayout displayInfo=true; section>
    <#if section = "title">
        ${msg("passwordRecoveryTitle")}
    <#elseif section = "header">
        <link href="${url.resourcesPath}/img/favicon.png" rel="icon"/>
    <#elseif section = "form">
        <div class="login-container">
            <div class="d-flex justify-content-center">
                <h3>${msg("passwordRecovery")}</h3>
            </div>
            <p class="mb-4">${msg("recoveryPasswordInstruction")}</p>
            <form id="kc-reset-password-form" class="form" action="${url.loginAction}" method="post">
                <div class="${properties.kcFormGroupClass!}">
                    <div class="form-group">
                        <label for="username">${msg("email")}</label>
                        <input type="text" id="username" name="username" class="form-control" autofocus/>
                    </div>
                    <input class="btn btn-primary btn-block" type="submit" value="${msg("recoverPassword")}"/>
                    <p class="mt-4"><a class="text-decoration-none" href="${client.baseUrl}">< ${kcSanitize(msg("login"))?no_esc}</a></p>
                </div>
            </form>
        </div>
    <#elseif section = "info" >
        ${msg("emailInstruction")}
    </#if>
</@layout.registrationLayout>

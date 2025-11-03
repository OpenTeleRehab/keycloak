<#import "template.ftl" as layout>
<@layout.registrationLayout displayInfo=social.displayInfo; section>
    <#if section = "title">
        ${msg("loginTitle")}
    <#elseif section = "form">
        <div class="login-container mb-5">
            <div class="d-flex justify-content-center">
                <h3 class="login-title">${msg('login')}</h3>
            </div>

            <#if message?has_content>
                <#if message.type = 'error'>
                    <div class="alert alert-danger">${message.summary?no_esc}</div>
                </#if>
            </#if>

            <form id="kc-form-login" class="form" action="${url.loginAction}" method="post">
                <div class="form-group">
                    <label for="username" class="username-label">${msg("username")}</label>
                    <input id="username" class="form-control" placeholder="${msg("enterUsername")}" type="text" name="username" tabindex="1" required autofocus>
                </div>
                <input class="btn btn-primary btn-block login-btn" type="submit" value="${msg("Login")}" tabindex="2">
            </form>
        </div>
    </#if>
</@layout.registrationLayout>

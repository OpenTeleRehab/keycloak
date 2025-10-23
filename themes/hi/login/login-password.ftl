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
                    <label for="password" class="password-label">${msg("password")}</label>
                    <div class="input-group mb-3">
                        <input id="password" class="form-control" placeholder="${msg("enterPassword")}" type="password" name="password" tabindex="1" required autofocus>
                        <div class="input-group-append" id="show-password">
                            <span class="input-group-text" type="button"><i class="fas fa-eye" id="show-icon"></i></span>
                        </div>
                    </div>
                </div>

                <#if realm.resetPasswordAllowed>
                    <p><a class="forgot-password-link" href="${url.loginResetCredentialsUrl}">${msg("doForgotPassword")}</a></p>
                </#if>

                <input class="btn btn-primary btn-block login-btn" type="submit" value="${msg("doLogIn")}" tabindex="2">
            </form>
        </div>
    </#if>
</@layout.registrationLayout>

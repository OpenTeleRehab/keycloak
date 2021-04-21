<#import "template.ftl" as layout>
<@layout.registrationLayout displayInfo=social.displayInfo; section>
    <#if section = "title">
        ${msg("loginTitle")}
    <#elseif section = "header">
        <link href="${url.resourcesPath}/img/favicon.png" rel="icon"/>
    <#elseif section = "form">
        <div class="login-container mb-5">
            <div class="d-flex justify-content-center">
                <h3 class="login-title">${msg('login')}</h3>
            </div>
            <#if message?has_content>
                 <#if message.type = 'success'>
                    <div class="alert alert-${message.type}">${message.summary?no_esc}</div>
                 </#if>
                 <#if message.type = 'warning'>
                    <div class="alert alert-${message.type}">${message.summary?no_esc}</div>
                 </#if>
                 <#if message.type = 'error'>
                    <div class="alert alert-danger">${message.summary?no_esc}</div>
                 </#if>
                 <#if message.type = 'info'>
                    <div class="alert alert-${message.type}">${message.summary?no_esc}</div>
                 </#if>
            </#if>
        <#if realm.password>
            <div>
               <form id="kc-form-login" class="form" onsubmit="login.disabled = true; return true;" action="${url.loginAction}" method="post">
                   <div class="form-group">
                       <label for="username" class="username-label">${msg("username")}</label>
                       <input id="username" class="form-control" placeholder="${msg("enterUsername")}" type="text" name="username" tabindex="1">
                   </div>
                   <div class="form-group">
                       <label for="password" class="password-label">${msg("password")}</label>
                       <input id="password" class="form-control" placeholder="${msg("enterPassword")}" type="password" name="password" tabindex="2">
                   </div>
                   <#if realm.resetPasswordAllowed>
                       <p><a class="forgot-password-link" href="${url.loginResetCredentialsUrl}">${msg("doForgotPassword")}</a></p>
                   </#if>
                   <input class="btn btn-primary btn-block login-btn" type="submit" value="${msg("doLogIn")}" tabindex="3">
                </form>
            </div>
        </#if>
        </div>
    </#if>
</@layout.registrationLayout>

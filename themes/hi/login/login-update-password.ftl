<#import "template.ftl" as layout>
<@layout.registrationLayout; section>
    <#if section = "title">
        ${msg("updatePasswordTitle")}
    <#elseif section = "header">
        <link href="${url.resourcesPath}/img/favicon.png" rel="icon"/>
    <#elseif section = "form">
        <div class="login-container">
            <div class="d-flex justify-content-center">
                <h3>${msg("updatePassword")}</h3>
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
            <form id="kc-passwd-update-form" class="form" action="${url.loginAction}" method="post">
                <input type="text" id="username" name="username" value="${username}" autocomplete="username"
                   readonly="readonly" style="display:none;"/>
                <input type="password" id="password" name="password" autocomplete="current-password" style="display:none;"/>

                <div class="form-group">
                    <label for="password-new">${msg("passwordNew")}</label>
                    <input type="password" id="password-new" name="password-new" class="form-control"
                       autofocus autocomplete="new-password"
                    />
                </div>

                <div class="form-group">
                    <label for="password-confirm">${msg("passwordConfirm")}</label>
                    <input type="password" id="password-confirm" name="password-confirm"
                       class="form-control" autocomplete="new-password"
                    />
                </div>

                <#if isAppInitiatedAction??>
                    <input class="btn btn-primary btn-block" type="submit" value="${msg("doSubmit")}" />
                    <button class="btn btn-default btn-block" type="submit" name="cancel-aia" value="true" />${msg("doCancel")}</button>
                <#else>
                    <input class="btn btn-primary btn-block" type="submit" value="${msg("doSubmit")}" />
                </#if>
            </form>
        </div>
    </#if>
</@layout.registrationLayout>

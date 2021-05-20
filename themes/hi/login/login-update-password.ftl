<#import "template.ftl" as layout>
<@layout.registrationLayout; section>
    <#if section = "title">
        ${msg("updatePasswordTitle")}
    <#elseif section = "header">
        <link href="${url.resourcesPath}/img/favicon.png" rel="icon"/>
    <#elseif section = "form">
        <div class="login-container">
            <div class="d-flex justify-content-center">
                <h3 class="update-password-title">${msg("updatePassword")}</h3>
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
                    <label for="password-new" class="password-new">${msg("passwordNew")}</label>
                    <div class="input-group mb-3">
                        <input type="password" id="password-new" name="password-new" class="form-control"
                            autofocus autocomplete="new-password"
                        />
                        <div class="input-group-append" id="show-new-password">
                            <span class="input-group-text" type="button"><i class="fas fa-eye" id="show-password-new-icon"></i></span>
                        </div>
                    </div>
                </div>

                <div class="form-group">
                    <label for="password-confirm" class="password-confirm">${msg("passwordConfirm")}</label>
                     <div class="input-group mb-3">
                        <input type="password" id="password-confirm" name="password-confirm"
                            class="form-control" autocomplete="new-password"
                        />
                        <div class="input-group-append" id="show-confirm-password">
                            <span class="input-group-text" type="button"><i class="fas fa-eye" id="show-password-confirm-icon"></i></span>
                        </div>
                    </div>
                </div>

                <#if isAppInitiatedAction??>
                    <input class="btn btn-primary btn-block" type="submit" value="${msg("doSubmit")}" />
                    <button class="btn btn-default btn-block" type="submit" name="cancel-aia" value="true" />${msg("doCancel")}</button>
                <#else>
                    <input class="btn btn-primary btn-block btn-submit" type="submit" value="${msg("doSubmit")}" />
                </#if>
            </form>
        </div>
    </#if>
</@layout.registrationLayout>

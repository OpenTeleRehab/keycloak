<#import "template.ftl" as layout>
<@layout.registrationLayout; section>
    <#if section = "title">
        <h3 class="login-title">${msg("saml.post-form.title")}</h3>
    <#elseif section = "form">
        <div class="login-container position-relative" style="height: 325px">
            <div class="redirect-wrapper" 
                style="position: absolute; top: 50%; left: 50%; transform: translate(-50%, -50%); text-align: center;">
                <p class="redirect-message" style="margin: 0;">${msg("saml.post-form.message")}</p>

                <form name="saml-post-binding" method="post" action="${samlPost.url}" class="w-100 mt-3">
                    <#if samlPost.SAMLRequest??>
                        <input type="hidden" name="SAMLRequest" value="${samlPost.SAMLRequest}"/>
                    </#if>
                    <#if samlPost.SAMLResponse??>
                        <input type="hidden" name="SAMLResponse" value="${samlPost.SAMLResponse}"/>
                    </#if>
                    <#if samlPost.relayState??>
                        <input type="hidden" name="RelayState" value="${samlPost.relayState}"/>
                    </#if>
                </form>

                <script>
                    window.onload = function() {
                        document.forms[0].submit();
                    };
                </script>

                <noscript>
                    <p>${msg("saml.post-form.js-disabled")}</p>
                    <input type="submit" value="${msg("doContinue")}" class="btn btn-primary btn-block mt-3"/>
                </noscript>
            </div>
        </div>
    </#if>
</@layout.registrationLayout>

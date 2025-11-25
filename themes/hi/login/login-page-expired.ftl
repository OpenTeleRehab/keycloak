<#import "template.ftl" as layout>
<@layout.registrationLayout; section>
    <#if section = "header">
        ${msg("pageExpiredTitle")}
    <#elseif section = "form">
        <p id="instruction1" class="instruction">
            Redirecting you back to the login page...
        </p>

        <script type="text/javascript">
            // Automatically redirect to login page
            window.location.replace("${url.loginRestartFlowUrl}");
        </script>
        <!-- Optional fallback for browsers without JS -->
        <noscript>
            <p>
                ${msg("pageExpiredMsg1")} <a id="loginRestartLink" href="${url.loginRestartFlowUrl}">${msg("doClickHere")}</a>.
            </p>
        </noscript>
    </#if>
</@layout.registrationLayout>
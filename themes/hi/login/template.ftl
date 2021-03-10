<#macro registrationLayout bodyClass="" displayInfo=false displayMessage=true>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"  "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

    <head>
        <meta charset="utf-8">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="robots" content="noindex, nofollow">

        <title><#nested "title"></title>
        <link rel="icon" href="${url.resourcesPath}/img/favicon.ico" />
        <link href="https://fonts.googleapis.com/css2?family=Nunito:ital,wght@0,400;0,700;1,300&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css" integrity="sha384-TX8t27EcRE3e/ihU7zmQxVncDAy5uIKz4rEkgIXeMed4M0jlfIDPvg6uqKI2xXr2" crossorigin="anonymous">
        <#if properties.styles?has_content>
            <#list properties.styles?split(' ') as style>
                <link href="${url.resourcesPath}/${style}" rel="stylesheet" />
            </#list>
        </#if>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <script>
            $().ready(function () {
                $.ajax({
                    type: "GET",
                    url: '${properties.ADMIN_SERVICE_URL}/page/static?url-segment=about-us&platform=' + ('${realm.name}' === 'hi-therapist' ? 'therapist_portal' : 'admin_portal'),
                    crossDomain: true,
                    success: function (data) {
                        $('#about').html(data);
                    },
                    error: function (xhr, ajaxOptions, thrownError) {
                        console.log('xHR: ' + xhr);
                        console.log('ajaxOption: ' + ajaxOptions);
                        console.log('thrownError: ' + thrownError);
                    }
                   });
                 });
        </script>
    </head>

    <body>
        <#nested "header">
        <div class="main container-fluid">
            <div class="row">
                <div class="col-lg-6 px-5">
                    <div class="d-flex justify-content-center align-items-center flex-column">
                        <img class="logo" src="${url.resourcesPath}/img/logo.svg" alt="HI logo">
                        <h4 class="title">${(realm.name == 'hi-therapist')?then('Therapist Portal', 'Admin Portal') }</h4>
                    </div>
                    <div class="d-flex justify-content-center align-items-center">
                        <div class="block block-transparent block-rounded w-100 mb-0 overflow-hidden">
                            <div class="block-content bg-white">
                                <#nested "form">
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-6 px-0">
                    <div id="about" class="d-flex flex-column"></div>
                </div>
            </div>
        </div>
    </body>
</html>
</#macro>

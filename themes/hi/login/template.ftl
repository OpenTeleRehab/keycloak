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
            const redirect = function(url, params) {
                url = url || window.location.href || '';
                url = url.split('#')[0];
                url =  url.match(/\?/) ? url : url + '?';

                for ( var key in params ) {
                    var re = RegExp( '[;&]' + key + '=?[^&;]*', 'g' );
                    url = url.replace( re, '');
                    url += '&' + key + '=' + params[key];
                }
                url = url.replace(/[;&]$/, '');
                url = url.replace(/\?[;&]/, '?');
                url = url.replace(/[;&]{2}/g, ';');
                window.location.replace( url );
            };

            const translate = function(translations) {
                let portalName = 'Admin Portal';

                if ('${realm.name}' === 'hi-therapist') {
                    item = translations.find(item => item.key === 'common.therapist_portal');
                    portalName = item ? item.value : 'Therapist Portal';
                } else {
                    item = translations.find(item => item.key === 'common.admin_portal');
                    portalName = item ? item.value : 'Admin Portal';
                }
                $('.title').text(portalName);

                const loginTitle = translations.find(item => item.key === 'common.login');
                loginTitle && $('.login-title').text(loginTitle.value);
                loginTitle && $('.login-btn').attr('value', loginTitle.value);

                const usernameLabel = translations.find(item => item.key === 'common.email');
                usernameLabel && $('.username-label').text(usernameLabel.value);

                const usernamePlaceholder = translations.find(item => item.key === 'placeholder.email');
                usernamePlaceholder && $('#username').attr("placeholder", usernamePlaceholder.value);

                const passwordLabel = translations.find(item => item.key === 'common.password');
                passwordLabel && $('.password-label').text(passwordLabel.value);

                const passwordPlaceholder = translations.find(item => item.key === 'placeholder.password');
                passwordPlaceholder && $('#password').attr("placeholder", passwordPlaceholder.value);

                const forgotPasswordLink = translations.find(item => item.key === 'common.forgot_password');
                forgotPasswordLink && $('.forgot-password-link').text(forgotPasswordLink.value);

                const passwordRecoveryTitle = translations.find(item => item.key === 'common.password-recovery');
                passwordRecoveryTitle && $('.password-recovery-title').text(passwordRecoveryTitle.value);

                const recoveryPasswordInstructionLabel = translations.find(item => item.key === 'common.recovery-password-instruction');
                recoveryPasswordInstructionLabel && $('.recovery-password-instruction').text(recoveryPasswordInstructionLabel.value);

                const recoverPassword = translations.find(item => item.key === 'common.recover_password');
                recoverPassword && $('.btn-recover-password').attr('value', recoverPassword.value);

                const loginLink = translations.find(item => item.key === 'common.login');
                loginLink && $('.login-link').text('< ' + loginLink.value);

                const updatePasswordTitle = translations.find(item => item.key === 'common.update-password');
                updatePasswordTitle && $('.update-password-title').text(updatePasswordTitle.value);

                const passwordNewLabel = translations.find(item => item.key === 'common.new-password');
                passwordNewLabel && $('.password-new').text(passwordNewLabel.value);

                const passwordNewPlaceholder = translations.find(item => item.key === 'placeholder.new-password');
                passwordNewPlaceholder && $('#password-new').attr("placeholder", passwordNewPlaceholder.value);

                const passwordConfirmLabel = translations.find(item => item.key === 'common.confirm-password');
                passwordConfirmLabel && $('.password-confirm').text(passwordConfirmLabel.value);

                const passwordConfirmPlaceholder = translations.find(item => item.key === 'placeholder.confirm-password');
                passwordConfirmPlaceholder && $('#password-confirm').attr("placeholder", passwordConfirmPlaceholder.value);

                const submit = translations.find(item => item.key === 'common.submit');
                submit && $('.btn-submit').attr('value', submit.value);

                const infoTitle = translations.find(item => item.key === 'common.information');
                infoTitle && $('.info-title').text(infoTitle.value);

                const backToApplicationLink = translations.find(item => item.key === 'common.back-to-application');
                backToApplicationLink && $('.back-to-application').text('< ' + backToApplicationLink.value);

                const proceedWithActionLink = translations.find(item => item.key === 'common.proceed-with-action');
                proceedWithActionLink && $('.proceed-with-action').text('< ' + proceedWithActionLink.value);

                const errorTitle = translations.find(item => item.key === 'common.error');
                errorTitle && $('.error-title').text(errorTitle.value);
            };

            $().ready(function () {
                $(() => {
                    let languages = [];
                    let language = localStorage.getItem('hiPreferredLanguage');
                    if (!language) {
                        localStorage.setItem('hiPreferredLanguage', 1);
                        language = 1;
                    }

                    // Get about us page
                    $.ajax({
                        type: "GET",
                        url: ('${realm.name}' === 'hi-therapist' ? '${properties.THERAPIST_APP_URL}' : '${properties.ADMIN_APP_URL}') + '/api/admin/page/static?url-segment=about-us&platform=' + ('${realm.name}' === 'hi-therapist' ? 'therapist_portal' : 'admin_portal') + '&lang=' + (language),
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

                    // Get translation
                    $.ajax({
                        type: "GET",
                        url: ('${realm.name}' === 'hi-therapist' ? '${properties.THERAPIST_APP_URL}' : '${properties.ADMIN_APP_URL}') + '/api/admin/translation/i18n/admin_portal?lang=' + (language),
                        crossDomain: true,
                        success: function (data) {
                            translate(data.data);
                        },
                        error: function (xhr, ajaxOptions, thrownError) {
                            console.log('xHR: ' + xhr);
                            console.log('ajaxOption: ' + ajaxOptions);
                            console.log('thrownError: ' + thrownError);
                        }
                    });

                    // Get languages
                    $.ajax({
                        type: "GET",
                        url: ('${realm.name}' === 'hi-therapist' ? '${properties.THERAPIST_APP_URL}' : '${properties.ADMIN_APP_URL}') + '/api/admin/language',
                        crossDomain: true,
                        success: function (data) {
                            if (data.data.length) {
                                languages = data.data;
                                $.each(data.data, function(key, item) {
                                    $('#languageSelector').append($("<option></option>").attr("value", item.id).text(item.name));
                                });
                                $('#languageSelector').val(language);
                            }
                        },
                        error: function (xhr, ajaxOptions, thrownError) {
                            console.log('xHR: ' + xhr);
                            console.log('ajaxOption: ' + ajaxOptions);
                            console.log('thrownError: ' + thrownError);
                        }
                    });

                    $('#languageSelector').on('change', function() {
                        localStorage.setItem('hiPreferredLanguage', $(this).val());
                        const languageObj = languages.find(item => item.id == $(this).val());
                        redirect(location.href, { kc_locale: languageObj ? languageObj.code : 'en' });
                    });
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
                        <img class="logo" src="${url.resourcesPath}/img/logo.svg" alt="OpenRehab logo">
                        <h4 class="title">${(realm.name == 'hi-therapist')?then('Therapist Portal', 'Admin Portal') }</h4>
                    </div>
                    <div class="d-flex justify-content-center align-items-center">
                        <div class="block block-transparent block-rounded w-100 mb-0 overflow-hidden">
                            <div class="block-content bg-white">
                                <div class="login-container pb-0">
                                <select id="languageSelector" class="form-control form-control-sm w-auto float-right"></select>
                                </div>
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

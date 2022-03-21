<#macro registrationLayout bodyClass="" displayInfo=false displayMessage=true>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"  "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="en">

    <head>
        <meta charset="utf-8">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="robots" content="noindex, nofollow">

        <title><#nested "title"></title>
        <link rel="icon" href="${url.resourcesPath}/img/favicon.ico" />
        <link href="https://fonts.googleapis.com/css2?family=Nunito:ital,wght@0,400;0,700;1,300&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css" integrity="sha384-TX8t27EcRE3e/ihU7zmQxVncDAy5uIKz4rEkgIXeMed4M0jlfIDPvg6uqKI2xXr2" crossorigin="anonymous">
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.0/css/all.css" integrity="sha384-lZN37f5QGtY3VHgisS14W3ExzMWZxybE1SJSEsQp9S+oqd12jhcu+A56Ebc1zFSJ" crossorigin="anonymous">
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
                let realmName = '${realm.name}';
                let portalName = 'Admin Portal';

                if (realmName.includes('therapist')) {
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

                const termOfServiceLabel = translations.find(item => item.key === 'term.of.service');
                termOfServiceLabel && $('.term-condition-title').text(termOfServiceLabel.value);

                const agreeTermOfServiceLabel = translations.find(item => item.key === 'term.of.service.agree');
                agreeTermOfServiceLabel && $('.agree-term-of-service').text(agreeTermOfServiceLabel.value);

                const agreePrivacyPolicyLabel = translations.find(item => item.key === 'privacy.policy.agree');
                agreePrivacyPolicyLabel && $('.agree-privacy-policy').text(agreePrivacyPolicyLabel.value);

                const privacyPolicyLink = translations.find(item => item.key === 'privacy.policy.detail.link');
                privacyPolicyLink && $('.privacy-policy-link').text(privacyPolicyLink.value);

                const termConditionLink = translations.find(item => item.key === 'term.of.service.detail.link');
                termConditionLink && $('.term-condition-link').text(termConditionLink.value);

                const accept = translations.find(item => item.key === 'term.of.service.accept');
                submit && $('.btn-accept').attr('value', accept.value);

                const loginErrorMessage = $('.login-error-message').text();
                let errorLogin = translations.find(item => item.key === 'login.error');
                if (loginErrorMessage.includes('Incorrect')) {
                    errorLogin = translations.find(item => item.key === 'login.error_message.invalid_user');
                } else if (loginErrorMessage.includes('timed out')) {
                    errorLogin = translations.find(item => item.key === 'login.error_message.time_out');
                }
                errorLogin && $('.login-error-message').text(errorLogin.value);
            };

            $().ready(function () {
                $(() => {
                    let url = new URL(window.location.href);
                    let origin = url.origin.replace('therapist', 'admin');
                    let realmName = '${realm.name}';
                    let languages = [];
                    let language = localStorage.getItem('hiPreferredLanguage');
                    if (!language) {
                        localStorage.setItem('hiPreferredLanguage', 1);
                        language = 1;
                    }

                    // Get about us page
                    $.ajax({
                        type: "GET",
                        url: origin + '/api/admin/page/static?url-segment=about-us&platform=' + (realmName.includes('therapist') ? 'therapist_portal' : 'admin_portal') + '&lang=' + (language),
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
                        url: (realmName.includes('therapist') ? '${properties.THERAPIST_APP_URL}' : '${properties.ADMIN_APP_URL}') + '/api/admin/translation/i18n/admin_portal?lang=' + (language),
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
                        url: (realmName.includes('therapist') ? '${properties.THERAPIST_APP_URL}' : '${properties.ADMIN_APP_URL}') + '/api/admin/language',
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

                    // Get color scheme
                    $.ajax({
                        type: "GET",
                        url: origin + '/api/admin/color-scheme',
                        crossDomain: true,
                        success: function (data) {
                            if (data.data) {
                                colorScheme = data.data;
                                $('.main').css('background-color', colorScheme.primary_color);
                                $('.btn-primary').css({
                                    'background-color' : colorScheme.primary_color,
                                    'border-color': colorScheme.primary_color
                                });
                                $('a').css('color', colorScheme.primary_color);
                                $("a").mouseover(function() {
                                  $(this).css('color', colorScheme.secondary_color);
                                }).mouseout(function() {
                                  $(this).css('color', colorScheme.primary_color);
                                });
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

                    // Append Term&Condition and Privacy link
                    $('#termConditionLink').attr('href', `${properties.THERAPIST_APP_URL}/api/admin/page/term-condition?lang=` + language);
                    $('#privacyLink').attr('href', `${properties.THERAPIST_APP_URL}/api/admin/page/privacy?lang=` + language);

                    // Enable/disable accept term and condition, privacy
                    $('.custom-control-input').change(function() {
                        const acceptTerm = $('#acceptTermAndCondition').prop('checked');
                        const acceptPrivacy = $('#acceptPrivacy').prop('checked');
                        $('#kc-accept').prop('disabled', !(acceptTerm && acceptPrivacy));
                    });
                });

                $('#show-password, #show-new-password, #show-confirm-password').on('click', function(e) {
                    const input = $(e.currentTarget).siblings('input');
                    const type = input.attr('type');
                    const iconElement = $(e.currentTarget).find('i');
                    if (type == 'password') {
                        input.attr('type', 'text');
                        iconElement.removeClass('fa-eye').addClass('fa-eye-slash');
                    } else {
                        input.attr('type', 'password');
                        iconElement.removeClass('fa-eye-slash').addClass('fa-eye');
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
                        <img class="logo" src="${url.resourcesPath}/img/logo.svg" alt="OpenTeleRehab logo">
                        <h4 class="title">${(realm.name == 'hi-therapist')?then('Therapist Portal', 'Admin Portal') }</h4>
                    </div>
                    <div class="d-flex justify-content-center align-items-center">
                        <div class="block block-transparent block-rounded w-100 mb-0 overflow-hidden">
                            <div class="block-content bg-white">
                                <div class="login-container pb-0">
                                    <span class="float-right d-flex">
                                        <i class="fas fa-globe fa-lg mr-3 mt-2"></i>
                                        <select id="languageSelector" class="form-control form-control-sm w-auto"></select>
                                    </span>
                                </div>
                                <#nested "form">
                            </div>
                        </div>
                    </div>
                    <div class="d-flex justify-content-center align-items-center mb-4 mt-1">
                        <span class="footer-title">Powered by:</span>
                        <img class="footer-logo" src="${url.resourcesPath}/img/hi-logo.png" alt="OpenTeleRehab logo">
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

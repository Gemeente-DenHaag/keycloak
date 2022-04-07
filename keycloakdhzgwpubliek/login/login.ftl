<#import "template.ftl" as layout>
<@layout.registrationLayout displayMessage=!messagesPerField.existsError('username','password') displayInfo=realm.password && realm.registrationAllowed && !registrationDisabled??; section>
    <#if section = "header">
        ${msg("loginAccountTitle")}
    <#elseif section = "form">
	
    <div id="kc-form">
        <#if realm.password && social.providers??>
            <div id="kc-social-providers" class="${properties.kcFormSocialAccountSectionClass!}">

                <ul class="${properties.kcFormSocialAccountListClass!} <#if social.providers?size gt 1>${properties.kcFormSocialAccountListGridClass!}</#if>">
                    <#list social.providers as p>
                        <a id="social-${p.alias}" class="${properties.kcFormSocialAccountListButtonClass!} <#if social.providers?size gt 3>${properties.kcFormSocialAccountGridItem!}</#if>"
                                type="button" href="${p.loginUrl}">
                            <#--<#if p.guiOrder?has_content>-->
                            <#--<#if p.alias?starts_with("oidc")>-->
                            <#if p.guiOrder?has_content>
								<i class="${properties.kcCommonLogoIdP!} ${p.iconClasses!}">
									<span class="${properties.kcFormSocialAccountNameClass!} kc-social-icon-text">Inloggen met ${p.displayName!}</span>
								</i>
								<button class="kc-social-button">Inloggen</button>
                            <#else>
                                <span class="${properties.kcFormSocialAccountNameClass!}">${p.displayName!}</span>
                            </#if>
                        </a>
                    </#list>
                </ul>
            </div>
        </#if>

    </div>
    
    </#if>

</@layout.registrationLayout>

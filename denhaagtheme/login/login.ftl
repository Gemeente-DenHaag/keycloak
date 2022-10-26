<#import "template.ftl" as layout>
<#import "card-group.ftl" as render>
<#import "alert-message.ftl" as alertMessage>
<@layout.registrationLayout displayMessage=!messagesPerField.existsError('username','password') displayInfo=realm.password && realm.registrationAllowed && !registrationDisabled??; section>
    <#if section = "header">
        ${msg("loginAccountTitle")}
    <#elseif section = "form">
        <#if realm.password && social.providers??>
            <#-- Create an object with all providers and image locations -->
            <#assign digidImg = "${url.resourcesPath}/img/digid.svg">
            <#assign eHerkenningImg = "${url.resourcesPath}/img/eherkenning.png">
            <#assign eidasImg = "${url.resourcesPath}/img/eidas.svg">

            <#assign digid = "digid">
            <#assign eHerkenning = "eherkenning">
            <#assign eidas = "eidas">
            <#assign digidObj = {"imageUrl": digidImg, "footerUrl": "https://www.digid.nl/"}>
            <#assign eHerkenningObj = {"imageUrl": eHerkenningImg, "footerUrl": "https://eherkenning.nl/"}>
            <#assign eidasObj = {"imageUrl": eidasImg, "footerUrl": ""}>
            <#assign staticProviderData = {digid: digidObj, eHerkenning: eHerkenningObj, eidas: eidasObj}>
            <#assign authorisedInfoNotification = {"type": "info", "summary": msg("authorisedNotification")}>

            <#-- Based on the current situation, where normal providers have a 'oidc-' prefix -->
            <#assign normalProviders = false>
            <#assign authorisedProviders = false>
            <#list social.providers as p>
                <#if p.alias?starts_with("oidc-")>
                    <#assign normalProviders = true>
                <#else>
                    <#assign authorisedProviders = true>
                </#if>
            </#list>

            <#-- First render the authentication cards for the normal providers  -->
            <#if normalProviders>
                <h2 class="utrecht-heading-2">${msg("loginTitle")}</h2>
                <p class="utrecht-paragraph">${msg("loginSubTitle")} <a href="#gemachtigde-heading" class="denhaag-link"><span class="denhaag-link__label">${msg("loginSubTitleLinkText")}</span></a>${msg("loginSubTitlePostLink")}</p>
                <@render.cardGroup providers=social.providers providersData=staticProviderData/>
            </#if>
            <#-- Render the authentication cards for the authorised providers  -->
            <#if authorisedProviders>
                <h2 class="utrecht-heading-2" id="gemachtigde-heading">${msg("authorisedLoginTitle")}</h2>
                <@alertMessage.showAlert message=authorisedInfoNotification />
                <@render.cardGroup providers=social.providers providersData=staticProviderData/>
            </#if>
        </#if>
    </#if>

</@layout.registrationLayout>

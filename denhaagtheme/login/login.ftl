<#import "template.ftl" as layout>
<#import "card-group.ftl" as render>
<@layout.registrationLayout displayMessage=!messagesPerField.existsError('username','password') displayInfo=realm.password && realm.registrationAllowed && !registrationDisabled??; section>
    <#if section = "header">
        ${msg("loginAccountTitle")}
    <#elseif section = "form">
        <#if realm.password && social.providers??>
            <#-- Create an object with all providers and image locations -->
            <#assign digidImg = "/resources/21pxt/login/denhaagtheme/img/digid.svg">
            <#assign eHerkenningImg = "/resources/21pxt/login/denhaagtheme/img/eherkenning.png">
            <#assign eidasImg = "/resources/21pxt/login/denhaagtheme/img/eidas.svg">

            <#assign digid = "digid">
            <#assign eHerkenning = "eherkenning">
            <#assign eidas = "eidas">

            <#assign staticProviderData = {digid: digidImg, eHerkenning: eHerkenningImg, eidas: eidasImg}>

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
                <h2 class="utrecht-heading-2">Inloggen</h2>
                <@render.cardGroup providers=social.providers providersData=staticProviderData/>
            </#if>
            <#-- Render the authentication cards for the authorised providers  -->
            <#if authorisedProviders>
                <h2 class="utrecht-heading-2">Inloggen als gemachtigde</h2>
                <@render.cardGroup providers=social.providers providersData=staticProviderData/>
            </#if>
        </#if>
    </#if>

</@layout.registrationLayout>

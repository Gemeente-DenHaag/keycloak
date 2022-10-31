<#import "login-card.ftl" as render>

<#macro cardGroup providers providersData>
    <#-- Keeping track of the index (and if the card-group div is closed) is important, because there can only be 3 cards per card group  -->
    <#assign index = 0>
    <#assign closedGroup = true>
    <#list providers as p>
        <#if index % 3 == 0>
            <div class="denhaag-card-group denhaag-card-group--responsive denhaag-card-group--distanced">
            <#assign closedGroup = false>
        </#if>

        <@render.loginCard provider=p providerData=providersData />

        <#if index % 3 == 2>
            </div>
            <#assign closedGroup = true>
        </#if>
        <#assign index++>
    </#list>
    <#if !closedGroup>
        </div>
    </#if>
</#macro>

@allowed([
  'dev'
  'uat'
  'prod'
])
param enviroment string 
param webAppName string
param sku string = 'F1' // The SKU of App Service Plan
param linuxFxVersion string = 'node|14-lts' // The runtime stack of web app
param location string = 'AustraliaEast'

var appServicePlanName = toLower('AppServicePlan-${webAppName}-${enviroment}')
var webSiteName = toLower('wapp-${webAppName}-${enviroment}')

resource myAppServicePlan 'Microsoft.Web/serverfarms@2020-06-01' = {
  name: appServicePlanName
  location: location
  properties: {
    reserved: true
  }
  sku: {
    name: sku
  }
  kind: 'linux'
}

resource myAppService 'Microsoft.Web/sites@2020-06-01' = {
  name: webSiteName
  location: location
  properties: {
    serverFarmId: myAppServicePlan.id
    siteConfig: {
      linuxFxVersion: linuxFxVersion
    }
    httpsOnly: true    
  }
}

output appServiceName string = webSiteName
output appServicePlanName string = appServicePlanName


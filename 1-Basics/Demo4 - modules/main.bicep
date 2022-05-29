param location string = 'AustraliaEast'
param webAppName string

@allowed([
    'dev'
    'uat'
    'prod'
  ])
param enviroment string 

// Module 1 - App Service
module appService 'appservice.bicep' = {
  name: 'appServiceDeployment'
  params: {
    enviroment: enviroment
    webAppName: webAppName
    location: location
  }
}

// Module 2 - App Service
module storage 'storage.bicep' = {
  name: 'storageDeployment'
  params: {
    enviroment: enviroment
    location: location
  }
}

output appServiceName string = appService.outputs.appServiceName
output appServicePlanName string = appService.outputs.appServicePlanName


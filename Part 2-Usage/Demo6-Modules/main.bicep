param location string = 'AustraliaEast'
param webAppName string

@secure()
@description('Admin password for VM')
param adminPassword string

@description('Admin username for VM')
param adminUsername string


@allowed([
    'dev'
    'uat'
    'prod'
  ])
param environment string 

// Module 1 - App Service
module appService 'appservice.bicep' = {
  name: 'appServiceDeployment'
  params: {
    enviroment: environment
    webAppName: webAppName
    location: location
  }
}

// Module 2 - App Service
module storage 'storage.bicep' = {
  name: 'storageDeployment'
  params: {
    enviroment: environment
    location: location
  }
}

var isProd = environment == 'prod'

// Only deploy the VM in production environments
module vm 'vm.bicep' = if (isProd) {
  name: 'vmDeployment'
  params: {
    location: location
    adminPassword: adminPassword
    adminUsername: adminUsername
    vmName: 'ndc-awesome-vm'
  }
}

output appServiceName string = appService.outputs.appServiceName
output appServicePlanName string = appService.outputs.appServicePlanName


@allowed([
  'dev'
  'uat'
  'prd'
])
param environment string
param location string = resourceGroup().location

@description('The name of the function app that you wish to create.')
param webAppName string

@description('Name of app service functions hosting plan.')
param hostingPlanName string
@allowed([
  'Free'
  'Shared'
  'Basic'
  'Standard'
])
@description('The pricing tier for the hosting plan.')
param hostingPlanSkuTier string = 'Standard'
param hostingPlanSkuName string = 'S1'

@allowed([
  'Standard_LRS'
  'Standard_GRS'
  'Standard_RAGRS'
])
@description('Storage Account type')
param storageAccountType string = 'Standard_LRS'

param azureIpAddressTowhitelist array = [
  '13.70.64.0/18'
  '13.72.224.0/19'
  '13.73.192.0/20'
]

var uniquePart = uniqueString(resourceGroup().id)
var storageAccountName = 'sa${environment}${uniquePart}'

resource storageAccount 'Microsoft.Storage/storageAccounts@2019-06-01' = {
  name: storageAccountName
  location: location
  kind: 'StorageV2'
  sku: {
    name: storageAccountType
  }
  properties: {
    allowBlobPublicAccess: false
    supportsHttpsTrafficOnly: true
    minimumTlsVersion: 'TLS1_2'
  }
}

resource hostingPlan 'Microsoft.Web/serverfarms@2021-01-01' = {
  name: hostingPlanName
  location: location
  sku: {
    name: hostingPlanSkuName
    tier: hostingPlanSkuTier
  }
}

resource functionApp 'Microsoft.Web/sites@2021-01-01' = {
  name: webAppName
  location: location
  identity: {
    type: 'SystemAssigned'
  }
  kind: 'functionapp'
  properties: {
    serverFarmId: hostingPlan.id
    clientAffinityEnabled: false
    siteConfig: {
      alwaysOn: true
    }
  }
}

resource functionApp_appsettings 'Microsoft.Web/sites/config@2021-01-15' = {
  name: '${functionApp.name}/appsettings'
  properties: {
    AzureWebJobsStorage: 'DefaultEndpointsProtocol=https;AccountName=${storageAccountName};AccountKey=${listkeys(storageAccount.id, '2015-05-01-preview').key1};'
    AzureWebJobsDashboard: 'DefaultEndpointsProtocol=https;AccountName=${storageAccountName};AccountKey=${listkeys(storageAccount.id, '2015-05-01-preview').key1};'
    FUNCTIONS_EXTENSION_VERSION: '~3'
    Environment: environment
  }
}

resource functionApp_ipRestrictions 'Microsoft.Web/sites/config@2021-01-15' = {
  name: '${functionApp.name}/web'
  properties: {
    ipSecurityRestrictions: [for (item, j) in azureIpAddressTowhitelist: {
      ipAddress: item
      name: 'AzureRegionRange${j}'
      action: 'Allow'
      priority: 300
      tag: 'Default'
    }]
  }
}

output functionApiKey string = listkeys('${functionApp.id}/host/default', functionApp.apiVersion).functionkeys.default
output functionHostname string = functionApp.properties.defaultHostName

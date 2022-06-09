param location string = 'AustraliaEast'
param appNamePrefix string = uniqueString(resourceGroup().id)

var functionAppName = '${appNamePrefix}-functionapp'
var appServiceName = '${appNamePrefix}-appservice'

// remove dashes for storage account name
var storageAccountName = format('{0}sta', replace(appNamePrefix, '-', ''))

// Storage Account
resource storageAccount 'Microsoft.Storage/storageAccounts@2019-06-01' = {
  name: storageAccountName
  location: location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  properties: {
    supportsHttpsTrafficOnly: true
    accessTier: 'Hot'
  }
}

// App Service
resource appService 'Microsoft.Web/serverFarms@2020-06-01' = {
  name: appServiceName
  location: location
  kind: 'functionapp'
  sku: {
    name: 'Y1'
    tier: 'Dynamic'
    size: 'Y1'
    family: 'Y'
    capacity: 0
  }
}

// Function App
resource functionApp 'Microsoft.Web/sites@2021-03-01' = {
  name: functionAppName
  
  location: location
  kind: 'functionapp'
  properties: {
    enabled: true
    siteConfig: {
      appSettings: [
        {
          name: 'BlobStorage'
          value: 'DefaultEndpointsProtocol=https;AccountName=${storageAccount.name};EndpointSuffix=${environment().suffixes.storage};AccountKey=${storageAccount.listKeys().keys[0].value}'
        }
      ]
    }
    httpsOnly: true
    serverFarmId: appService.id
    
  }
}

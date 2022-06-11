targetScope = 'resourceGroup'

param location string = resourceGroup().location

@allowed([
    'dev'
    'uat'
    'prod'
  ])
param enviroment string 

var uniquePart = uniqueString(resourceGroup().id)
var stgAcctName = 'mystg${enviroment}${uniquePart}'

resource mySymbolicName 'Microsoft.Storage/storageAccounts@2021-09-01' = {
  name: stgAcctName
  location: location
  kind: 'BlobStorage'
  sku: {
    name: 'Standard_LRS'
  }
}

output StorageAccountName string = stgAcctName

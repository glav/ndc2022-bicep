param location string = resourceGroup().location

@allowed([
    'dev'
    'uat'
    'prod'
  ])
param enviroment string 

var uniquePart = uniqueString(resourceGroup().id)  // Note the 'seed' value. Same value when using same seed.
var stgAcctName = 'mystg${enviroment}${uniquePart}'  // string interpolation

resource mySymbolicName 'Microsoft.Storage/storageAccounts@2021-09-01' = {
  name: stgAcctName
  location: location
  kind: 'BlobStorage'
  sku: {
    name: 'Standard_LRS' // Standard for now
  }
}

output StorageAccountName string = stgAcctName

param location string = resourceGroup().location

@allowed([
    'dev'
    'uat'
    'prod'
  ])

@minLength(3)
@maxLength(4)
param enviroment string 
param someNumber int = 123 // Default value of 123
param someArray array = [  // Array param with default value
  'one'
  'two'
]

var uniquePart = uniqueString(resourceGroup().id)  // Note the 'seed' value. Same value when using same seed.
var stgAcctName = 'mystg${enviroment}${uniquePart}'  // string interpolation

resource mySymbolicName 'Microsoft.Storage/storageAccounts@2021-09-01' = {
  name: stgAcctName
  location: location
  kind: 'BlobStorage'
  sku: {
    name: 'Standard_LRS' // Standard for now
  }
  properties: {
    accessTier: 'Hot'
  }
}

output StorageAccountName string = stgAcctName


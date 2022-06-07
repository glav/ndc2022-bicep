param location string = resourceGroup().location

@allowed([
    'dev'
    'uat'
    'prod'
  ])
@minLength(3)
@maxLength(4)
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
  properties: {
    accessTier: 'Hot'
  }
}

// Reference in same resource group
resource alreadyCreatedStorage 'Microsoft.Storage/storageAccounts@2021-09-01' existing = {
  name: 'nameofstorageacct'
}

// Reference in different resource group
resource alreadyCreatedStorageOtherGroup 'Microsoft.Storage/storageAccounts@2021-09-01' existing = {
  name: 'nameofstorageacct'
  scope: resourceGroup('anotherResourceGroup')
}

// Reference in different subscription and resource group
resource alreadyCreatedStorageOtherSub 'Microsoft.Storage/storageAccounts@2021-09-01' existing = {
  name: 'nameofstorageacct'
  scope: resourceGroup('subscriptionId','anotherResourceGroup')
}

output StorageAccountName string = stgAcctName


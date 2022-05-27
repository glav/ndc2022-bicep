

resource mySymbolicName 'Microsoft.Storage/storageAccounts@2021-09-01' = {
  name: 'mystorageacct'
  location: 'AustraliaEast'
  kind: 'BlobStorage'
  sku: {
    name: 'Standard_LRS'
  }
}


/*
resource storageAccount 'Microsoft.Storage/storageAccounts@2021-09-01' = {
  name: 
  location: 
  sku: {
    name: 
  }
  kind: 
}
*/

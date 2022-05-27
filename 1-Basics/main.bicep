
/*
   My first Bicep resource
*/
resource mySymbolicName 'Microsoft.Storage/storageAccounts@2021-09-01' = {
  name: 'mystorageacct'
  location: 'AustraliaEast'  
  kind: 'BlobStorage'
  sku: {
    name: 'Standard_LRS'  // Standard for now
  }
}


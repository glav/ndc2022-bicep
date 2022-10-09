/*
   My first Bicep resource
*/
resource mySymbolicName 'Microsoft.Storage/storageAccounts@2021-09-01' = {
  name: 'mystorageacctsyd'
  location: 'AustraliaEast'
  kind: 'BlobStorage'
  sku: {
    name: 'Standard_LRS' // Standard for now
  }
  properties: {
    accessTier: 'Hot'
  }

}

@allowed([
  'dev'
  'uat'
  'prod'
])
param environment string 
param adminUsername string
@secure()
param adminPassword string

var sqlDbName = 'SomeSqlDb'
var sqlServerName = 'SomeSqlServer'

resource sqlServer 'Microsoft.Sql/servers@2019-06-01-preview' = {
  name: sqlServerName
  location: resourceGroup().location
  properties: {
    minimalTlsVersion: '1.2'
    administratorLogin: adminUsername
    administratorLoginPassword: adminPassword
  }
}

var dbSkus = json(loadTextContent('dbSku.json'))
var dbSkuProperties = json(loadTextContent('dbSkuProperties.json'))

resource sqlDatabase 'Microsoft.Sql/servers/databases@2020-08-01-preview' = {
  name: '${sqlServer.name}/${sqlDbName}'
  location: resourceGroup().location
  sku: dbSkus[environment]
  properties: dbSkuProperties[environment]
}


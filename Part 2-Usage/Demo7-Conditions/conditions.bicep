@allowed([
  'dev'
  'uat'
  'prod'
])
param environment string 
param adminUsername string
@secure()
param adminPassword string

var sqlCollation = 'Latin1_General_CI_AS'
var sqlDbName = 'SomeSqlDb'
var sqlServerName = 'SomeSqlServer'


// Choose a particular SKU/Capacity depending on environment
var databaseSku = {
  dev: {
    name: 'GP_Gen5'
    tier: 'GeneralPurpose'
    family: 'Gen5'
    capacity: 4   // Low core count for Dev
  }
  uat: {
    name: 'GP_Gen5'
    tier: 'GeneralPurpose'
    family: 'Gen5'
    capacity: 12   // More cores for UAT due to data volume
  }
  prod: {
    name: 'GP_Gen5'
    tier: 'GeneralPurpose'
    family: 'Gen5'
    capacity: 24    // Much more corres for prod workloads
  }
}

var databaseSkuProperties = {
  dev: {
    collation: sqlCollation
    maxSizeBytes: 268435456000  // 250 Gb
    zoneRedundant: false
  }
  uat: {
    collation: sqlCollation
    maxSizeBytes: 536870912000  // 500 Gb
    zoneRedundant: false
  }
  prod: {
    collation: sqlCollation
    maxSizeBytes: 1073741824000  // 1Tb
    zoneRedundant: true
  }
}

resource sqlServer 'Microsoft.Sql/servers@2019-06-01-preview' = {
  name: sqlServerName
  location: resourceGroup().location
  properties: {
    minimalTlsVersion: '1.2'
    administratorLogin: adminUsername
    administratorLoginPassword: adminPassword
  }
}

resource sqlDatabase 'Microsoft.Sql/servers/databases@2020-08-01-preview' = {
  name: '${sqlServer.name}/${sqlDbName}'
  location: resourceGroup().location
  sku: databaseSku[environment]    // Note alternate syntax to access property of an object instead of '.' eg: databaseSku.dev
  properties: databaseSkuProperties[environment]
}

/*
**  Another way - go serverless for non prod

var databaseSku = isProd ? {
  name: 'GP_Gen5'   // vCore
  tier: 'GeneralPurpose'
  family: 'Gen5'
  capacity: 24
} : {
  name: 'GP_S_Gen5_2'   //  Serverless
  tier: 'GeneralPurpose'
  family: 'Gen5'
  capacity: 8
}
*/

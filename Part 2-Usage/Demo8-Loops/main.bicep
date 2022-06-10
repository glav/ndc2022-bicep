
// Simple range var
var strArray = [for i in range(0, 3): 'stuff${(i + 1)}']  // ["stuff1", "stuff2", "stuff3"]

/*
** Range to create multiple resources
   --> Creates myPublicIp1, myPublicIp2, myPublicIp3
*/
resource publicIp 'Microsoft.Network/publicIPAddresses@2020-06-01' = [for index in range(1,3): {
  name: 'myPublicIp${index}'
  location: 'AustraliaEast'
  properties: {
    publicIPAllocationMethod: 'Dynamic'
    dnsSettings: {
      domainNameLabel: 'dnslabel'
    }
  }
}]

// Make a list of sites to create
var webappList = [
  {
    appName: 'webapp-admin'
    appTag: 'admin module'
  }
  {
    appName: 'webapp-public'
    appTag: 'public facing'
  }
]

// Creates the number of sites based on length of webappList array and its item properties
resource appService 'Microsoft.Web/sites@2020-06-01' = [for (item, index) in webappList: {
  name: item.appName
  location: 'AustraliaEast'
  kind: 'linux'
  properties: {
    serverFarmId: appServicePlan.id
  }
  tags: {
    appComponent: item.appTag
    componentNumber: 'C-${index+1} of ${length(webappList)}'
  }  
}]

resource appServicePlan 'Microsoft.Web/serverfarms@2020-06-01' = {
  name: 'myplan'
  location: 'AustraliaEast'
  sku: {
    name: 'S1'
  }
  kind: 'linux'
  properties: {
    reserved: true
  }
}


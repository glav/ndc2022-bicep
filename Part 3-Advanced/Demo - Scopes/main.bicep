targetScope = 'subscription'

resource someResourceGroup 'Microsoft.Resources/resourceGroups@2021-01-01' = {
  name: 'Group1'
  location: deployment().location
}

resource anotherResourceGroup 'Microsoft.Resources/resourceGroups@2021-01-01' = {
  name: 'Group2'
  location: deployment().location
}
module storage 'storage.bicep' = {
  scope: someResourceGroup   // or you could do --> resourceGroup('Group1')
  name: 'uatDeploy'
  params: {
    enviroment: 'uat'
    location: 'AustraliaEast'
  }
}

module website 'appservice.bicep' = {
  scope: anotherResourceGroup // or you could --? resourceGroup('Group2')
  name: 'websiteDeploy'
  params: {
    enviroment: 'uat'
    webAppName: 'mywebapp'
    location: 'AustraliaEast'
  }
}


#Deploy
$rg = "NdcDemo"
az group create -n $rg -l "AustraliaEast"

#Do what-if deployment
az deployment group create --resource-group $rg -w --template-file ./main.bicep

#Show deploying via az and how asks for allowed values



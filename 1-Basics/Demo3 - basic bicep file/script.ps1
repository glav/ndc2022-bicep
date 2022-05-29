#Compile
az bicep build –f main.bicep

#Decompile
Az bicep decompile -f main2.json

#Deploy
$rg = "NdcDemo3"
az group create -n $rg -l "AustraliaEast"
az deployment group create --resource-group $rg --template-file main.bicep

#Show deploying via az and how asks for allowed values



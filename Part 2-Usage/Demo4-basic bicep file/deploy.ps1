#Compile
az bicep build -f main.bicep

#Rename it so we do not overwrite original when decompiling
Rename-item ./main.json main2.json

#Decompile
Az bicep decompile -f main2.json

#Deploy
$rg = "NdcDemo4"
az group create -n $rg -l "AustraliaEast"

#Do what-if deployment
az deployment group create --resource-group $rg -w --template-file main.bicep

#Show deploying via az and how asks for allowed values



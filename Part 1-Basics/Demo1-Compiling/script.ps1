#Compile
az bicep build -f main.bicep

Remove-Item ./main2.json -ErrorAction Ignore
Remove-Item ./main2.bicep -ErrorAction Ignore

Rename-Item ./main.json main2.json

#Decompile
Az bicep decompile -f main2.json

#Deploy
$rg = "NdcDemo2"
az group create -n $rg -l "AustraliaEast"
az deployment group create --resource-group $rg -w --template-file main.bicep

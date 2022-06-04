
#Deploy
$rg = "NdcDemo4"
az group create -n $rg -l "AustraliaEast"
az deployment group create --resource-group $rg --template-file main.bicep

#Decompile to show complexity of ARM

#Show use of dependsOn in ARM but not required in Bicep – implicit

#Show outputs that reference the module outputs

#Show use of main file that references other files




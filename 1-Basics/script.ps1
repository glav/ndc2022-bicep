#Compile
az bicep build –f main.bicep

#Decompile
Az bicep decompile -f main2.json

#Deploy
az deployment group create --resource-group SomeGroup --template-file main.bicep

# parameters 
$WebServergName1 = "NetEssentWebServer2-East"
$WebServergName2 = "NetEssentWebServer2-West"
$templateFile1 = '.\CreateWebServerVM1_Template.json'
$templateFile2 = '.\CreateWebServerVM2_Template.json'
$templateparameterFile1 = '.\CreateWebServerVM1_Parameters.json'
$templateparameterFile2 = '.\CreateWebServerVM2_Parameters.json'

# import the AzureRM modules
Import-Module AzureRM.Resources

#  login
Login-AzureRmAccount

# create the resource from the template - pass names as parameters
New-AzureRmResourceGroup -Location "East US" -Name $WebServergName1
New-AzureRmResourceGroup -Location "West US" -Name $WebServergName2

New-AzureRmResourceGroupDeployment -Verbose -Force -ResourceGroupName $WebServergName1 -TemplateFile $templateFile1 -TemplateParameterFile $templateparameterFile1 
New-AzureRmResourceGroupDeployment -Verbose -Force -ResourceGroupName $WebServergName2 -TemplateFile $templateFile2 -TemplateParameterFile $templateparameterFile2
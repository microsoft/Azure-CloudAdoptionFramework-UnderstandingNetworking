# parameters 
$ServergName1 = "NetEssentRouting"
$templateFile1 = '.\RoutingNetworkTraffic_Template.json'
$templateparameterFile1 = '.\RoutingNetworkTraffic_Parameters.json'

# import the AzureRM modules
Import-Module AzureRM.Resources

#  login
Login-AzureRmAccount

# create the resource from the template - pass names as parameters
New-AzureRmResourceGroup -Location "East US" -Name $ServergName1

New-AzureRmResourceGroupDeployment -Verbose -Force -ResourceGroupName $ServergName1 -TemplateFile $templateFile1 -TemplateParameterFile $templateparameterFile1 

#Remove-AzureRmResourceGroup $ServergName1 -Force
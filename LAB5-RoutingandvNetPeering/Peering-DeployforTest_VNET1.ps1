# parameters 
$ServergName1 = "NetEssentPeering1"
$templateFile1 = '.\vNETpeeringVNET1_Template.json'
$templateparameterFile1 = '.\vNETpeeringVNET1_Parameters.json'

# import the AzureRM modules
Import-Module AzureRM.Resources

#  login
Login-AzureRmAccount

# create the resource from the template - pass names as parameters
New-AzureRmResourceGroup -Location "East US" -Name $ServergName1

New-AzureRmResourceGroupDeployment -Verbose -Force -ResourceGroupName $ServergName1 -TemplateFile $templateFile1 -TemplateParameterFile $templateparameterFile1 

Remove-AzureRmResourceGroup $ServergName1 -Force
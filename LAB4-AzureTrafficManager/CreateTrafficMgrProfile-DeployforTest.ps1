
# parameters 
$rgName = "NetEssentWebApp"
$templateFile = '.\CreateTrafficMgrProfile_Template.json'

# import the AzureRM modules
Import-Module AzureRM.Resources

#  login
Login-AzureRmAccount

# create the resource from the template - pass names as parameters
New-AzureRmResourceGroup -Location "East US 2" -Name $rgName
New-AzureRmResourceGroupDeployment -Verbose -Force -ResourceGroupName $rgName -TemplateFile $templateFile
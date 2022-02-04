# parameters 
$ServergName1 = "vWAN"
$templateFile1 = '.\AzureVirtualWAN_Templatejson'
$templateparameterFile1 = '.\AzureVirtualWAN_Parameters.json'

# import the AzureRM modules
Import-Module AzureRM.Resources

#  login
Login-AzureRmAccount

# create the resource from the template - pass names as parameters
New-AzureRmResourceGroup -Location "East US 2" -Name $ServergName1

New-AzureRmResourceGroupDeployment -Verbose -Force -ResourceGroupName $ServergName1 -TemplateFile $templateFile1 -TemplateParameterFile $templateparameterFile1 

#Remove-AzureRmResourceGroup $ServergName1 -Force
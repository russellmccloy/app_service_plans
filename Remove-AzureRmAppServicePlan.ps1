[CmdletBinding(PositionalBinding=$True)]
    Param
    (    
        [Parameter(Mandatory = $true)]
	    [String]$SubscriptionId,

        [Parameter(Mandatory = $true)]
	    [String]$AppServicePlanName,

        [Parameter(Mandatory = $true)]
        [String]$ResourceGroupName
	)

function Check-Session () {
    $Error.Clear()

    #if context already exist
    Get-AzureRmContext -ErrorAction Continue
    foreach ($eacherror in $Error) {
        if ($eacherror.Exception.ToString() -like "*Run Login-AzureRmAccount to login.*") {
            Login-AzureRmAccount
        }
    }

    $Error.Clear();
}

cls

$environment = New-Object System.Object
    $environment | Add-Member -type NoteProperty -name SubscriptionId -Value ""
    $environment | Add-Member -type NoteProperty -name ResourceGroupName -Value ""
    $environment | Add-Member -type NoteProperty -name ResourceGroupLocation -Value ""

    # Enter your subscriptionid and resource Group
    $environment.SubscriptionId = $SubscriptionId
    $environment.ResourceGroupName = $ResourceGroupName

$environment.SubscriptionId;

Write-Host "Logging in..." -ForegroundColor Yellow;
Check-Session;

Write-Host "Selecting the subscription you want to work with..." -ForegroundColor Yellow;

Select-AzureRmSubscription -SubscriptionID $environment.SubscriptionId;

Remove-AzureRmAppServicePlan -Name $AppServicePlanName -ResourceGroupName $ResourceGroupName
<#
    UAT - 6a7dabba-f52c-4bab-a21b-ed5930adf081
    DEV - 2cfe2141-6853-4cef-80d9-635af3ad9b42
    aspaseuatcc03
    rgaseprecc01
#>



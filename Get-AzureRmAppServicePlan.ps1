[CmdletBinding(PositionalBinding=$True)]
    Param
    (    
        [Parameter(Mandatory = $true)]
	    [String]$SubscriptionId,

        [Parameter(Mandatory = $true)]
        [String]$ResourceGroupName,

    	[Parameter(Mandatory = $true)]
		[String]$LocationForCSV
	)

. "D:\MyDropbox\Dropbox (Personal)\My Documents\Technical - Azure Code Etc\General Powershell\Azure\login_to_azure.ps1"

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

$allAppServicePlansInRG = Get-AzureRmAppServicePlan -ResourceGroupname $ResourceGroupName
$allAppServicePlansInRG
cd C:\ 

$PathToSaveTo = $LocationForCSV;

if((Test-Path $PathToSaveTo) -eq 0)
{
    mkdir $PathToSaveTo;
    cd $PathToSaveTo;
}
 
$dateForFolderName = (Get-Date -format "yyyy-MM-dd");
$dateForFolderName = $dateForFolderName;

$myPath = $dateForFolderName + ".csv";

$allAppServicePlansInRG | Foreach-Object {

    New-Object -TypeName PSObject -Property @{
                        Name = $_.Name    
                        Type = $_.Type 
                        NumberOfSites = $_.NumberOfSites  
                        MaximumNumberOfWorkers = $_.MaximumNumberOfWorkers
                } | Select-Object Name, Type, NumberOfSites, MaximumNumberOfWorkers
} | Export-Csv -Path $myPath -Append -NoTypeInformation 

<#
    DEV -     2cfe2141-6853-4cef-80d9-635af3ad9b42    rgasedevcc01    rgaesdevcc01
    UAT -     6a7dabba-f52c-4bab-a21b-ed5930adf081    rgaseuatcc01    rgaesuatcc01
    PROD -    f49866a0-a03d-4e77-bd84-bff800876364    rgaseprdcc01    rgaesprdcc01
#>


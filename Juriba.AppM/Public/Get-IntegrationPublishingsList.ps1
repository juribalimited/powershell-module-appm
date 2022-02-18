function Get-IntegrationPublishingsList {
    <#
      .SYNOPSIS
      This function is used to get publishing identifiers collection.
      .DESCRIPTION
      The function retrieves a collection of publishing identifiers created for a specific generic integration.
      .EXAMPLE
      Get-IntegrationPublishingsList -Instance "appm.demo.juriba.com" -Port 443 -APIKey "GdyisqPgfd+KqJp6nS3PV3gggM+dh57jHWctzAzj/nDfxWZ7+g0CnvA==" -IntegrationId 1 -Limit 10 -PackageTypes "Msi,AppV"
      Retrieves a collection of last 10 created MSI and App-V publishing identifiers for the generic integration with identifier equal to 1.
    #>

    [CmdletBinding()]
    param (

        [Parameter(Mandatory = $true)]
        [string]$Instance,
        [Parameter(Mandatory=$false)]
        [int]$Port = 443,
        [Parameter(Mandatory = $true)]
        [string]$APIKey,
        [Parameter(Mandatory = $true)]
        [int]$IntegrationId,
        [Parameter(Mandatory = $false)]
        [int]$Limit,
        [Parameter(Mandatory = $false)]
        [string]$PackageTypes
    )

    $Uri = "https://" + $Instance + ":$($Port)/api/v1/integration/generic/$($IntegrationId)/published-app?"

    if ($Limit -ne 0) {
        $Uri = $Uri + "limit=$($Limit)&"
    }

    if (-not ([string]::IsNullOrEmpty($PackageTypes))) {
        $Uri = $Uri + "packageTypes=$($PackageTypes)"
    }

    try {
        $Publishings = Invoke-WebRequest -Uri $Uri -Headers @{"x-api-key"=$APIKey;}
    }
    catch {
        Write-Error $_.Exception.Message
        break
    }

    $Publishings.Content | ConvertFrom-Json
}
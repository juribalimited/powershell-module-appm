function Get-PublishingPropertiesList {
    <#
      .SYNOPSIS
      This function is used to get publishing properties collection.
      .DESCRIPTION
      The function retrieves a collection of properties for a publishing is executing to a specific generic integration.
      .EXAMPLE
      Get-PublishingPropertiesList -Instance "appm.demo.juriba.com" -Port 443 -APIKey "GdyisqPgfd+KqJp6nS3PV3gggM+dh57jHWctzAzj/nDfxWZ7+g0CnvA==" -IntegrationId 1 -PublishingId 2
      Retrieves a collection of properties for the publishing with identifier equal to 2 that is executing to the integration with identifier equal to 1.
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
        [Parameter(Mandatory = $true)]
        [int]$PublishingId
    )

    try {
        $Properties = Invoke-WebRequest -Uri ("https://" + $Instance + ":$($Port)/api/v1/integration/generic/$($IntegrationId)/published-app/$($PublishingId)") -Headers @{"x-api-key"=$APIKey;}
    }
    catch {
        Write-Error $_.Exception.Message
        break
    }

    $Properties.Content | ConvertFrom-Json
}
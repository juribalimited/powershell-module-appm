function Get-PublishingPrerequisitesList {
    <#
      .SYNOPSIS
      This function is used to get publishing prerequisites collection.
      .DESCRIPTION
      The function retrieves a collection of prerequisites for a publishing is executing to a specific generic integration.
      .EXAMPLE
      Get-PublishingPrerequisitesList -APIKey "GdyisqPgfd+KqJp6nS3PV3gggM+dh57jHWctzAzj/nDfxWZ7+g0CnvA==" -Instance "appm.demo.juriba.com" -IntegrationId 1 -PublishingId 2
      Retrieves a collection of prerequisites for the publishing with identifier equal to 2 that is executing to the to the integration with identifier equal to 1.
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
        $Prerequisites = Invoke-WebRequest -Uri ("https://" + $Instance + ":$($Port)/api/v1/integration/generic/$($IntegrationId)/published-app/$($PublishingId)/prerequisites") -Headers @{"x-api-key"=$APIKey;}
    }
    catch {
        Write-Error $_.Exception.Message
        break
    }

    $Prerequisites.Content | ConvertFrom-Json
}
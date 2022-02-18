function Get-GenericIntegrationsList {
    <#
      .SYNOPSIS
      This function is used to get generic integrations collection.
      .DESCRIPTION
      The function retrieves a collection of AppM generic integrations.
      .EXAMPLE
      Get-GenericIntegrationsList -Instance "appm.demo.juriba.com" -Port 443 -APIKey "GdyisqPgfd+KqJp6nS3PV3gggM+dh57jHWctzAzj/nDfxWZ7+g0CnvA=="
      Retrieves a collection of genereic integrations located on the demo instance of AppM.
    #>

    [CmdletBinding()]
    param (

        [Parameter(Mandatory = $true)]
        [string]$Instance,
        [Parameter(Mandatory=$false)]
        [int]$Port = 443,
        [Parameter(Mandatory = $true)]
        [string]$APIKey
    )

    try {
        $Intergrations = Invoke-WebRequest -Uri ("https://" + $Instance + ":$($Port)/api/v1/integration/generic") -Headers @{"x-api-key"=$APIKey;}
    }
    catch {
        Write-Error $_.Exception.Message
        break
    }

    $Intergrations.Content | ConvertFrom-Json
}
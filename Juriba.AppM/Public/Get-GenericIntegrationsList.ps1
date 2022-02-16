function Get-GenericIntegrationsList {
    <#
      .SYNOPSIS
      This function is used to get generic integrations collection.
      .DESCRIPTION
      The function retrieves a collection of AppM generic integrations.
      .EXAMPLE
      Get-GenericIntegrationsList -Authorization "GdyisqPgfd+KqJp6nS3PV3gggM+dh57jHWctzAzj/nDfxWZ7+g0CnvA==" -Instance "appm.demo.juriba.com"
      Retrieves a collection of genereic integrations located on the demo instance of AppM.
    #>

    [CmdletBinding()]
    param (

        [Parameter(Mandatory = $true)]
        [string]$Authorization,
        [Parameter(Mandatory = $true)]
        [string]$Instance
    )

    try {
        $Intergrations = Invoke-WebRequest -Uri ("https://" + $Instance + "/api/v1/integration/generic") -Headers @{"x-api-key"=$Authorization;}
    }
    catch {
        Write-Error $_.Exception.Message
        break
    }

    $Intergrations
}
function Get-ApplicationPackageInformation {
    <#
      .SYNOPSIS
      This function is used to get application package information.
      .DESCRIPTION
      The function retrieves an information about last application package version.
      .EXAMPLE
      Get-ApplicationPackageInformation -Authorization "GdyisqPgfd+KqJp6nS3PV3gggM+dh57jHWctzAzj/nDfxWZ7+g0CnvA==" -Instance "appm.demo.juriba.com" -ApplicationPackageDetailsUrl "api/v1/application/1/package/Msi"
      Retrieves MSI package details for the application with identifier equal to 1.
    #>

    [CmdletBinding()]
    param (

        [Parameter(Mandatory = $true)]
        [string]$Authorization,
        [Parameter(Mandatory = $true)]
        [string]$Instance,
        [Parameter(Mandatory = $true)]
        [string]$ApplicationPackageDetailsUrl
    )

    try {
        $Details = Invoke-RestMethod -Uri ("https://" + $Instance + ":443/" + $ApplicationPackageDetailsUrl) -Headers @{"x-api-key"=$Authorization;}
    }
    catch {
        Write-Error $_.Exception.Message
        break
    }

    $Details
}
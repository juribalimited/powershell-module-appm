function Get-ApplicationPackageInformation {
    <#
      .SYNOPSIS
      This function is used to get application package information.
      .DESCRIPTION
      The function retrieves an information about last application package version.
      .EXAMPLE
      Get-ApplicationPackageInformation -APIKey "GdyisqPgfd+KqJp6nS3PV3gggM+dh57jHWctzAzj/nDfxWZ7+g0CnvA==" -Instance "appm.demo.juriba.com" -ApplicationPackageDetailsUrl "api/v1/application/1/package/Msi"
      Retrieves MSI package details for the application with identifier equal to 1.
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
        [string]$ApplicationPackageDetailsUrl
    )

    try {
        $Details = Invoke-WebRequest -Uri ("https://" + $Instance + ":$($Port)/" + $ApplicationPackageDetailsUrl) -Headers @{"x-api-key"=$APIKey;}
    }
    catch {
        Write-Error $_.Exception.Message
        break
    }

    $Details.Content | ConvertFrom-Json
}
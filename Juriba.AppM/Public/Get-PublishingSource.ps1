function Get-PublishingSource {
    <#
      .SYNOPSIS
      This function is used to get publishing package source.
      .DESCRIPTION
      The function retrieves an publishing package source chosen for a specific integration.
      .EXAMPLE
      Get-PublishingSource -Authorization "GdyisqPgfd+KqJp6nS3PV3gggM+dh57jHWctzAzj/nDfxWZ7+g0CnvA==" -Instance "appm.demo.juriba.com" -PublishingSourceUrl "api/v1/integration/generic/1/published-app/2/source" -SourcePath "C:\"
      Retrieves package source for the publishing with identifier equal to 2 to the integration with identifier equal to 1. The result will be saved to SourcePath.
    #>

    [CmdletBinding()]
    param (

        [Parameter(Mandatory = $true)]
        [string]$Authorization,
        [Parameter(Mandatory = $true)]
        [string]$Instance,
        [Parameter(Mandatory = $true)]
        [string]$PublishingSourceUrl,
        [Parameter(Mandatory = $true)]
        [string]$SourcePath
    )

    $TempName = New-Guid
    $OutFile = Join-Path $SourcePath -ChildPath $TempName

    try {
        $Source = Invoke-WebRequest -Uri ("https://" + $Instance + "/" + $PublishingSourceUrl) -Headers @{"x-api-key"=$Authorization;} -OutFile $OutFile -PassThru

        $Content = [System.Net.Mime.ContentDisposition]::new($Source.Headers['Content-Disposition'])

        Rename-Item $OutFile $OutFile.Replace($TempName, $Content.FileName)
    }
    catch {
        Write-Error $_.Exception.Message
        break
    }

    $Content.FileName
}
function Add-PublishingLog {
    <#
      .SYNOPSIS
      This function is used to add publishing log.
      .DESCRIPTION
      The function adds new log for the publishing is executing to a specific generic integration.
      .EXAMPLE
      Add-PublishingLog -Authorization "GdyisqPgfd+KqJp6nS3PV3gggM+dh57jHWctzAzj/nDfxWZ7+g0CnvA==" -Instance "appm.demo.juriba.com" -IntegrationId 1 -PublishingId 2 -Message "New log" -Level "Information" -Date "02/23/2021 01:22" -PublishedAppId "1" -PublishedAppName "Application 1"
      Adds new log for the publishing with identifier equal to 2 that is executing to the integration with identifier equal to 1.
    #>

    [CmdletBinding()]
    param (

        [Parameter(Mandatory = $true)]
        [string]$Authorization,
        [Parameter(Mandatory = $true)]
        [string]$Instance,
        [Parameter(Mandatory = $true)]
        [int]$IntegrationId,
        [Parameter(Mandatory = $true)]
        [int]$PublishingId,
                [Parameter(Mandatory = $true)]
                [string]$Message,
                [Parameter(Mandatory = $true)]
                [ValidateSet('Information','Warning','Error', 'Debug')]
                [string]$Level,
                [Parameter(Mandatory = $true)]
                [DateTime]$Date,
                [Parameter(Mandatory = $false)]
                [string]$PublishedAppId,
                [Parameter(Mandatory = $false)]
                [string]$PublishedAppName
    )

        $LogBody = @{
                "message"= $($Message);
                "level" = $Level;
                "date" = $Date;
                "publishedAppId" = $PublishedAppId;
                "publishedAppName" = $PublishedAppName;
        } |ConvertTo-Json

        try {
                Invoke-WebRequest -Uri ("https://" + $Instance + "/api/v1/integration/generic/$($IntegrationId)/published-app/$($PublishingId)/logs") -Method POST -Body $LogBody -ContentType application/json -Headers @{"x-api-key"=$Authorization;}
        }
    catch {
        Write-Error $_.Exception.Message
        break
    }
}
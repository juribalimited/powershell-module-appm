function Update-PublishingState {
    <#
      .SYNOPSIS
      This function is used to update publishing state.
      .DESCRIPTION
      The function updates state of the publishing is executing to a specific generic integration.
      .EXAMPLE
      Update-PublishingState -APIKey "GdyisqPgfd+KqJp6nS3PV3gggM+dh57jHWctzAzj/nDfxWZ7+g0CnvA==" -Instance "appm.demo.juriba.com" -IntegrationId 1 -PublishingId 2 -PublishingState "Succeeded" -PublishedAppId "1" -PublishedApplicationVersion "1.0"
      Updates state of the publishing with identifier equal to 2 that is executing to the integration with identifier equal to 1.
    #>

    [CmdletBinding(SupportsShouldProcess)]
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
        [int]$PublishingId,
        [Parameter(Mandatory = $true)]
        [ValidateSet('Succeeded','Failed')]
        [string]$PublishingState,
        [Parameter(Mandatory = $false)]
        [string]$PublishedAppId,
        [Parameter(Mandatory = $false)]
        [string]$PublishedApplicationVersion
    )

    $StateBody = @{
            "publishedAppId" = $PublishedAppId;
            "publishingState" = $PublishingState
            "publishedApplicationVersion" = $PublishedApplicationVersion;
    } | ConvertTo-Json

    $Target = "App ID: {0}, Version: {1}" -f $PublishedAppId, $PublishedApplicationVersion

    if($PSCmdlet.ShouldProcess($Target))
    {
        try {
            Invoke-WebRequest -Uri ("https://" + $Instance + ":$($Port)/api/v1/integration/generic/$($IntegrationId)/published-app/$($PublishingId)") -Method PUT -Body $StateBody -ContentType application/json -Headers @{"x-api-key"=$APIKey;}
        }
        catch {
            Write-Error $_.Exception.Message
            break
        }
    }
}
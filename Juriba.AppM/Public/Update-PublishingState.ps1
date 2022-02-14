function Update-PublishingState {
    <#
      .SYNOPSIS
      This function is used to update publishing state.
      .DESCRIPTION
      The function updates state of the publishing is executing to a specific generic integration.
      .EXAMPLE
      Update-PublishingState -Authorization "GdyisqPgfd+KqJp6nS3PV3gggM+dh57jHWctzAzj/nDfxWZ7+g0CnvA==" -Instance "appm.demo.juriba.com" -IntegrationId 1 -PublishingId 2 -PublishingState "Succeeded" -PublishedAppId "1" -PublishedApplicationVersion "1.0" 
      Updates state of the publishing with identifier equal to 2 that is executing to the integration with identifier equal to 1.
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
		"publishedApplicationVersion" = $PublishingApplicationVersion;
	} |ConvertTo-Json
	
	try {
		Invoke-WebRequest -Uri ("https://" + $Instance + ":443/api/v1/integration/generic/$($IntegrationId)/published-app/$($PublishingId)") -Method PUT -Body $StateBody -ContentType application/json -Headers @{"x-api-key"=$Authorization;}
	}
    catch {
        Write-Error $_.Exception.Message
        break
    }
}
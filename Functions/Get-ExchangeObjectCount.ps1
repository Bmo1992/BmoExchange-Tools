Function Get-ExchangeObjectCount
{
    <#
        .SYNOPSIS
          Get a quick count of how many of a specific object there is in the current Exchange database.

        .DESCRIPTION
          Get a quick county of a specific object in Exchange that you need a total number count for.  Current objects supported include mailboxes, distributions lists, public folders, and active sync devices.

        .PARAMETER Mailboxes
          Specify that youd like the total number of mailboxes in Exchange.

        .PARAMETER DistributionGroups
          Specify that youd like the total number of distribution groups in Exchange.

        .PARAMETER PublicFolders
          Specify that youd like the total number of public folders in Exchange.

        .PARAMETER ActiveSyncDevices
          Specify that youd like the total number of active sync devices in Exchange.

        .EXAMPLE
          Get-ExchangeObjectCount -Mailboxes

          Return the total number of all mailboxes in Exchange.

        .EXAMPLE
          Get-ExchangeObjectCount -DistributionGroups

          Return the total number of all distribution groups in Exchange.

        .EXAMPLE
          Get-ExchangeObjectCount -PublicFolders

          Return the total number of all public folders in Exchange.

        .EXAMPLE
          Get-ExchangeObjectCount -ActiveSyncDevices

          Return the total number of all active sync devices in Exchange.

        .NOTES
          NAME    : Get-ExchangeObjectCount
          AUTHOR  : BMO
          EMAIL   : brandonseahorse@gmail.com
          GITHUB  : github.com/Bmo1992
          CREATED : January 26, 2019
    #>

    [CmdletBinding()]
    Param
    (
        [Parameter(
        )]
        [switch]$Mailboxes,
        [switch]$DistributionGroups,
        [switch]$PublicFolders,
        [switch]$ActiveSyncDevices
    )

    if($Mailboxes)
    {
        Write-Host "There are $((Get-Mailbox | Select -ExpandProperty Alias).Count) mailboxes in Exchange."
    }
    elseif($DistributionGroups)
    {
        Write-Host "There are $((Get-DistributionGroup | Select -ExpandProperty PrimarySmtpAddress).Count) distribution lists in Exchange."
    }
    elseif($PublicFolders)
    {
        Write-Host "There are $((Get-PublicFolder "\" -Recurse | Select -ExpandProperty Name).Count) public folders in Exchange."
    }
    elseif($ActiveSyncDevices)
    {
        Write-Host "There are $((Get-ActiveSyncDevice | Select -ExpandProperty Name).Count) active sync devices in Exchange."
    }
    else
    {
        Throw "Please specify a paramter, for more information type 'Get-Help Get-ExchangeObjectCount'"
    }
}

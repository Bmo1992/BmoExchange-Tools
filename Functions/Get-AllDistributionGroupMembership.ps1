Function Get-AllDistributionGroupMembership
{
    <#
        .SYNOPSIS
          Retrieve a list of all email distribution lists is a member of.   

        .DESCRIPTION
          Search through the membership roster of every distribution list in exchange and print out the lists name if the specified user is a member of that list.

        .PARAMETER FullName
          Specify the full first and last name of the user account youre searching for.

        .EXAMPLE
          Get-AllDistributionGroupMembership -FullName "John Doe"

          Retrieve a list of all distribution groups user John Doe is currently a member of.

        .NOTES
          NAME    : Get-AllDistributionGroupMembership
          AUTHOR  : BMO
          EMAIL   : brandonseahorse@gmail.com
          GITHUB  : github.com/Bmo1992
          CREATED : January 26, 2019
    #>

    [CmdletBinding()]
    Param
    (
        [Parameter(
            Mandatory=$True
        )]
        [string]$FullName
    )

    # Get the names of all the distribution groups in exchange
    $distro_lists = Get-DistributionGroup | Select -ExpandProperty Name

    # Search through each distribution group, compare it to the users name, and print that lists name to stdout
    ForEach($list in $distro_lists)
    {
        if((Get-DistributionGroupMember $list).Name -match $FullName)
        {
            Write-Host $list
        }
    }
}

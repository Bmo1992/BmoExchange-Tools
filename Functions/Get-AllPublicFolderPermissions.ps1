Function Get-AllPublicFolderPermissions
{
    <#
        .SYNOPSIS
          Find all public folders in exchange a user or group has access to.

        .DESCRIPTION
          Get a list of all the public folders in Exchange and then compare the user or group name to each folders access rights and print out the name and access rights level the user/group has to the public folder.


        .PARAMETER Identity
          Specify the name of the user or group youre searching for.
 
        .EXAMPLE
          Get-AllPublicFolderPermissions -Identity "Finance Admins"

          Get the name and access rights of all public folders the Finance Admins security group has access to.

        .EXAMPLE
          Get-AllPublicFolderPermissions -Identity "jdoe"

          Get the name and access rights of all public folders the user jdoe has access to.

        .NOTES
          NAME    : Get-AllPublicFolderPermissions
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
        [string]$Identity
    )

    $public_folders = Get-PublicFolder "\" -Recurse | Select -ExpandProperty Identity

    ForEach($folder in $public_folders)
    {
        Get-PublicFolderClientPermission $folder | Where `
            {
                $_.User -match $Identity
            } | `
            Select Identity,AccessRights
    }
}

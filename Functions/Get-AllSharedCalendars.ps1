Function Get-AllSharedCalendars
{
    <#
        .SYNOPSIS
          Get all shared calendars in Exchange.

        .DESCRIPTION
          Search each mailbox in Exchange and check to see if anyone other then the owner has explicitly been given permission to it.

        .EXAMPLE
          Get-AllSharedCalendars

          Gets all the calendars that have been shared out to other users in Exchange.

        .NOTES
          NAME    : Get-AllSharedCalendars
          AUTHOR  : BMO
          EMAIL   : brandonseahorse@gmail.com
          GITHUB  : github.com/Bmo1992
          CREATED : January 26, 2019
    #>

    $mailboxes = Get-Mailbox | Select -ExpandProperty PrimarySmtpAddress

    $shared_mailboxes = ForEach($mailbox in $mailboxes)
    {
        Get-MailboxFolderPermission (($mailbox)+":\Calendar") | `
            ForEach
            {    
                if($_.User -notmatch "Default" -and $_.User -notmatch "Anonymous")
                {
                    Write-Output $mailbox
                }
            } | `
            Get-Unique
    }; $shared_mailboxes
}

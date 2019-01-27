Function Get-MailboxQuotas
{
    <#
        .SYNOPSIS
          Get the quotas set on all mailboxes in Exchange.

        .DESCRIPTION
          Get-MailboxQuotas is a function for Exchange PS to grab the configured quota information for all users. Useful for environments where mail quotas are configured manually for specific groups of users.

        .EXAMPLE
          Get-MailboxQuotas

          Return a list of all mailboxes and their current warning, prohibit send, and prohibit send/recieve quotas.

        .NOTES
          NAME    : Get-MailboxQuotas
          AUTHOR  : BMO
          EMAIL   : brandonseahorse@gmail.com
          GITHUB  : github.com/Bmo1992
          CREATED : September 21, 2018
    #>

    [CmdletBinding()]
    Param
    (
  
    )

    $mailboxes = Get-Mailbox -Filter * -ErrorAction SilentlyContinue

    $mailboxes | Select-Object `
        @{
            Expression={
                $_.Alias
            };
            Label="Email"
        },
        @{
            Expression={
                $_.IssueWarningQuota
            };
            Label="Warning"
        },
        @{
            Expression={
                $_.ProhibitSendQuota
            };
            Label="Send Limit"
        },
        @{
            Expression={
                $_.ProhibitSendReceiveQuota
            };
            Label="Receive Limit"
        } | Format-Table
}

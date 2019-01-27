<#
    .DESCRIPTION
      BmoExchange-Tools is a powershell module designed for automating Exchange auditing and management.

    .NOTES
      NAME    : BmoExchange-Tools 
      AUTHOR  : BMO
      EMAIL   : brandonseahorse@gmail.com
      GITHUB  : github.com/Bmo1992
      CREATED : January 26, 2019
#>

# Get the path to the module functions
$Functions = @(Get-ChildItem -Path $PSScriptRoot\Functions\*.ps1 -ErrorAction SilentlyContinue)

# Try to load each function by dot sourcing the ps1 file in the Functions directory. Send sourcing failures to stderr.
ForEach($module_function in $Functions)
{
    Try
    {
        . $module_function.fullname
    }
    Catch
    {
        Write-Error -Message "Failed to import function $($module_function.fullname): $_"
    }
}

# Export all the functions from the dot sourced files.
Export-ModuleMember -Function $Functions.Basename -Alias *

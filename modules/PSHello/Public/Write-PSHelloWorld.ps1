<#
    .Synopsis
        Simple function that writes the classic "Hello world!" message.

    .Example
        PS> Write-PSHelloWorld
        Hello world!
#>
function Write-PSHelloWorld {
    Write-Host "Hello world!"
}

Export-ModuleMember -Function Write-PSHelloWorld
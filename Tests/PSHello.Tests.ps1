BeforeAll {
    Import-Module PSHello
}

Describe "Write-PSHelloWorld" {
    It 'Writes "Hello world!"' {
        InModuleScope PSHello {
            Mock Write-Host {}

            Write-PSHelloWorld

            Should -Invoke Write-Host -ParameterFilter {
                $Object -eq "Hello world!"
            }
        }
    }
}
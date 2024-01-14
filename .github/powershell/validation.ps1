
BeforeDiscovery {
    $exclude = @(
        "README.md",
        "Gemfile",
        "CNAME"
    )

    $files = Get-ChildItem -Recurse -Exclude $exclude
}


Describe "Naming convention"  {
    It "Should be lower case: <_.Name>" -ForEach $files {
        $_.Name -cmatch '[A-Z]' | Should -Be $false
    }
}

BeforeDiscovery {
    $exclude = @(
        "README.md",
        "Gemfile",
        "Gemfile.lock",
        "CNAME",
        "KnowledgeWorker__Edge.txt",
        "KnowledgeWorker__Chrome.txt",
        "KnowledgeWorker__FireFox.txt",
        "KnowledgeWorker__IE.txt",
        "KnowledgeWorker_RDA_filecopy.txt"
    )

    $folders = @(
        "_includes",
        "_layouts",
        "_pages",
        "_sass",
        "assets",
        "events",
        "members",
        "posts",
        "sponsors"
    )

    $files = Get-ChildItem -Path $folders -Recurse -Exclude $exclude
    $files += Get-ChildItem -Exclude $exclude

}

Describe "Naming convention"  {
    It "Should be lower case: <_.Name>" -ForEach $files {
        $_.Name -cmatch '[A-Z]' | Should -Be $false
    }
}

Describe "File types"  {
    It "Images should be in the asset directory: <_.Name>" -ForEach ($files | Where-Object {$_.Name -like "*.png" -or $_.Name -like "*.jpg"}) {
        $_.FullName.Contains("assets") | Should -Be $true
    }
}
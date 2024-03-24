[CmdletBinding()]
param(
    [Parameter(Mandatory)]
    [ArgumentCompletions('check', 'apply')]
    $Mode,
    [Parameter(Mandatory)]
    [string]$Path
)

switch ($Mode) {
    'check' {
        $hash = (Get-FileHash -LiteralPath $path -Algorithm SHA256).Hash
        if ($hash -ne 'B57C243D5ED3A617C115D54B69C2FC302EBC35F78FDD2FE0D1E34F4901DD6357') { throw "Hash does not match: $hash" }
    }
    'apply' {
        $content = [System.IO.File]::ReadAllBytes($path)
        $content[0x4c0] = 0x7D
        for ($i = 4; $i -ge 0; $i--) {
            $content[0x7ff7 + $i + 1] = $content[0x7ff7 + $i]
        }
        $content[0x7ff7] = 0x7e # ~
        [System.IO.File]::WriteAllBytes($path, $content)
    }
}

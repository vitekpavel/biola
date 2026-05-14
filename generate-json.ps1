$root = "obrazky"
$output = "images.json"

$extensions = @("*.jpg", "*.png", "*.webp")

$list = @()

foreach ($ext in $extensions) {
    Get-ChildItem -Path $root -Recurse -Filter $ext | ForEach-Object {

        $relative = $_.FullName.Substring((Resolve-Path $root).Path.Length + 1)
        $relative = $relative -replace "\\","/"

        $list += $relative
    }
}

$list = $list | Sort-Object

$json = $list | ConvertTo-Json -Depth 1

# ✅ TADY JE OPRAVA
$encoding = New-Object System.Text.UTF8Encoding($false)
[System.IO.File]::WriteAllText($output, $json, $encoding)

Write-Host "✅ images.json vytvořen"
import-module powershell-yaml

function Get-Version {
    param (
        $LibraryName
    )

    $puspec = ".\libs\{0}\pubspec.yaml" -f $LibraryName
    $yaml = (Get-Content $puspec) | ConvertFrom-Yaml
    return [string] $yaml.version
}

function Publish-Library {
    param (
        $LibraryName
    )

    Write-Host "Publishing $LibraryName" -foregroundcolor green

    cd ".\libs\$LibraryName"
    flutter pub publish -f
    cd "..\..\"
}

function Publish-SubLibrary {

    param (
        $LibraryName,
        $LibraryCore = "flutter_adaptive_core"
    )

    $puspec = ".\libs\{0}\pubspec.yaml" -f $LibraryName
    $changelog = ".\libs\{0}\CHANGELOG.md" -f $LibraryName

    $libraryversion = Get-Version -LibraryName $LibraryName
    $coreversion = Get-Version -LibraryName $LibraryCore

    Write-Host "Updating library versions and change logs" -foregroundcolor green

    Copy-Item -Path ".\libs\$LibraryCore\CHANGELOG.md" -Destination $changelog -Recurse -force

    (Get-Content $puspec).Replace($libraryversion, $coreversion) | Set-Content $puspec

    (Get-Content $puspec).Replace("flutter_adaptive_core:", "flutter_adaptive_core: $coreversion") | Set-Content $puspec
    (Get-Content $puspec).Replace("    path: ../flutter_adaptive_core", "#    path: ../flutter_adaptive_core") | Set-Content $puspec

    Publish-Library -LibraryName $LibraryName

    (Get-Content $puspec).Replace("flutter_adaptive_core: $coreversion", "flutter_adaptive_core:") | Set-Content $puspec
    (Get-Content $puspec).Replace("#    path: ../flutter_adaptive_core", "    path: ../flutter_adaptive_core") | Set-Content $puspec
}

$version = Get-Version -LibraryName "flutter_adaptive_core"
$tag = "v{0}" -f $version

Write-Host "Using version tag: $tag for version $version" -foregroundcolor green

Publish-Library -LibraryName "flutter_adaptive_core"

Write-Host "Waiting 5 seconds for core package to be available..." -foregroundcolor yellow
Start-Sleep -Seconds 5

Publish-SubLibrary -LibraryName "flutter_adaptive_fluent_ui"
Publish-SubLibrary -LibraryName "flutter_adaptive_macos_ui"
Publish-SubLibrary -LibraryName "flutter_adaptive_yaru"

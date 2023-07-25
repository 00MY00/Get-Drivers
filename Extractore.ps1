# Définir le chemin du fichier PowerShell contenant les zones de texte
$sourceFilePath = "get-drivers.ps1"

# Définir le chemin du fichier 'FR.GetDriver' dans lequel nous ajouterons le contenu des zones de texte
$destinationFilePath = "FR.GetDriver"

if (Test-Path "$destinationFilePath") {rm "$destinationFilePath"}

# Lire le contenu du fichier PowerShell source
$scriptContent = Get-Content -Path $sourceFilePath

# Filtrer les lignes qui contiennent des commandes Write-Host
$writeHostLines = $scriptContent | Where-Object { $_ -match '^\s*Write-Host\s+"([^"]+)"' }

# Récupérer le contenu entre les guillemets après les commandes Write-Host
$extractedText = $writeHostLines | ForEach-Object { $_ -replace '^\s*Write-Host\s+"([^"]+)".*', '$1' }

# Écrire le contenu dans le fichier 'FR.GetDriver' en format UTF-8
$extractedText | Set-Content -Path $destinationFilePath -Encoding UTF8

Write-Host "Contenu extrait avec succès dans le fichier 'FR.GetDriver' en format UTF-8."




# Définir le chemin du fichier 'FR.GetDriver'
$destinationFilePath = "FR.GetDriver"

# Lire le contenu du fichier 'FR.GetDriver'
$scriptContent = Get-Content -Path $destinationFilePath

# Filtrer les lignes qui contiennent du texte
$textLines = $scriptContent | Where-Object { $_ -match '\S' }

# Créer un dictionnaire pour stocker les hachages déjà utilisés
$hashesUsed = @{}

# Écrire le contenu mis à jour dans le fichier 'FR.GetDriver' avec un nouveau code aléatoire pour chaque ligne
$textLines | ForEach-Object {
    $random = New-Object System.Random
    $validChars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789'
    $code = -join (0..9 | ForEach-Object { $validChars[$random.Next(0, $validChars.Length)] }) + ';'

    # Vérifier si une ligne identique existe déjà
    $lineWithCode = "$code$_"
    $hash = $lineWithCode.GetHashCode()
    if ($hashesUsed.ContainsKey($hash)) {
        $code = $hashesUsed[$hash]
    } else {
        $hashesUsed[$hash] = $code
    }

    $code + $_
} | Set-Content -Path $destinationFilePath -Encoding UTF8

Write-Host "Code aléatoire ajouté devant chaque ligne avec du texte dans le fichier 'FR.GetDriver'."



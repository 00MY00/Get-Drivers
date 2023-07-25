# Définir le chemin du fichier 'get-drivers.ps1'
$scriptFilePath = "get-drivers.ps1"

# Charger le contenu du fichier 'get-drivers.ps1'
$scriptContent = Get-Content -Path $scriptFilePath

# Créer un tableau pour stocker les lignes modifiées
$nouveauContenu = @()

# Initialiser le compteur pour les variables $txtX
$compteur = 0

# Parcourir chaque ligne du fichier
foreach ($ligne in $scriptContent) {
    # Vérifier si la ligne contient "Write-Host" et qu'elle n'a pas de commentaire avant
    if ($ligne -match '^[^#]*Write-Host "(.*?)"') {
        # Extraire le texte entre guillemets
        $texte = $Matches[1]

        if ($texte -ne "") {
            # Créer la nouvelle ligne avec la syntaxe $ExecutionContext.InvokeCommand.ExpandString("`$txt$compteur`")
            $nouvelleLigne = $ligne -replace '"(.*?)"', "`$ExecutionContext.InvokeCommand.ExpandString(`"`$txt$compteur`"`)"

            $compteur++
        } else {
            # Conserver la ligne sans modification
            $nouvelleLigne = $ligne
        }
    } else {
        # Conserver les autres lignes telles quelles
        $nouvelleLigne = $ligne
    }

    # Ajouter la nouvelle ligne au tableau
    $nouveauContenu += $nouvelleLigne
}

# Écrire le contenu modifié dans le fichier 'get-drivers-2.ps1'
$nouveauContenu | Out-File -FilePath "get-drivers-2.ps1" -Force

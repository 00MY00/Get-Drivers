#Extrèt le txt et crée des variable $text'NB'
function RecuperationLangue() {     # Fonction pour récupérer le txt e nfonction de la langue
    # Définir le chemin du fichier 'FR.GetDriver'
    # Celon la langue céléctionner dans le fichier Version elle cera récupérée
    $destinationFilePath = "FR.GetDriver"

    # Lire le contenu du fichier 'FR.GetDriver'
    $scriptContent = Get-Content -Path $destinationFilePath

    # Créer un tableau pour stocker les variables et leur contenu
    $variablesAndContent = @()

    # Parcourir chaque ligne du fichier 'FR.GetDriver'
    foreach ($line in $scriptContent) {
        if ($line -match '^(.*?)([A-Za-z0-9]+);(.*)$') {
            $variableName = $matches[2]
            $variableValue = $matches[3].Trim()
            $variableObject = [PSCustomObject]@{
                Name = $variableName
                Value = $variableValue
            }
            $variablesAndContent += $variableObject
        }
    }

    # Définir les variables globales et les stocker dans un tableau
    $variableList = @()
    $variablesAndContent | ForEach-Object {
        New-Variable -Name $_.Name -Value $_.Value -Scope Global
        # Ajouter la variable au tableau
        $variableList += $_.Name
    }

    # Créer les variables dynamiquement
    $i = 0
    foreach ($txt in $variableList) {
        $variableName = "text$i"
        $variableValue = Get-Variable -Name $txt -ValueOnly
        New-Variable -Name $variableName -Value $variableValue -Scope Script
        $i++
    }

    # $variableList contien la list de variable récupérer

    # Les variables $text'x-y' contiènderon le txt a afficher
}
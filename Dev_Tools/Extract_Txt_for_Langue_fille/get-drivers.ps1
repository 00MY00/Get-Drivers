################################
# Crée par : Kuroakashiro
################################
# Verssion : 0.1.1
###################################################################################
# FUNCTION

############
#    Comment ajouter du nouveau TXT
# Pour ajouter du txt utiliser une éditeur de txt qui numerote les ligne 
# utiliser les variable txtX pour vous cituer par aport au code et au txt 
# Ajouter votre ligne de txt dans le fichier langue voulu a la bonne ligne atention chiffre -1 car début a 0
# Copier votre nouveau script dans le répertoir ou ce trouve 'Chang_zon_txt_en_variavle.ps1'
# utiliser l'outil 'Chang_zon_txt_en_variavle.ps1' pour réapliquer les variable txtX
# Attention rinitialise les tabulation
###############################################################################################################

function RecuperationLangue() {     # Fonction pour récupérer le txt e nfonction de la langue


    $LangDirectory = ".\Lang\"
    $DriverFile = ".\Lang.GetDriver"

    # Vérifier si le répertoire '.\Lang' existe, sinon le créer
    if (-not (Test-Path $LangDirectory -PathType Container)) {
        New-Item -Path $LangDirectory -ItemType Directory
    }

    # Récupérer la liste des fichiers dans le répertoire '.\Lang'
    $files = Get-ChildItem $LangDirectory | Where-Object { $_.PSIsContainer -eq $false }


    # Vérifier le nombre de fichiers dans le répertoire
    if ($files.Count -eq 1) {
        # S'il y a un seul fichier, récupérer son nom dans la variable $File
        $File = $files.Name
    }
    else {
        # Vérifier si le fichier 'Lang.GetDriver' existe
        if (Test-Path $DriverFile -PathType Leaf) {
            # Si le fichier existe, récupérer la première ligne du fichier
            $firstLine = Get-Content $DriverFile -TotalCount 1
            # Vérifier si le fichier mentionné dans 'Lang.GetDriver' existe dans le répertoire '.\Lang'
            if (Test-Path "$LangDirectory\$firstLine" -PathType Leaf) {
                $File = $firstLine
            }
            else {
                # Si le fichier mentionné dans 'Lang.GetDriver' n'existe pas dans le répertoire '.\Lang', prendre le premier fichier trouvé dans '.\Lang'
                $firstFile = $files[0].Name
                Set-Content -Path $DriverFile -Value $firstFile
                $File = $firstFile
            }
        }
        else {
            # Si le fichier 'Lang.GetDriver' n'existe pas, prendre le premier fichier trouvé dans '.\Lang'
            $firstFile = $files[0].Name
            Set-Content -Path $DriverFile -Value $firstFile
            $File = $firstFile
        }
    }

    # Définir le chemin du fichier 'FR.GetDriver'
    $destinationFilePath = Join-Path $LangDirectory $File

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

    # Supprimer les variables globales créées
    if ($variableList) {
        $variableList | ForEach-Object {
            Remove-Variable -Name $_ -Scope Global
        }
    }

    # Définir les variables globales et les stocker dans un tableau
    $variableList = @()
    $variablesAndContent | ForEach-Object {
        New-Variable -Name $_.Name -Value $_.Value -Scope Global -Force
        # Ajouter la variable au tableau
        $variableList += $_.Name
    }

    # Créer les variables dynamiquement
    $i = 0
    foreach ($txt in $variableList) {
        $variableName = "txt$i"
        $variableValue = Get-Variable -Name $txt -ValueOnly
        New-Variable -Name $variableName -Value $variableValue -Scope Script
        $i++
    }

    # $variableList contient la liste des variables récupérées
    # Les variables $text'x-y' contiendront le texte à afficher
}

######################

function Lang($Str) {
    # Ci $Str contien du txt verifit ci possible et verifit ci la langue exist
    # Cinon affiche une list des langue trouvée

    if ($Str) {
        # la variable $Str contient du texte
        $FichierLangTrouvez = Get-ChildItem -Path ".\Lang" | Where-Object { $_.Name.Substring(0,2) -eq $Str.ToUpper() }
        $FichierLangTrouvez = $FichierLangTrouvez.Name
        $FichierLang = ".\Lang.GetDriver"

        if ($FichierLangTrouvez) {
            try {
                Set-Content -Path $FichierLang -Value $FichierLangTrouvez -Encoding UTF8    # Change de langue
                $FichierLangTrouvez = $FichierLangTrouvez.Substring(0,2)
                Write-Host $ExecutionContext.InvokeCommand.ExpandString("$txt0") -ForegroundColor Green
            } catch {
                Write-Host $ExecutionContext.InvokeCommand.ExpandString("$txt1") -ForegroundColor Red
            }
        } else {
            Write-Host $ExecutionContext.InvokeCommand.ExpandString("$txt2") -ForegroundColor Red
            $FichierLangTrouvez = Get-ChildItem -Path ".\Lang"
            $FichierLangTrouvez = $FichierLangTrouvez.Name.Substring(0,2)
            Write-Host $ExecutionContext.InvokeCommand.ExpandString("$txt3") -ForegroundColor Magenta
            Write-Host $ExecutionContext.InvokeCommand.ExpandString("$txt4") -ForegroundColor Yellow 
            foreach ($lang in $FichierLangTrouvez) {
                Write-Host $ExecutionContext.InvokeCommand.ExpandString("$txt5") -NoNewline -ForegroundColor Magenta
                Write-Host $ExecutionContext.InvokeCommand.ExpandString("$txt6") -ForegroundColor Cyan
            }
            Write-Host $ExecutionContext.InvokeCommand.ExpandString("$txt7") -ForegroundColor Magenta
        }
    } else {
        $FichierLangTrouvez = Get-ChildItem -Path ".\Lang"
        $FichierLangTrouvez = $FichierLangTrouvez.Name.Substring(0,2)
        Write-Host "---------------" -ForegroundColor Magenta
        Write-Host "Langue disponible :" -ForegroundColor Yellow 
        foreach ($lang in $FichierLangTrouvez) {
            Write-Host "►" -NoNewline -ForegroundColor Magenta
            Write-Host "$lang" -ForegroundColor Cyan
        }
        Write-Host "---------------" -ForegroundColor Magenta
    }


}

######################

function Help() {

    # _    _ ______ _      _____  
    #| |  | |  ____| |    |  __ \ 
    #| |__| | |__  | |    | |__) |
    #|  __  |  __| | |    |  ___/ 
    #| |  | | |____| |____| |     
    #|_|  |_|______|______|_|     
                             
    Write-Host ""
    Write-host $ExecutionContext.InvokeCommand.ExpandString("$txt8") -ForegroundColor Cyan
    Write-host $ExecutionContext.InvokeCommand.ExpandString("$txt9") -ForegroundColor Yellow
    Write-Host $ExecutionContext.InvokeCommand.ExpandString("$txt10")-ForegroundColor Magenta
    Write-Host $ExecutionContext.InvokeCommand.ExpandString("$txt11") -ForegroundColor Green
    Write-Host $ExecutionContext.InvokeCommand.ExpandString("$txt12") -ForegroundColor Yellow
    Write-Host $ExecutionContext.InvokeCommand.ExpandString("$txt13") -ForegroundColor Yellow
    Write-Host $ExecutionContext.InvokeCommand.ExpandString("$txt14") -ForegroundColor Yellow
    Write-Host $ExecutionContext.InvokeCommand.ExpandString("$txt15") -ForegroundColor Yellow
    Write-Host $ExecutionContext.InvokeCommand.ExpandString("$txt16") -ForegroundColor Yellow
    Write-Host $ExecutionContext.InvokeCommand.ExpandString("$txt17") -ForegroundColor Yellow
    Write-Host $ExecutionContext.InvokeCommand.ExpandString("$txt18") -ForegroundColor Yellow
    Write-Host $ExecutionContext.InvokeCommand.ExpandString("$txt19") -ForegroundColor Yellow
    Write-Host $ExecutionContext.InvokeCommand.ExpandString("$txt20") -ForegroundColor Yellow
    Write-Host $ExecutionContext.InvokeCommand.ExpandString("$txt21") -ForegroundColor Yellow
    Write-Host $ExecutionContext.InvokeCommand.ExpandString("$txt22") -ForegroundColor Yellow
    Write-Host ""
    Write-Host ""
    Write-Host $ExecutionContext.InvokeCommand.ExpandString("$txt23") -ForegroundColor Cyan
    Write-Host $ExecutionContext.InvokeCommand.ExpandString("$txt24") -ForegroundColor Green
    Write-Host $ExecutionContext.InvokeCommand.ExpandString("$txt25") -ForegroundColor Yellow
    Write-Host $ExecutionContext.InvokeCommand.ExpandString("$txt26") -ForegroundColor Yellow
    Write-Host $ExecutionContext.InvokeCommand.ExpandString("$txt27") -ForegroundColor Yellow
    Write-Host $ExecutionContext.InvokeCommand.ExpandString("$txt28") -ForegroundColor Yellow
    Write-Host $ExecutionContext.InvokeCommand.ExpandString("$txt29") -ForegroundColor Yellow
    Write-Host ""
    Write-Host ""
    Write-host $ExecutionContext.InvokeCommand.ExpandString("$txt30") -ForegroundColor Cyan

} 
######################

function serch($Str) {      # Permet de rechercher un des driver corespondant au String entré
    Write-Host $ExecutionContext.InvokeCommand.ExpandString("$txt31") -NoNewline -ForegroundColor Yellow
    Write-Host $ExecutionContext.InvokeCommand.ExpandString("$txt32") -ForegroundColor Cyan

    if ($Str -eq "help") {
        Write-Host ""
        Write-host $ExecutionContext.InvokeCommand.ExpandString("$txt33") -ForegroundColor Cyan
        Write-host $ExecutionContext.InvokeCommand.ExpandString("$txt34") -ForegroundColor Yellow
        Write-Host $ExecutionContext.InvokeCommand.ExpandString("$txt35")-ForegroundColor Magenta
        Write-Host $ExecutionContext.InvokeCommand.ExpandString("$txt36") -ForegroundColor Green
        Write-Host $ExecutionContext.InvokeCommand.ExpandString("$txt37") -ForegroundColor Yellow
        Write-Host $ExecutionContext.InvokeCommand.ExpandString("$txt38") -ForegroundColor Green
        Write-Host $ExecutionContext.InvokeCommand.ExpandString("$txt39") -ForegroundColor Yellow
        Write-Host $ExecutionContext.InvokeCommand.ExpandString("$txt40") -ForegroundColor Green
        Write-Host $ExecutionContext.InvokeCommand.ExpandString("$txt41") -ForegroundColor Yellow
        Write-Host $ExecutionContext.InvokeCommand.ExpandString("$txt42") -ForegroundColor Yellow
        Write-host $ExecutionContext.InvokeCommand.ExpandString("$txt43") -ForegroundColor Cyan
        exit(0)
    }

    # Verifit ci il y a des '+' permetent d'afiner la recherche

    # Vérifier si la variable contient le signe '+'
    if ($Str -match '\+') {
        # Si le signe '+' est présent, récupérer chaque mot dans une liste en utilisant le caractère '+' comme séparateur
        $listeMots = $Str -split '\+'
        
        # Charger le contenu du fichier dans une variable
        $ContenuFichier = @(Get-Content -Path ".\list.GetDriver")

        $lignesTrouvees = @()

        # Parcourir chaque ligne du fichier
        foreach ($ligne in $ContenuFichier) {
            # Vérifier si la ligne contient tous les mots de la liste
            $tousLesMotsPresent = $true
            foreach ($mot in $listeMots) {
                if ($ligne -notmatch $mot) {
                    $tousLesMotsPresent = $false
                    break
                }
            }

            # Si tous les mots de la liste sont présents sur la ligne, ajouter la ligne à la liste des lignes trouvées
            if ($tousLesMotsPresent) {
                $lignesTrouvees += $ligne
            }
        }


        if (-not ($lignesTrouvees -eq "")) {
            Write-Host $ExecutionContext.InvokeCommand.ExpandString("$txt44")  -ForegroundColor Green
            foreach ($txt in $lignesTrouvees) {     # Affichage du contenu trouvée+
                Write-Host $ExecutionContext.InvokeCommand.ExpandString("$txt45") -NoNewline -ForegroundColor Yellow
                Write-Host $ExecutionContext.InvokeCommand.ExpandString("$txt46") -NoNewline -ForegroundColor Cyan
                Write-Host $ExecutionContext.InvokeCommand.ExpandString("$txt47") -ForegroundColor Yellow
            }
        } else {
            Write-Host $ExecutionContext.InvokeCommand.ExpandString("$txt48") -ForegroundColor Red
        }

    } else {
        #"La variable ne contient pas le signe '+'."
        # Recherche dans le fichier 'list.GetDriver' qui contien tous les chemin des driveur
        try {
            $ContenuFichier = @(Get-Content -Path ".\list.GetDriver" | Select-String -Pattern "$Str" | ForEach-Object { $_.Line })
        } catch {
            Write-Host $ExecutionContext.InvokeCommand.ExpandString("$txt49") -ForegroundColor Red
            exit(1)
        }

        if (-not ($contenuFichier -eq "")) {
            Write-Host $ExecutionContext.InvokeCommand.ExpandString("$txt50")  -ForegroundColor Green
            foreach ($txt in $ContenuFichier) {     # Affichage du contenu trouvée+
                Write-Host $ExecutionContext.InvokeCommand.ExpandString("$txt51") -NoNewline -ForegroundColor Yellow
                Write-Host $ExecutionContext.InvokeCommand.ExpandString("$txt52") -NoNewline -ForegroundColor Cyan
                Write-Host $ExecutionContext.InvokeCommand.ExpandString("$txt53") -ForegroundColor Yellow
            }
        } else {
            Write-Host $ExecutionContext.InvokeCommand.ExpandString("$txt54") -ForegroundColor Red
        }
        
    }

    # Découpage pour récupérer just le nom du driveur

}
######################

function update() {
    $cheminDossier = @(".\Drivers") # Spécifiez les dossiers cibles

    # Le texte pour identifier le début du chemin recherché
    $start = "\Drivers"

    # Chemin du fichier texte contenant les noms des fichiers
    $cheminFichierTxt = ".\list.GetDriver"

    # Vérifie si les dossiers existent
    if (-not (Test-Path $cheminDossier)) {
        Write-Host $ExecutionContext.InvokeCommand.ExpandString("$txt55") -ForegroundColor Red
        exit 1
    }

    # Vérifie si le fichier existe, sinon le crée avec une entête spécifique
    if (-not (Test-Path $cheminFichierTxt)) {
        Write-Host $ExecutionContext.InvokeCommand.ExpandString("$txt56") -ForegroundColor Red
        try {
            "# Nomenclature ' Drivers/Fabricant/Drivername_URL'" | Out-File -FilePath $cheminFichierTxt -Force
            Write-Host $ExecutionContext.InvokeCommand.ExpandString("$txt57") -ForegroundColor Green
        } catch {
            Write-Host $ExecutionContext.InvokeCommand.ExpandString("$txt58") -ForegroundColor Red
            exit 1
        }
    } else {
        "# Nomenclature ' Drivers/Fabricant/Drivername_URL'" | Out-File -FilePath $cheminFichierTxt -Force
    }

    # récupère le nom des sous-dossiers de .\Drivers
    $nomsSousDossiers = (Get-ChildItem -Path $cheminDossier -Directory).Name

    $URLList = @()  # Créer une liste vide pour stocker les URLs trouvées

    foreach ($sousDossier in $nomsSousDossiers) {
        $cheminSousDossier = Join-Path -Path $cheminDossier -ChildPath $sousDossier
        $cheminUrlTxt = Join-Path -Path $cheminSousDossier -ChildPath "url.txt"

        if (Test-Path $cheminUrlTxt -PathType Leaf) {
            $contenuUrlTxt = Get-Content -Path $cheminUrlTxt
            $URLList += $contenuUrlTxt  # Ajouter les URLs à la liste
            foreach ($url in $URLList) {
                $Concatenation = "Drivers/$sousDossier/$url"
                try {
                    "$Concatenation" >> ".\list.GetDriverTMP"
                    Write-Host $ExecutionContext.InvokeCommand.ExpandString("$txt59") -NoNewline -ForegroundColor Yellow   # Affiche le travail
                    Write-Host $ExecutionContext.InvokeCommand.ExpandString("$txt60")                                  # Affiche le travail
                } catch {
                    Write-Host $ExecutionContext.InvokeCommand.ExpandString("$txt61")     
                }
            }
        } else {
            # Ne contient pas de url.txt
            $nomFichier = (Get-ChildItem -Path $cheminSousDossier -File).Name
            if ($nomFichier -ne $null) {
                $Concatenation = ".\Drivers\$sousDossier\$nomFichier"
                try {
                    "$Concatenation" >> ".\list.GetDriverTMP"
                    Write-Host $ExecutionContext.InvokeCommand.ExpandString("$txt62") -NoNewline -ForegroundColor Blue     # Affiche le travail
                    Write-Host $ExecutionContext.InvokeCommand.ExpandString("$txt63")                           # Affiche le travail
                } catch {
                    Write-Host $ExecutionContext.InvokeCommand.ExpandString("$txt64")     
                }
            }
        }
    }

    # Chemin vers le fichier texte contenant les doublons (list.GetDriver)
    $cheminFichier = ".\list.GetDriver"

    # Lire le contenu du fichier en tant que tableau de lignes
    $contenuExistant = Get-Content -Path $cheminFichier

    # Lire le contenu du fichier en tant que tableau de lignes uniques
    $contenuUnique = $contenuExistant | Get-Unique

    # Filtrer les lignes ne commençant pas par '#' et les ajouter au fichier temporaire (list.GetDriverTMP)
    $contenuUnique | Where-Object { $_ -notlike "#*" } | ForEach-Object {
        $_ | Add-Content -Path ".\list.GetDriverTMP" -Encoding UTF8
    }

    # Vérifier si le fichier temporaire list.GetDriverTMP existe
    if (Test-Path ".\list.GetDriverTMP") {
        try {
            # Supprimer l'ancien fichier list.GetDriver
            Remove-Item ".\list.GetDriver" -ErrorAction Stop

            # Renommer le fichier temporaire en list.GetDriver
            Rename-Item -Path ".\list.GetDriverTMP" -NewName ".\list.GetDriver" -ErrorAction Stop
        } catch {
            Write-Host $ExecutionContext.InvokeCommand.ExpandString("$txt65") -ForegroundColor Red
        }
    }
}

######################

function list($Str) {   # Permet d'afficher grosièrement le contenu de la liste 

    # Les code couleur du caractère '►' Magenta = pas de filtre Blue fichier Driveur installer Yellow url de télécharement du driveur  cyant pour afficher le nombre de driveur


    if ($Str -eq "help") {
        Write-Host ""
        Write-host $ExecutionContext.InvokeCommand.ExpandString("$txt66") -ForegroundColor Cyan
        Write-host $ExecutionContext.InvokeCommand.ExpandString("$txt67") -ForegroundColor Yellow
        Write-Host $ExecutionContext.InvokeCommand.ExpandString("$txt68")-ForegroundColor Magenta
        Write-Host $ExecutionContext.InvokeCommand.ExpandString("$txt69") -ForegroundColor Green
        Write-Host $ExecutionContext.InvokeCommand.ExpandString("$txt70") -ForegroundColor Yellow
        Write-Host $ExecutionContext.InvokeCommand.ExpandString("$txt71") -ForegroundColor Green
        Write-Host $ExecutionContext.InvokeCommand.ExpandString("$txt72") -ForegroundColor Yellow
        Write-Host $ExecutionContext.InvokeCommand.ExpandString("$txt73") -ForegroundColor Yellow
        Write-Host $ExecutionContext.InvokeCommand.ExpandString("$txt74") -ForegroundColor Yellow
        Write-Host $ExecutionContext.InvokeCommand.ExpandString("$txt75") -ForegroundColor Green
        Write-Host $ExecutionContext.InvokeCommand.ExpandString("$txt76") -ForegroundColor Yellow
        Write-Host $ExecutionContext.InvokeCommand.ExpandString("$txt77") -ForegroundColor Yellow
        Write-Host $ExecutionContext.InvokeCommand.ExpandString("$txt78") -ForegroundColor Yellow
        Write-host $ExecutionContext.InvokeCommand.ExpandString("$txt79") -ForegroundColor Cyan
        exit(0)
    }




    $cheminFichierTxt = ".\list.GetDriver"  # Spécifiez le chemin du fichier texte

    $contenuFichier = Get-Content -Path $cheminFichierTxt

    if ($Str -eq "nourl") {
        foreach ($ligne in $contenuFichier) {
            # Vérifie si la ligne ne contient pas le mot "http"
            if ($ligne -notmatch "http.*") {
                Write-Host $ExecutionContext.InvokeCommand.ExpandString("$txt80") -NoNewline -ForegroundColor Blue
                Write-Host $ExecutionContext.InvokeCommand.ExpandString("$txt81")
                }
        }
        exit(0)
    }
    if ($Str -eq "tt"){         # Permet de compter le nombre de drivers dans la list
        $nombreLignes = (Get-Content $cheminFichierTxt).Count - 1       # Totale ligne -1

        $contenuFichier = Get-Content $cheminFichierTxt
        $nombreLignesSansHttp = $contenuFichier | Where-Object { $_ -notmatch "http" } | Measure-Object | Select-Object -ExpandProperty Count   # NB en local

        $nombreLignesAvecHttp = $contenuFichier | Where-Object { $_ -match "http" } | Measure-Object | Select-Object -ExpandProperty Count      # NB lien URLs 



        Write-Host $ExecutionContext.InvokeCommand.ExpandString("$txt82") -NoNewline -ForegroundColor Cyan
        Write-Host $ExecutionContext.InvokeCommand.ExpandString("$txt83") -NoNewline -ForegroundColor Yellow
        Write-Host $ExecutionContext.InvokeCommand.ExpandString("$txt84")
        Write-Host $ExecutionContext.InvokeCommand.ExpandString("$txt85") -NoNewline -ForegroundColor Cyan
        Write-Host $ExecutionContext.InvokeCommand.ExpandString("$txt86") -NoNewline -ForegroundColor Yellow
        Write-Host $ExecutionContext.InvokeCommand.ExpandString("$txt87")
        Write-Host $ExecutionContext.InvokeCommand.ExpandString("$txt88") -NoNewline -ForegroundColor Cyan
        Write-Host $ExecutionContext.InvokeCommand.ExpandString("$txt89") -NoNewline -ForegroundColor Yellow
        Write-Host $ExecutionContext.InvokeCommand.ExpandString("$txt90")
        exit(0)
    } else {

        if ($Str -eq "url") {   # Permet d'afficher selement les url et a partire des urls
            foreach ($ligne in $contenuFichier) {
                # Utilisation d'une expression régulière pour rechercher les liens qui commencent par "http" et se terminent par "'"
                $lienTrouve = $ligne | Select-String -Pattern "http.*'" -AllMatches | ForEach-Object { $_.Matches.Value }

                # Votre code à exécuter pour chaque lien trouvé
                foreach ($lien in $lienTrouve) {
                    Write-Host $ExecutionContext.InvokeCommand.ExpandString("$txt91") -NoNewline -ForegroundColor Yellow
                    Write-Host $ExecutionContext.InvokeCommand.ExpandString("$txt92")
                }
            }
            exit(0)
        } else {    # Ci pas de paramètre ajouter affiche la totalitée

            foreach ($ligne in $contenuFichier) {
                $indexDossier2 = $ligne.IndexOf("Drivers")
                # Votre code à exécuter pour chaque ligne du fichier
                if ($indexDossier2 -ge 0) {
                    $contenuApresDossier2 = $ligne.Substring($indexDossier2 + 8)
                    Write-Host $ExecutionContext.InvokeCommand.ExpandString("$txt93") -NoNewline -ForegroundColor Magenta
                    Write-Host $ExecutionContext.InvokeCommand.ExpandString("$txt94")
                }
            }
            Write-Host ""
            exit(0)
        }
    }

}
######################

function  install($Str) {

    if ($Str -eq "help") {
        Write-Host ""
        Write-host $ExecutionContext.InvokeCommand.ExpandString("$txt95") -ForegroundColor Cyan
        Write-host $ExecutionContext.InvokeCommand.ExpandString("$txt96") -ForegroundColor Yellow
        Write-Host $ExecutionContext.InvokeCommand.ExpandString("$txt97")-ForegroundColor Magenta
        Write-Host $ExecutionContext.InvokeCommand.ExpandString("$txt98") -ForegroundColor Green
        Write-Host $ExecutionContext.InvokeCommand.ExpandString("$txt99") -ForegroundColor Yellow
        Write-Host $ExecutionContext.InvokeCommand.ExpandString("$txt100") -ForegroundColor Green
        Write-Host $ExecutionContext.InvokeCommand.ExpandString("$txt101") -ForegroundColor Yellow
        Write-Host $ExecutionContext.InvokeCommand.ExpandString("$txt102") -ForegroundColor Green
        Write-Host $ExecutionContext.InvokeCommand.ExpandString("$txt103") -ForegroundColor Yellow
        Write-Host $ExecutionContext.InvokeCommand.ExpandString("$txt104") -ForegroundColor Yellow
        Write-Host $ExecutionContext.InvokeCommand.ExpandString("$txt105") -ForegroundColor Yellow
        Write-Host $ExecutionContext.InvokeCommand.ExpandString("$txt106") -ForegroundColor Yellow
        Write-host $ExecutionContext.InvokeCommand.ExpandString("$txt107") -ForegroundColor Cyan
        exit(0)
    }
    
    function installLocal($ContenuFichier) {   # Permet de télécharger des Driveur télécharger dans la list Drivers

        $ContenuFichier = $ContenuFichier -replace '\\\\', '\'          # Changement du '\' simple en doublée

        # Le chemin récupéré contin deux foi le nom du fichier a executer ces command permet de retirer ce qui ce trouve a la fien de la première términeson
        $extantion = extantion($ContenuFichier)
        $contenuFichier = $contenuFichier.Substring(0, $contenuFichier.IndexOf($extantion) + $extantion.Length)

        Write-Host $ExecutionContext.InvokeCommand.ExpandString("$txt108")

        if (-not (Test-Path "$ContenuFichier")) {
            Write-Host $ExecutionContext.InvokeCommand.ExpandString("$txt109") -ForegroundColor Red
            Write-Host $ExecutionContext.InvokeCommand.ExpandString("$txt110") -ForegroundColor Red
            exit(1)
        }
        

        if ($extantion -eq ".msi") {        # Tester ci les erreur sont bin détecter car la dernière option est toujour choisit plus l'affichage d'erreur

            $installOptions = "/qn"
            $process = Start-Process -FilePath "$ContenuFichier" -ArgumentList "/i", "`"$msiFile`"", $installOptions -Wait -PassThru
            
            if ($process.ExitCode -eq 0) {
                Write-Host $ExecutionContext.InvokeCommand.ExpandString("$txt111") -ForegroundColor Green
            } else {
                $installOptions = "/quiet"
                Write-Host $ExecutionContext.InvokeCommand.ExpandString("$txt112") -ForegroundColor Red
                $process = Start-Process -FilePath "$ContenuFichier" -ArgumentList "/i", "`"$msiFile`"", $installOptions -Wait -PassThru
            } 
            if (-not ($process.ExitCode -eq 0)) {
                Write-Host $ExecutionContext.InvokeCommand.ExpandString("$txt113") -ForegroundColor Red
                try {
                    $process = Start-Process -FilePath "$ContenuFichier" -Wait -PassThru
                    if ($process.ExitCode -eq 0) {
                        Write-Host $ExecutionContext.InvokeCommand.ExpandString("$txt114") -ForegroundColor Green
                    }
                    exit(0)
                } catch {
                    Write-Host $ExecutionContext.InvokeCommand.ExpandString("$txt115") -ForegroundColor Red
                    exit(1)
                }
            }
        }
     

        if ($extantion -eq ".exe") {
            try {
                Start-Process -FilePath "$ContenuFichier"
                exit(0)
            } catch {
                Write-Host $ExecutionContext.InvokeCommand.ExpandString("$txt116") -ForegroundColor Red
                try {
                    Start-Process -FilePath "$ContenuFichier"
                    Write-Host $ExecutionContext.InvokeCommand.ExpandString("$txt117") -ForegroundColor Green
                    exit(1)
                } catch {
                    Write-Host $ExecutionContext.InvokeCommand.ExpandString("$txt118") -ForegroundColor Red
                    exit(2)
                }
            }
        }

        if ($extantion -eq ".zip") {    # ZIP

            # Amodifi pour fonctionner avec le mode local
            exit(111)   # Stop code non términer


            if (-not (Test-Path ".\Download")) {
                New-Item -ItemType Directory -Path ".\Download"
                Write-Host $ExecutionContext.InvokeCommand.ExpandString("$txt119") -ForegroundColor Yellow
            }


            # Retirer la termineson .zip au $NomFichier
            $DossierZip = $NomFichier.Split('.')[0]

            try {
                Expand-Archive -Path $cheminFichier -DestinationPath ".\Download\$DossierZip"
            } catch {
                Write-Host $ExecutionContext.InvokeCommand.ExpandString("$txt120") -ForegroundColor Red
            }

            try {
                Remove-Item "$cheminFichier" -Force
            } catch {
                Write-Host $ExecutionContext.InvokeCommand.ExpandString("$txt121") -ForegroundColor Red
            }

            
            $DossierZip = ".\Download\$DossierZip"

            # Aller dans le nouveau dossier et verifier le contenu
            # Recherche des fichiers .exe et .msi dans le dossier spécifié
            $exeFiles = Get-ChildItem -Path $DossierZip -Filter "*.exe" -File
            $msiFiles = Get-ChildItem -Path $DossierZip -Filter "*.msi" -File
            $batFile = Get-ChildItem -Path $DossierZip -Filter "Silent_Install.bat" -File

            if ($exeFiles.Count -eq 0 -and $msiFiles.Count -eq 0) {
                # Aucun fichier exe ou msi trouvé, ouvrir le dossier
                Invoke-Item -Path $DossierZip
            } else {
                $heaviestExe = $exeFiles | Sort-Object -Property Length -Descending | Select-Object -First 1
                $heaviestMsi = $msiFiles | Sort-Object -Property Length -Descending | Select-Object -First 1

                if ($batFile) {
                    # Exécution du fichier Silent_Install.bat s'il existe           # Ci il exist probablement le Uninstalle aussi !
                    try {
                        Start-Process -FilePath $batFile.FullName -Wait
                        Write-Host $ExecutionContext.InvokeCommand.ExpandString("$txt122") -ForegroundColor Green
                    } catch {
                        Write-Host $ExecutionContext.InvokeCommand.ExpandString("$txt123") -ForegroundColor Red
                    }
                } elseif ($heaviestExe -and $heaviestMsi) {
                    # Exécution du fichier exe ou msi le plus lourd
                    if ($heaviestExe.Length -gt $heaviestMsi.Length) {
                        try {
                            Start-Process -FilePath $heaviestExe.FullName -Wait
                            Write-Host $ExecutionContext.InvokeCommand.ExpandString("$txt124") -ForegroundColor Green
                        }   catch {
                        Write-Host $ExecutionContext.InvokeCommand.ExpandString("$txt125") -ForegroundColor Red
                        }
                    } else {
                        try {
                            Start-Process -FilePath $heaviestMsi.FullName -Wait
                            Write-Host $ExecutionContext.InvokeCommand.ExpandString("$txt126") -ForegroundColor Green
                        } catch {
                        Write-Host $ExecutionContext.InvokeCommand.ExpandString("$txt127") -ForegroundColor Red
                    }
                    }
                } elseif ($heaviestExe) {
                    # Exécution du fichier exe s'il existe
                    try {
                        Start-Process -FilePath $heaviestExe.FullName -Wait
                        Write-Host $ExecutionContext.InvokeCommand.ExpandString("$txt128") -ForegroundColor Green
                    } catch {
                        Write-Host $ExecutionContext.InvokeCommand.ExpandString("$txt129") -ForegroundColor Red
                    }
                } elseif ($heaviestMsi) {
                    # Exécution du fichier msi s'il existe
                    try {
                        Start-Process -FilePath $heaviestMsi.FullName -Wait
                        Write-Host $ExecutionContext.InvokeCommand.ExpandString("$txt130") -ForegroundColor Green
                    } catch {
                        Write-Host $ExecutionContext.InvokeCommand.ExpandString("$txt131") -ForegroundColor Red
                    }
                }
            }

            # Supression de l'arrichive décompresser 
            try {
                Remove-Item "$DossierZip" -Force
            } catch {
                Write-Host $ExecutionContext.InvokeCommand.ExpandString("$txt132") -ForegroundColor Red
            }

        } 



    }   ####################







    function extantion($URL) {
        # en entrée l'url en sortile l'extantion du fichier
        $extension = [System.IO.Path]::GetExtension($URL)
        Write-Host $ExecutionContext.InvokeCommand.ExpandString("$txt133") -ForegroundColor Yellow
        return $extension
    }


    function installURL($ContenuFichier) {
        # Récupération de l'URL et téléchargement
        
        # Utilisation d'une expression régulière pour extraire le texte après 'uttp'
        $URL = $ContenuFichier | Select-String -Pattern 'http.*' -AllMatches | ForEach-Object { $_.Matches.Value }
        $NomFichier = Split-Path -Path $URL -Leaf

        if (-not (Test-Path ".\Download\$NomFichier")) {
            Write-Host $ExecutionContext.InvokeCommand.ExpandString("$txt134") -NoNewline -ForegroundColor Yellow
            try {
                Invoke-WebRequest -Uri "$URL" -OutFile ".\Download\$NomFichier" 
                Write-Host $ExecutionContext.InvokeCommand.ExpandString("$txt135") -ForegroundColor Green
            } catch {
                Write-Host $ExecutionContext.InvokeCommand.ExpandString("$txt136") -ForegroundColor Red
                exit(1)
            }
        }


        # Détecter le format du fichier
        $extantion = extantion($URL)
        
        # Chemin de téléchargement
        $cheminFichier = ".\Download\$NomFichier"

        if ($extantion -eq ".exe") {    # EXE
            try {
                Start-Process -FilePath $cheminFichier -Wait
                Write-Host $ExecutionContext.InvokeCommand.ExpandString("$txt137") -ForegroundColor Green
                Remove-Item $cheminFichier -Force  # Suppression du fichier
                Write-Host $ExecutionContext.InvokeCommand.ExpandString("$txt138") -ForegroundColor Green
                exit 0
            } catch {
                Write-Host $ExecutionContext.InvokeCommand.ExpandString("$txt139") -ForegroundColor Red
                exit 1
            }
        }


        if ($extantion -eq ".msi") {    # MSI
            # 
        }
        
        if ($extantion -eq ".bin") {    # BIN
            #
        }

        if ($extantion -eq ".zip") {    # ZIP

            if (-not (Test-Path ".\Download")) {
                New-Item -ItemType Directory -Path ".\Download"
                Write-Host $ExecutionContext.InvokeCommand.ExpandString("$txt140") -ForegroundColor Yellow
            }


            # Retirer la termineson .zip au $NomFichier
            $DossierZip = $NomFichier.Split('.')[0]

            try {
                Expand-Archive -Path $cheminFichier -DestinationPath ".\Download\$DossierZip"
            } catch {
                Write-Host $ExecutionContext.InvokeCommand.ExpandString("$txt141") -ForegroundColor Red
            }

            try {
                Remove-Item "$cheminFichier" -Force
            } catch {
                Write-Host $ExecutionContext.InvokeCommand.ExpandString("$txt142") -ForegroundColor Red
            }

            
            $DossierZip = ".\Download\$DossierZip"

            # Aller dans le nouveau dossier et verifier le contenu
            # Recherche des fichiers .exe et .msi dans le dossier spécifié
            $exeFiles = Get-ChildItem -Path $DossierZip -Filter "*.exe" -File
            $msiFiles = Get-ChildItem -Path $DossierZip -Filter "*.msi" -File
            $batFile = Get-ChildItem -Path $DossierZip -Filter "Silent_Install.bat" -File

            if ($exeFiles.Count -eq 0 -and $msiFiles.Count -eq 0) {
                # Aucun fichier exe ou msi trouvé, ouvrir le dossier
                Invoke-Item -Path $DossierZip
            } else {
                $heaviestExe = $exeFiles | Sort-Object -Property Length -Descending | Select-Object -First 1
                $heaviestMsi = $msiFiles | Sort-Object -Property Length -Descending | Select-Object -First 1

                if ($batFile) {
                    # Exécution du fichier Silent_Install.bat s'il existe           # Ci il exist probablement le Uninstalle aussi !
                    try {
                        Start-Process -FilePath $batFile.FullName -Wait
                        Write-Host $ExecutionContext.InvokeCommand.ExpandString("$txt143") -ForegroundColor Green
                    } catch {
                        Write-Host $ExecutionContext.InvokeCommand.ExpandString("$txt144") -ForegroundColor Red
                    }
                } elseif ($heaviestExe -and $heaviestMsi) {
                    # Exécution du fichier exe ou msi le plus lourd
                    if ($heaviestExe.Length -gt $heaviestMsi.Length) {
                        try {
                            Start-Process -FilePath $heaviestExe.FullName -Wait
                            Write-Host $ExecutionContext.InvokeCommand.ExpandString("$txt145") -ForegroundColor Green
                        }   catch {
                        Write-Host $ExecutionContext.InvokeCommand.ExpandString("$txt146") -ForegroundColor Red
                        }
                    } else {
                        try {
                            Start-Process -FilePath $heaviestMsi.FullName -Wait
                            Write-Host $ExecutionContext.InvokeCommand.ExpandString("$txt147") -ForegroundColor Green
                        } catch {
                        Write-Host $ExecutionContext.InvokeCommand.ExpandString("$txt148") -ForegroundColor Red
                    }
                    }
                } elseif ($heaviestExe) {
                    # Exécution du fichier exe s'il existe
                    try {
                        Start-Process -FilePath $heaviestExe.FullName -Wait
                        Write-Host $ExecutionContext.InvokeCommand.ExpandString("$txt149") -ForegroundColor Green
                    } catch {
                        Write-Host $ExecutionContext.InvokeCommand.ExpandString("$txt150") -ForegroundColor Red
                    }
                } elseif ($heaviestMsi) {
                    # Exécution du fichier msi s'il existe
                    try {
                        Start-Process -FilePath $heaviestMsi.FullName -Wait
                        Write-Host $ExecutionContext.InvokeCommand.ExpandString("$txt151") -ForegroundColor Green
                    } catch {
                        Write-Host $ExecutionContext.InvokeCommand.ExpandString("$txt152") -ForegroundColor Red
                    }
                }
            }

            # Supression de l'arrichive décompresser 
            try {
                Remove-Item "$DossierZip" -Force
            } catch {
                Write-Host $ExecutionContext.InvokeCommand.ExpandString("$txt153") -ForegroundColor Red
            }
            
        }

    }

    ################################

    
    $ContenuFichier = Get-Content -Path ".\list.GetDriver" | Where-Object { $_ -match [regex]::Escape($Str) }
    $ContenuFichier = $ContenuFichier -replace "'", '' # Retire les apostrophes

    # Verifier ci plusieur Sortil corespond
    if ($ContenuFichier.Count -gt 1) {
        # "Le tableau contient plus d'une entrée."
        while ($True) {
            Write-Host $ExecutionContext.InvokeCommand.ExpandString("$txt154") -ForegroundColor Yellow
            $i = 0
            foreach ($chemin in $ContenuFichier) {
                Write-Host $ExecutionContext.InvokeCommand.ExpandString("$txt155")

                $i= $i + 1
                if ($i -gt 10) {break}
            }
            Write-Host $ExecutionContext.InvokeCommand.ExpandString("$txt156")
            $user = Read-host "-> "

            if ($user -eq "exit") {exit(0)}

            if ($user -gt 10) {
                Write-Host $ExecutionContext.InvokeCommand.ExpandString("$txt157") -ForegroundColor Red
            }
            if ($user -lt 0) {
                Write-Host $ExecutionContext.InvokeCommand.ExpandString("$txt158") -ForegroundColor Red
            }
            $ContenuFichier = $ContenuFichier[$user]
            #Write-Host "Séléction : '$ContenuFichier'"
            break
        }
    } else {
        # "Le tableau contient une seule entrée ou est vide."
        #Write-Host "Séléction : '$ContenuFichier'"
    }
    
    $ContenuFichier = $ContenuFichier -replace '\\', '\\'          # Changement du '\' simple en doublée
    

    Write-Host $ExecutionContext.InvokeCommand.ExpandString("$txt159")



    if ($ContenuFichier.Contains("\\")) {
        # Le mot rechercher contien des \ c'est probablement un Driveur local
        if (-not ($ContenuFichier.Contains("http"))) {
            # Le chemin n'est définitivement pas une url
            try {
                installLocal($ContenuFichier)   # Appel la fonction avec le nom du fichier choisit
            } catch {
                Write-Host $ExecutionContext.InvokeCommand.ExpandString("$txt160")
            }
        }
    } else {
        # C'est une URL a télécharger et installer
        if (-not($InternetAccessible)) {    # Verifit ci internet est accecible
            Write-Host $ExecutionContext.InvokeCommand.ExpandString("$txt161") -ForegroundColor Red
            exit(1)
        }
        installURL($ContenuFichier)
    }



}
######################

function mydr() {       # Ajouter une valeur de choi de chause a afficher example -mydr "DeviceName" "Manufacturer"
    try {
        Get-WmiObject Win32_PnPSignedDriver | Select-Object DeviceName, Manufacturer, DriverVersion
    } catch {
        Write-Host $ExecutionContext.InvokeCommand.ExpandString("$txt162") -ForegroundColor Red
    }
}
######################

function upgrade($Str) {          # Permet de rechercher des drivers et avec la valeur apply elle sont ajoutée

    if ($Str -eq "help") {
        Write-Host ""
        Write-host $ExecutionContext.InvokeCommand.ExpandString("$txt163") -ForegroundColor Cyan
        Write-host $ExecutionContext.InvokeCommand.ExpandString("$txt164") -ForegroundColor Yellow
        Write-Host $ExecutionContext.InvokeCommand.ExpandString("$txt165")-ForegroundColor Magenta
        Write-Host $ExecutionContext.InvokeCommand.ExpandString("$txt166") -ForegroundColor Green
        Write-Host $ExecutionContext.InvokeCommand.ExpandString("$txt167") -ForegroundColor Yellow
        Write-Host $ExecutionContext.InvokeCommand.ExpandString("$txt168") -ForegroundColor Green
        Write-Host $ExecutionContext.InvokeCommand.ExpandString("$txt169") -ForegroundColor Yellow
        Write-Host $ExecutionContext.InvokeCommand.ExpandString("$txt170") -ForegroundColor Green
        Write-Host $ExecutionContext.InvokeCommand.ExpandString("$txt171") -ForegroundColor Yellow
        Write-Host $ExecutionContext.InvokeCommand.ExpandString("$txt172") -ForegroundColor Yellow
        Write-Host $ExecutionContext.InvokeCommand.ExpandString("$txt173") -ForegroundColor Yellow
        Write-Host $ExecutionContext.InvokeCommand.ExpandString("$txt174") -ForegroundColor Yellow
        Write-host $ExecutionContext.InvokeCommand.ExpandString("$txt175") -ForegroundColor Cyan
        exit(0)
    }

    function apply() {
        # Fonction pour nettoyer le nom du fichier en remplaçant les caractères spéciaux par des tirets
        function CleanFileName($fileName) {
            $invalidChars = [System.IO.Path]::GetInvalidFileNameChars() -join ''
            $cleanedName = $fileName -replace "[$invalidChars]", '-'
            return $cleanedName
        }

        # Chemin vers le fichier texte contenant les informations (Nouvel_List.txt)
        $cheminFichier = ".\Nouvel_List.txt"

        # Lire le contenu du fichier en tant que tableau de lignes
        $lignes = Get-Content -Path $cheminFichier

        # Utilisation d'une expression régulière pour extraire le nom du fichier et l'URL pour chaque ligne
        $patternNomFichier = "Nom du fichier : '(.+?)'"
        $patternURL = "URL : '(.+)"

        $index = 0
        while ($index -lt $lignes.Length) {
            $ligneNomFichier = $lignes[$index] | Select-String -Pattern $patternNomFichier
            $ligneURL = $lignes[$index + 1] | Select-String -Pattern $patternURL

            if ($ligneNomFichier -and $ligneURL) {
                $nomDuFichier = $ligneNomFichier.Matches.Groups[1].Value.Trim()
                $urlDuFichier = $ligneURL.Matches.Groups[1].Value.Trim()

                # Remplacer les espaces par des tirets dans le nom du fichier
                $nomDuFichier = $nomDuFichier -replace '\s', '-'

                # Nettoyer le nom du fichier pour supprimer les caractères spéciaux
                $nomDuFichier = CleanFileName $nomDuFichier

                # Créer le dossier avec le nom du fichier s'il n'existe pas déjà
                $dossierDestination = ".\Drivers\$nomDuFichier"
                if (-Not (Test-Path -Path $dossierDestination -PathType Container)) {
                    New-Item -ItemType Directory -Force -Path $dossierDestination
                }

                # Chemin du fichier texte contenant l'URL à l'intérieur du dossier
                $fichierTxt = Join-Path -Path $dossierDestination -ChildPath "url.txt"

                # Vérifier si le fichier "url.txt" existe déjà dans le dossier
                if (Test-Path -Path $fichierTxt -PathType Leaf) {
                    # Lire le contenu du fichier "url.txt"
                    $urlExistantes = Get-Content -Path $fichierTxt

                    # Vérifier si l'URL que nous voulons ajouter existe déjà dans le fichier
                    if ($urlExistantes -contains $urlDuFichier) {
                        Write-Host $ExecutionContext.InvokeCommand.ExpandString("$txt176")
                    }
                    else {
                        # Ajouter la nouvelle URL à la fin du fichier "url.txt"
                        $urlDuFichier | Add-Content -Path $fichierTxt -Encoding UTF8
                    }
                }
                else {
                    # Créer le fichier "url.txt" s'il n'existe pas et écrire l'URL à l'intérieur
                    $urlDuFichier | Out-File -FilePath $fichierTxt -Encoding UTF8
                }

                # Afficher les informations récupérées pour chaque ligne
                $informations = @{
                    "Nom du fichier" = $nomDuFichier
                    "URL" = $urlDuFichier
                }
                $informations

                # Augmenter l'index de 2 pour sauter à la prochaine paire de lignes
                $index += 2
            }
            else {
                # Si les deux lignes ne correspondent pas au modèle, passez à la ligne suivante
                $index++
            }
        }
    }
    #########
    if ($Str -eq "applyold") {      # ci le paramètre applyold install le fichier déja existant 
        if (Test-Path ".\Nouvel_List.txt") {
            try {
                apply
                exit(0)
            } catch {
                Write-Host $ExecutionContext.InvokeCommand.ExpandString("$txt177") -ForegroundColor Red
                exit(1)
            }
        } else {
            Write-Host $ExecutionContext.InvokeCommand.ExpandString("$txt178") -ForegroundColor Red
            Write-Host $ExecutionContext.InvokeCommand.ExpandString("$txt179") -ForegroundColor Yellow
            $Str = "apply"
        }
    }

    try {
        python --version > $null
        pip --version > $null
    } catch {
        Write-Host $ExecutionContext.InvokeCommand.ExpandString("$txt180") -ForegroundColor Red
        try {
            Start-Process -FilePath "powershell.exe" -ArgumentList "-File ""$destinationFolder\Get-Drivers\Install.ps1""" -Verb RunAs
        } catch {
            Write-Host $ExecutionContext.InvokeCommand.ExpandString("$txt181") -ForegroundColor Red
        }
    }

    Write-Host $ExecutionContext.InvokeCommand.ExpandString("$txt182") -NoNewline -ForegroundColor Yellow
    Write-Host $ExecutionContext.InvokeCommand.ExpandString("$txt183") -ForegroundColor Green

    if (Test-Path ".\Valid_Link.txt") {
        Remove-Item ".\Valid_Link.txt" -Force
    }
    if (Test-Path ".\Valid_Download_Link.txt") {
        Remove-Item ".\Valid_Download_Link.txt" -Force
    }
    if (Test-Path ".\Nouvel_List.txt") {
        Remove-Item ".\Nouvel_List.txt" -Force
    }
    if (Test-Path ".\ok.txt") {
        Remove-Item ".\ok.txt" -Force
    }

   # Chemin vers le script Python à exécuter
   $pythonScript = ".\Find_Drivers\Find_Link.py"

   # Exécute le script Python avec l'opérateur & et l'argument -Wait
   & Start-Process -FilePath "python" -ArgumentList $pythonScript -Wait
    
    # Attend que le processus Python soit terminé
    # Vérifier si le fichier "ok.txt" existe
    $filePath = ".\ok.txt"
    #while (-Not (Test-Path $filePath)) {
    #    Write-Host "Le fichier 'ok.txt' n'existe pas. En attente de sa création..."
    #    # Attendre 1 seconde avant de vérifier à nouveau
    #    Start-Sleep -Seconds 1
    #}

    if (Test-Path ".\ok.txt") {
        Remove-Item ".\ok.txt" -Force
    }
    if (Test-Path ".\Valid_Link.txt") {
        Remove-Item ".\Valid_Link.txt" -Force
    }
    if (Test-Path ".\Valid_Download_Link.txt") {
        Remove-Item ".\Valid_Download_Link.txt" -Force
    }

    if ($Str -eq "apply") {         # ajoute le nouveau fichier
        if (Test-Path ".\Nouvel_List.txt") {
            try {
                apply
                exit(0)
            } catch {
                Write-Host $ExecutionContext.InvokeCommand.ExpandString("$txt184") -ForegroundColor Red
            }
        }
    }
}
######################

function updateGit() {
    
    function UpdateGitVersion($Path) {
        if (-not ($Path -eq ".\Download\Version.GetDriver")) {
            if (-not (Test-Path "$Path")) {
                # Crée le fichier avec une valeur 0.0.1 pour forcer la mise à jour
                "Version 0.0.1" | Out-File -Encoding UTF8 -FilePath ".\Version.GetDriver"
            }
        }

        # Utilisation d'une expression régulière pour extraire la version dans le format "Version 0.0.1"
        $pattern = 'Version (\d+\.\d+\.\d+)'
        $version = Get-Content -Path $Path | Select-String -Pattern $pattern | ForEach-Object { [int]($_.Matches.Groups[1].Value -replace '\.') }

        # Extraction de la valeur numérique et suppression des '.' et des '0' avant le premier chiffre non '0'
        $versionNumerique = $version -replace '^0*|\.0*',''

        # Affichage de la version numérique
        return $versionNumerique
    }

    function UpdateGitDistantVersion() {
        # Récupère la version la plus récente de Get-Drivers sur git
        $VersionLocalDownload = ".\Download\Version.GetDriver"

        if (-not (Test-Path ".\Download")) {
            New-Item -ItemType Directory -Path ".\Download"
        }

        if (Test-Path $VersionLocalDownload) {
            Remove-Item $VersionLocalDownload -Force
        }

        # Télécharge le fichier depuis GitHub et attend la fin du téléchargement
        $url = "https://raw.githubusercontent.com/00MY00/Get-Drivers/main/Version.GetDriver"
        curl -o $VersionLocalDownload $url

        # Obtient la version du fichier téléchargé
        $Version = UpdateGitVersion($VersionLocalDownload)

        if (Test-Path $VersionLocalDownload) {
            Remove-Item $VersionLocalDownload -Force
        }

        return $Version
    }

    # récupération de la version locale
    try {
        $LocalVersion = UpdateGitVersion(".\Version.GetDriver")
    } catch {
        Write-Host $ExecutionContext.InvokeCommand.ExpandString("$txt185") -ForegroundColor Red
        exit(1)
    }

    try {
        $GitVersion = UpdateGitDistantVersion
    } catch {
        Write-Host $ExecutionContext.InvokeCommand.ExpandString("$txt186") -ForegroundColor Red
        exit(1)
    }

    if ($GitVersion -eq "") {$GitVersion = "X-Erreur"}
    if ($LocalVersion -eq "") {$GitVersion = "X-Erreur"}
    

    # Comparaison des versions
    if ($LocalVersion -lt $GitVersion) {
        Write-Host ""
        Write-Host $ExecutionContext.InvokeCommand.ExpandString("$txt187") -ForegroundColor Magenta
        Write-Host $ExecutionContext.InvokeCommand.ExpandString("$txt188")
        Write-Host $ExecutionContext.InvokeCommand.ExpandString("$txt189")
        Write-Host $ExecutionContext.InvokeCommand.ExpandString("$txt190") -NoNewline
        Write-Host $ExecutionContext.InvokeCommand.ExpandString("$txt191") -ForegroundColor Cyan
        Write-Host $ExecutionContext.InvokeCommand.ExpandString("$txt192") -NoNewline
        Write-Host $ExecutionContext.InvokeCommand.ExpandString("$txt193") -ForegroundColor Cyan
        Write-Host $ExecutionContext.InvokeCommand.ExpandString("$txt194") -ForegroundColor Magenta
        Write-Host ""
        $fileContent = Get-Content -Path ".\Version.GetDriver"
        if ($fileContent -match "Depasser") {
            # "Le mot 'Depasser' a été trouvé dans le fichier." ce mot permet de valider ci il faut apliquer le upgrdeGit ou non
        } else {
            " " >> ".\Version.GetDriver"
            "Depasser" | Out-File -Encoding UTF8 -Append ".\Version.GetDriver"
        }
    } else {
        Write-Host ""
        Write-Host $ExecutionContext.InvokeCommand.ExpandString("$txt195") -ForegroundColor Magenta
        Write-Host $ExecutionContext.InvokeCommand.ExpandString("$txt196")
        Write-Host $ExecutionContext.InvokeCommand.ExpandString("$txt197") -NoNewline
        Write-Host $ExecutionContext.InvokeCommand.ExpandString("$txt198") -ForegroundColor Cyan
        Write-Host $ExecutionContext.InvokeCommand.ExpandString("$txt199") -NoNewline
        Write-Host $ExecutionContext.InvokeCommand.ExpandString("$txt200") -ForegroundColor Cyan
        Write-Host $ExecutionContext.InvokeCommand.ExpandString("$txt201") -ForegroundColor Magenta
        Write-Host ""
    }



}
######################

function version($Path) {

    if ($Str -eq "help") {
        Write-Host ""
        Write-host $ExecutionContext.InvokeCommand.ExpandString("$txt202") -ForegroundColor Cyan
        Write-host $ExecutionContext.InvokeCommand.ExpandString("$txt203") -ForegroundColor Yellow
        Write-Host $ExecutionContext.InvokeCommand.ExpandString("$txt204")-ForegroundColor Magenta
        Write-Host $ExecutionContext.InvokeCommand.ExpandString("$txt205") -ForegroundColor Green
        Write-Host $ExecutionContext.InvokeCommand.ExpandString("$txt206") -ForegroundColor Yellow
        Write-Host $ExecutionContext.InvokeCommand.ExpandString("$txt207") -ForegroundColor Green
        Write-Host $ExecutionContext.InvokeCommand.ExpandString("$txt208") -ForegroundColor Yellow
        Write-Host $ExecutionContext.InvokeCommand.ExpandString("$txt209") -ForegroundColor Green
        Write-Host $ExecutionContext.InvokeCommand.ExpandString("$txt210") -ForegroundColor Yellow
        Write-Host $ExecutionContext.InvokeCommand.ExpandString("$txt211") -ForegroundColor Yellow
        Write-host $ExecutionContext.InvokeCommand.ExpandString("$txt212") -ForegroundColor Cyan
        exit(0)
    }
    # Récupère la version du fichier mis en paramètre
    $VersionLocal = Get-Content -Path $Path -ErrorAction SilentlyContinue

    if (-not $VersionLocal) {
        # Crée le fichier avec une valeur 0.0.1 pour forcer la mise à jour
        "Version 0.0.1" > $Path
        $VersionLocal = "Version 0.0.1"
    }

    # Utilisation d'une expression régulière pour extraire la version dans le format "Version 0.0.1"
    $pattern = 'Version (\d+\.\d+\.\d+)'
    $version = Get-Content -Path $Path | Select-String -Pattern $pattern | ForEach-Object { [int]($_.Matches.Groups[1].Value -replace '\.') }

    # Extraction de la valeur numérique et suppression des '.' et des '0' avant le premier chiffre non '0'
    $versionNumerique = $version -replace '^0*|\.0*',''

    # Affichage de la version numérique
    Write-Host $ExecutionContext.InvokeCommand.ExpandString("$txt213") -NoNewline -ForegroundColor Yellow
    Write-Host $ExecutionContext.InvokeCommand.ExpandString("$txt214") -ForegroundColor Cyan
}
######################

function upgradeGit() {         # Permet de metre à joure le programe

    $fileContent = Get-Content -Path ".\Version.GetDriver"
    if ($fileContent -match "Depasser") {
        # "Le mot 'Depasser' a été trouvé dans le fichier. Ce mot permet de valider ci il faut apliquer le upgrdeGit ou non
        if (-not (git --version 2>$null)) {
            # Erreur git n'est pas disponible 
            Start-Process -FilePath "powershell.exe" -ArgumentList "-File ""$destinationFolder\Get-Drivers\Install.ps1""" -Verb RunAs
            Write-Host $ExecutionContext.InvokeCommand.ExpandString("$txt215") -ForegroundColor Red
        }
        else {
            if (Test-Path ".\Download\Get-Drivers") {
                Remove-Item ".\Download\Get-Drivers" -Recurse -Force -Confirm:$false
            }
        
            # Création de Backup
            if (-not (Test-Path ".\Backup")) {
                New-Item -ItemType Directory -Path ".\Backup"
            } 
        
            try {
                Copy-Item -Path ".\*" -Destination ".\Backup" -Recurse -Force -Exclude (Split-Path ".\Backup" -Leaf)
                Write-Host $ExecutionContext.InvokeCommand.ExpandString("$txt216") -ForegroundColor Green
            } catch {
                Write-Host $ExecutionContext.InvokeCommand.ExpandString("$txt217") -ForegroundColor Red
                exit(1)
            }
        
            # Téléchargement de la nouvelle version disponible
            if (Test-Path ".\Download\Get-Drivers") {
                Remove-Item ".\Download\Get-Drivers" -Recurse -Force -Confirm:$false
            }
            if (Test-Path ".\.git") {Remove-Item ".\.git" -Recurse -Force -Confirm:$false }
            git clone "https://github.com/00MY00/Get-Drivers.git" ".\Download\Get-Drivers"
        
            # Appliquer la mise à jour. En cas d'échec, récupérer la sauvegarde.
            if (Test-Path ".\Download\Get-Drivers") {
                try {
                    Copy-Item -Path ".\Download\Get-Drivers\*" -Destination ".\" -Recurse -Force
                    Remove-Item ".\Backup" -Recurse -Force -Confirm:$false
                    if (Test-Path ".\.git") {Remove-Item ".\.git" -Recurse -Force -Confirm:$false }
                    Write-Host $ExecutionContext.InvokeCommand.ExpandString("$txt218") -ForegroundColor Green
                } catch {
                    Write-Host $ExecutionContext.InvokeCommand.ExpandString("$txt219") -ForegroundColor Red
                    try {
                        Copy-Item -Path ".\Backup\*" -Destination ".\" -Recurse -Force
                        Remove-Item ".\Backup" -Recurse -Force -Confirm:$false
                    } catch {
                        Write-Host $ExecutionContext.InvokeCommand.ExpandString("$txt220") -ForegroundColor Red
                    }
                }
            }
        }
    } else {
        Write-Host $ExecutionContext.InvokeCommand.ExpandString("$txt221") -ForegroundColor Red
        Write-Host $ExecutionContext.InvokeCommand.ExpandString("$txt222") -ForegroundColor Red
    }

    
}
######################

























#################################################################################
# MAIN
$PWD = "$PWD"
Set-Location "$PSScriptRoot"    # Permet d'aller dans le répertoire du script peu import la location de l'appelent
$NBParametre = $args.Count      # Récupère le nombre de paramètre
$Parametres = @{}               # Crée un dictionnaire vide
$currentKey = $null             # Variable pour stocker la clé actuelle


# Récupère la langue céléctionner 
RecuperationLangue

# Verifier Internet accès !
# Vérifier la connectivité Internet en envoyant une requête ping à google.com
$targetServer = "www.google.com"
$port = 80
$connection = Test-NetConnection -ComputerName $targetServer -Port $port -ErrorAction Stop
if ($connection.TcpTestSucceeded) {
    $InternetAccessible = $true
} else {
    $InternetAccessible = $false
}
# Vérifier la valeur de la variable $InternetAccessible
if ($InternetAccessible) {
    # Connexion Internet OK
} else {
    Write-Host $ExecutionContext.InvokeCommand.ExpandString("$txt223") -ForegroundColor Red
}


# Chemin complet du répertoire contenant le script
$scriptDir = (Get-Item -Path ".\").FullName

# Vérifier si le chemin du répertoire du script est déjà présent dans le PATH
if (-Not ($env:PATH -split ";" -contains $scriptDir)) {

    if ($Host.Runspace.IsRunspacePushed -and (-not $Host.Runspace.IsRunAsAdministrator >$null)) {
        Write-Host $ExecutionContext.InvokeCommand.ExpandString("$txt224") -ForegroundColor Red
        Write-Host $ExecutionContext.InvokeCommand.ExpandString("$txt225") -ForegroundColor Magenta
    } else {
        Write-Host $ExecutionContext.InvokeCommand.ExpandString("$txt226")
        Write-Host $ExecutionContext.InvokeCommand.ExpandString("$txt227") -ForegroundColor Yellow

        # Ajouter le répertoire au PATH pour le compte machine
        $env:PATH += ";$scriptDir"
        [System.Environment]::SetEnvironmentVariable("PATH", $env:PATH, "Machine")

        Write-Host $ExecutionContext.InvokeCommand.ExpandString("$txt228") -ForegroundColor Green
    }
} else {
    # "Le répertoire est déjà présent dans le PATH."
    if (Test-Path ".\START.bat") {
        Remove-Item ".\START.bat" -Force
    }
}

# Mettre à jour le chemin d'accès actuel pour cette session
$env:PATH += ";$scriptDir"





# Pas de Paramètre entré !
if ($NBParametre -eq 0) {
    Write-Host $ExecutionContext.InvokeCommand.ExpandString("$txt229") -ForegroundColor Red 
    exit(1)
}


foreach ($param in $args) {
    if ($param.StartsWith("-")) {
        $currentKey = $param.TrimStart("-").ToLower()  # Convertir en minuscules
        $Parametres[$currentKey] = $null
    } elseif ($currentKey -ne $null) {
        $Parametres[$currentKey] = $param.ToLower()  # Convertir en minuscules
        $currentKey = $null
    }
}


# Afficher le dictionnaire clé-valeur
$global:Parametres = $Parametres        # Contien les option de l'utilisateur


foreach ($key in $global:Parametres.Keys) {
    # Boucle sur les clés


    if ($key -eq "help") {      # Afficher Help function
        try {
            Help                # Appel fonction 
        } catch {
            Write-Host $ExecutionContext.InvokeCommand.ExpandString("$txt230") -ForegroundColor Red
            exit(1)             # Commande à u une erreur
        }
    }

    if ($key -eq "serch") {    # Permet de rechercher un driver 
        try {
            $Str = $global:Parametres[$key]    # Récupère le mot a rechercher
        } catch {
            Write-Host $ExecutionContext.InvokeCommand.ExpandString("$txt231") -ForegroundColor Red
        }
        try {
            serch($Str)             # Appel fonction 
        } catch {
            Write-Host $ExecutionContext.InvokeCommand.ExpandString("$txt232") -ForegroundColor Red
            exit(1)             # Commande à u une erreur
        }
    }

    if ($key -eq "mydr") {
        try {
            mydr
        } catch {
            Write-Host $ExecutionContext.InvokeCommand.ExpandString("$txt233") -ForegroundColor Red
            exit(1)
        }
    }

    if ($key -eq "update") {
        if (-not($InternetAccessible)) {    # Verifit ci internet est accecible
            Write-Host $ExecutionContext.InvokeCommand.ExpandString("$txt234") -ForegroundColor Red
            exit(1)
        }
        try {
            update                # Appel fonction
            Write-Host $ExecutionContext.InvokeCommand.ExpandString("$txt235") -ForegroundColor Green
        } catch {
            Write-Host $ExecutionContext.InvokeCommand.ExpandString("$txt236") -ForegroundColor Red
            exit(1)             # Commande à u une erreur
        }
    }

    if ($key -eq "list") {
        try {
            $Str = $global:Parametres[$key]    # Récupère le mot a rechercher
        } catch {
            Write-Host $ExecutionContext.InvokeCommand.ExpandString("$txt237") -ForegroundColor Red
        }
        try {
            list($Str)                # Appel fonction
        } catch {
            Write-Host $ExecutionContext.InvokeCommand.ExpandString("$txt238") -ForegroundColor Red
            exit(1)             # Commande à u une erreur
        }
    }

    if ($key -eq "install") {
        try {
            $Str = $global:Parametres[$key]    # Récupère le mot a rechercher
        } catch {
            Write-Host $ExecutionContext.InvokeCommand.ExpandString("$txt239") -ForegroundColor Red
        }
        try {
            install($Str)             # Appel fonction 
        } catch {
            Write-Host $ExecutionContext.InvokeCommand.ExpandString("$txt240") -ForegroundColor Red
            exit(1)             # Commande à u une erreur
        }
    }

    if ($key -eq "upgrade") {
        try {
            $Str = $global:Parametres[$key]    # Récupère le mot a rechercher
        } catch {
            Write-Host $ExecutionContext.InvokeCommand.ExpandString("$txt241") -ForegroundColor Red
        }
        try {
            upgrade($Str)             # Appel fonction 
            Write-Host $ExecutionContext.InvokeCommand.ExpandString("$txt242") -ForegroundColor Green
        } catch {
            Write-Host $ExecutionContext.InvokeCommand.ExpandString("$txt243") -ForegroundColor Red
            exit(1)             # Commande à u une erreur
        }
    }

    if ($key -eq "updategit") {
        try {
            updateGit
        } catch {
            Write-Host $ExecutionContext.InvokeCommand.ExpandString("$txt244") -ForegroundColor Red
            exit(1)             # Commande à u une erreur
        }
    }

    if ($key -eq "version") {
        try {
            version(".\Version.GetDriver")
        } catch {
            Write-Host $ExecutionContext.InvokeCommand.ExpandString("$txt245") -ForegroundColor Red
            exit(1)             # Commande à u une erreur
        }
    }

    if ($key -eq "upgradegit") {
        if (-not($InternetAccessible)) {    # Verifit ci internet est accecible
            Write-Host $ExecutionContext.InvokeCommand.ExpandString("$txt246") -ForegroundColor Red
            exit(1)
        }
        try {
            upgradegit
        } catch {
            Write-Host $ExecutionContext.InvokeCommand.ExpandString("$txt247") -ForegroundColor Red
            exit(1)    
        }
    }

    if ($key -eq "lang") {
        if ($global:Parametres[$key]) {
            $Str = $global:Parametres[$key]    # Récupère le mot a rechercher
        } else {$Str = ""}
        try {
            Lang($Str)
        } catch {
            Write-Host $ExecutionContext.InvokeCommand.ExpandString("$txt248")
        }
    }



}

Set-Location "$PWD"
# Supprimer les variables globales créées
if ($variableList) {
    $variableList | ForEach-Object {
        Remove-Variable -Name $_ -Scope Global
    }
}
exit(0)             #Commande términer corectement

















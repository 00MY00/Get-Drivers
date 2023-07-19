################################
# Crée par : Kuroakashiro
################################
# Verssion : 0.5
###################################################################################
# FUNCTION

function Help() {

    # _    _ ______ _      _____  
    #| |  | |  ____| |    |  __ \ 
    #| |__| | |__  | |    | |__) |
    #|  __  |  __| | |    |  ___/ 
    #| |  | | |____| |____| |     
    #|_|  |_|______|______|_|     
                             
    Write-Host ""
    Write-host "═══════════════════════════════════════════════════════════════" -ForegroundColor Cyan
    Write-host "► Page d'aide"
    Write-Host "Syntaxe : Get-Driver -list 'tt' ou -list 'nourl' ou -help"-ForegroundColor Magenta
    Write-Host "Paramètre :" -ForegroundColor Green
    Write-Host "    -list ; Affiche la liste complaite des driveur disponible" -ForegroundColor Yellow
    Write-Host "    -version ; Affiche la version actuel" -ForegroundColor Yellow
    Write-Host "    -serch 'txt' ; permet de fair une recherche parmi les drivers" -ForegroundColor Yellow
    Write-Host "    -install 'txt'; permet d'installer un des driver" -ForegroundColor Yellow
    Write-Host "    -update ; permet de mettre ajoure les list de drivers" -ForegroundColor Yellow
    Write-Host "    -upgrade 'txt' ; Permet de fair une recherche de Drivers utiliser 'apply' permet d'ajouter les donnée récupéré" -ForegroundColor Yellow
    Write-Host "    -updateGit ; permet de rechercher des mise a joure" -ForegroundColor Yellow
    Write-Host "    -upgradeGit ; permet de télécharger et apliquer une nouvelle verssion" -ForegroundColor Yellow
    Write-Host "    -help ; tous les autre argument qui suive sont ignioré" -ForegroundColor Yellow
    Write-Host "    -mydr ; Afficher les Drivers installé" -ForegroundColor Yellow
    Write-Host ""
    Write-Host ""
    Write-Host "---------------------------------------------------------------" -ForegroundColor Cyan
    Write-Host "Valeur :" -ForegroundColor Green
    Write-Host "    'applyold' s'utilise avec -upgrade et permet de charger une list déja existante" -ForegroundColor Yellow
    Write-Host "    'apply' s'utilise avec -upgrade pour apliquer les nonner trouvée" -ForegroundColor Yellow
    Write-Host "    'url' s'utilise avec -list permet d'afficher que les ligne et le contenu commancent par http" -ForegroundColor Yellow
    Write-Host "    'tt' s'utilise avec -list permet de conaitre le nombre de driveur répertorier" -ForegroundColor Yellow
    Write-Host "    'nourl' s'utilise avec -list permet d'afficher les driveur téléchargée" -ForegroundColor Yellow
    Write-Host ""
    Write-Host ""
    Write-host "═══════════════════════════════════════════════════════════════" -ForegroundColor Cyan

} 
######################

function serch($Str) {      # Permet de rechercher un des driver corespondant au String entré
    Write-Host "Recherche en cours " -NoNewline -ForegroundColor Yellow
    Write-Host "..." -ForegroundColor Cyan

    # Recherche dans le fichier 'list.GetDriver' qui contien tous les chemin des driveur
    try {
        $ContenuFichier = @(Get-Content -Path ".\list.GetDriver" | Select-String -Pattern $Str | ForEach-Object { $_.Line })
    } catch {
        Write-Host "Erreur 'b9SB48vt'" -ForegroundColor Red
        exit(1)
    }

    if (-not ($contenuFichier -eq "")) {
        Write-Host "Contenu semblable trouvez"  -ForegroundColor Green
        foreach ($txt in $ContenuFichier) {     # Affichage du contenu trouvée+
            Write-Host "►" -NoNewline -ForegroundColor Yellow
            Write-Host "    $txt" -NoNewline -ForegroundColor Cyan
            Write-Host "◄" -ForegroundColor Yellow
        }
    } else {
        Write-Host "Aucunne Corespondance ! `nVérifiez que la list est actualiser '-update'" -ForegroundColor Red
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
        Write-Host "Erreur : le dossier '$cheminDossier' est introuvable !" -ForegroundColor Red
        exit 1
    }

    # Vérifie si le fichier existe, sinon le crée avec une entête spécifique
    if (-not (Test-Path $cheminFichierTxt)) {
        Write-Host "Erreur : le fichier '$cheminFichierTxt' doit être créé !" -ForegroundColor Red
        try {
            "# Nomenclature ' Drivers/Fabricant/Drivername_URL'" | Out-File -FilePath $cheminFichierTxt -Force
            Write-Host "Le fichier a bien été créé !" -ForegroundColor Green
        } catch {
            Write-Host "Le fichier n'a pas pu être créé, vérifiez vos droits !" -ForegroundColor Red
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
                    Write-Host "-" -NoNewline -ForegroundColor Yellow   # Affiche le travail
                    Write-Host " $url"                                  # Affiche le travail
                } catch {
                    Write-Host "Erreur d'ajout du chemin concaténé"     
                }
            }
        } else {
            # Ne contient pas de url.txt
            $nomFichier = (Get-ChildItem -Path $cheminSousDossier -File).Name
            if ($nomFichier -ne $null) {
                $Concatenation = ".\Drivers\$sousDossier\$nomFichier"
                try {
                    "$Concatenation" >> ".\list.GetDriverTMP"
                    Write-Host "-" -NoNewline -ForegroundColor Blue     # Affiche le travail
                    Write-Host " $nomFichier"                           # Affiche le travail
                } catch {
                    Write-Host "Erreur d'ajout du chemin concaténé"     
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
            Write-Host "Erreur lors du correctif des doublons." -ForegroundColor Red
        }
    }
}

######################

function list($Str) {   # Permet d'afficher grosièrement le contenu de la liste 

    # Les code couleur du caractère '►' Magenta = pas de filtre Blue fichier Driveur installer Yellow url de télécharement du driveur  cyant pour afficher le nombre de driveur

    $cheminFichierTxt = ".\list.GetDriver"  # Spécifiez le chemin du fichier texte

    $contenuFichier = Get-Content -Path $cheminFichierTxt

    if ($Str -eq "nourl") {
        foreach ($ligne in $contenuFichier) {
            # Vérifie si la ligne ne contient pas le mot "http"
            if ($ligne -notmatch "http.*") {
                Write-Host "►" -NoNewline -ForegroundColor Blue
                Write-Host " Ligne sans lien : $ligne"
                }
        }
        exit(0)
    }
    if ($Str -eq "tt"){         # Permet de compter le nombre de drivers dans la list
        $nombreLignes = (Get-Content $cheminFichierTxt).Count - 1       # Totale ligne -1

        $contenuFichier = Get-Content $cheminFichierTxt
        $nombreLignesSansHttp = $contenuFichier | Where-Object { $_ -notmatch "http" } | Measure-Object | Select-Object -ExpandProperty Count   # NB en local

        $nombreLignesAvecHttp = $contenuFichier | Where-Object { $_ -match "http" } | Measure-Object | Select-Object -ExpandProperty Count      # NB lien URLs 



        Write-Host "►" -NoNewline -ForegroundColor Cyan
        Write-Host " Totale Drivers " -NoNewline -ForegroundColor Yellow
        Write-Host "'$nombreLignes'"
        Write-Host "►" -NoNewline -ForegroundColor Cyan
        Write-Host " Drivers  Local " -NoNewline -ForegroundColor Yellow
        Write-Host "'$nombreLignesSansHttp'"
        Write-Host "►" -NoNewline -ForegroundColor Cyan
        Write-Host " Drivers   URLs " -NoNewline -ForegroundColor Yellow
        Write-Host "'$nombreLignesAvecHttp'"
        exit(0)
    } else {

        if ($Str -eq "url") {   # Permet d'afficher selement les url et a partire des urls
            foreach ($ligne in $contenuFichier) {
                # Utilisation d'une expression régulière pour rechercher les liens qui commencent par "http" et se terminent par "'"
                $lienTrouve = $ligne | Select-String -Pattern "http.*'" -AllMatches | ForEach-Object { $_.Matches.Value }

                # Votre code à exécuter pour chaque lien trouvé
                foreach ($lien in $lienTrouve) {
                    Write-Host "►" -NoNewline -ForegroundColor Yellow
                    Write-Host " Lien trouvé : $lien"
                }
            }
            exit(0)
        } else {    # Ci pas de paramètre ajouter affiche la totalitée

            foreach ($ligne in $contenuFichier) {
                $indexDossier2 = $ligne.IndexOf("Drivers")
                # Votre code à exécuter pour chaque ligne du fichier
                if ($indexDossier2 -ge 0) {
                    $contenuApresDossier2 = $ligne.Substring($indexDossier2 + 8)
                    Write-Host "►" -NoNewline -ForegroundColor Magenta
                    Write-Host " : $contenuApresDossier2"
                }
            }
            Write-Host ""
            exit(0)
        }
    }

}
######################

function  install($Str) {
    
    function installLocal($ContenuFichier) {   # Permet de télécharger des Driveur télécharger dans la list Drivers

        $ContenuFichier = $ContenuFichier -replace '\\\\', '\'          # Changement du '\' simple en doublée

        # Le chemin récupéré contin deux foi le nom du fichier a executer ces command permet de retirer ce qui ce trouve a la fien de la première términeson
        $extantion = extantion($ContenuFichier)
        $contenuFichier = $contenuFichier.Substring(0, $contenuFichier.IndexOf($extantion) + $extantion.Length)

        Write-Host "Séléction : '$ContenuFichier'"

        if (-not (Test-Path "$ContenuFichier")) {
            Write-Host "Erreur le nom du driver est incorecte !" -ForegroundColor Red
            Write-Host "Utilise '-serch' pour verifier le nom ou '-update' pour actualiser la liste !" -ForegroundColor Red
            exit(1)
        }
        

        if ($extantion -eq ".msi") {        # Tester ci les erreur sont bin détecter car la dernière option est toujour choisit plus l'affichage d'erreur

            $installOptions = "/qn"
            $process = Start-Process -FilePath "$ContenuFichier" -ArgumentList "/i", "`"$msiFile`"", $installOptions -Wait -PassThru
            
            if ($process.ExitCode -eq 0) {
                Write-Host "Installation réussie !" -ForegroundColor Green
            } else {
                $installOptions = "/quiet"
                Write-Host "L'operateur '/qn' ne fonctionne pas" -ForegroundColor Red
                $process = Start-Process -FilePath "$ContenuFichier" -ArgumentList "/i", "`"$msiFile`"", $installOptions -Wait -PassThru
            } 
            if (-not ($process.ExitCode -eq 0)) {
                Write-Host "L'opérateur '/quiet' ne fonctionne pas" -ForegroundColor Red
                try {
                    $process = Start-Process -FilePath "$ContenuFichier" -Wait -PassThru
                    if ($process.ExitCode -eq 0) {
                        Write-Host "Terminée" -ForegroundColor Green
                    }
                    exit(0)
                } catch {
                    Write-Host "Erreur imposible d'ouvrire le fichier '$ContenuFichier'" -ForegroundColor Red
                    exit(1)
                }
            }
        }
     

        if ($extantion -eq ".exe") {
            try {
                Start-Process -FilePath "$ContenuFichier"
                exit(0)
            } catch {
                Write-Host "Erreur Lord de l'execution du fichier '$ContenuFichier'" -ForegroundColor Red
                try {
                    Start-Process -FilePath "$ContenuFichier"
                    Write-Host "Deuxième tentative réusit !" -ForegroundColor Green
                    exit(1)
                } catch {
                    Write-Host "Erreur la deuxèm tentative à aussi échouée !" -ForegroundColor Red
                    exit(2)
                }
            }
        }

        if ($extantion -eq ".zip") {    # ZIP

            # Amodifi pour fonctionner avec le mode local
            exit(111)   # Stop code non términer


            if (-not (Test-Path ".\Download")) {
                New-Item -ItemType Directory -Path ".\Download"
                Write-Host "Le dossier 'Download' est crée !" -ForegroundColor Yellow
            }


            # Retirer la termineson .zip au $NomFichier
            $DossierZip = $NomFichier.Split('.')[0]

            try {
                Expand-Archive -Path $cheminFichier -DestinationPath ".\Download\$DossierZip"
            } catch {
                Write-Host "Erreur de l'éxtraction du fichier !" -ForegroundColor Red
            }

            try {
                Remove-Item "$cheminFichier" -Force
            } catch {
                Write-Host "Erreur de supression du fichier ZIP !" -ForegroundColor Red
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
                        Write-Host "Installation términée" -ForegroundColor Green
                    } catch {
                        Write-Host "Erreur lord de l'éxecution du fichier '${$batFile.FullName}'" -ForegroundColor Red
                    }
                } elseif ($heaviestExe -and $heaviestMsi) {
                    # Exécution du fichier exe ou msi le plus lourd
                    if ($heaviestExe.Length -gt $heaviestMsi.Length) {
                        try {
                            Start-Process -FilePath $heaviestExe.FullName -Wait
                            Write-Host "Installation términée" -ForegroundColor Green
                        }   catch {
                        Write-Host "Erreur lord de l'éxecution du fichier '${$heaviestExe.FullName}'" -ForegroundColor Red
                        }
                    } else {
                        try {
                            Start-Process -FilePath $heaviestMsi.FullName -Wait
                            Write-Host "Installation términée" -ForegroundColor Green
                        } catch {
                        Write-Host "Erreur lord de l'éxecution du fichier '${$heaviestMsi.FullName}'" -ForegroundColor Red
                    }
                    }
                } elseif ($heaviestExe) {
                    # Exécution du fichier exe s'il existe
                    try {
                        Start-Process -FilePath $heaviestExe.FullName -Wait
                        Write-Host "Installation términée" -ForegroundColor Green
                    } catch {
                        Write-Host "Erreur lord de l'éxecution du fichier '${$heaviestExe.FullName}'" -ForegroundColor Red
                    }
                } elseif ($heaviestMsi) {
                    # Exécution du fichier msi s'il existe
                    try {
                        Start-Process -FilePath $heaviestMsi.FullName -Wait
                        Write-Host "Installation términée" -ForegroundColor Green
                    } catch {
                        Write-Host "Erreur lord de l'éxecution du fichier '${$heaviestMsi.FullName}'" -ForegroundColor Red
                    }
                }
            }

            # Supression de l'arrichive décompresser 
            try {
                Remove-Item "$DossierZip" -Force
            } catch {
                Write-Host "Erreur a la supression de l'arrchive '$DossierZip'" -ForegroundColor Red
            }

        } 



    }   ####################







    function extantion($URL) {
        # en entrée l'url en sortile l'extantion du fichier
        $extension = [System.IO.Path]::GetExtension($URL)
        Write-Host "Format du fichier '$extension'" -ForegroundColor Yellow
        return $extension
    }


    function installURL($ContenuFichier) {
        # Récupération de l'URL et téléchargement
        
        # Utilisation d'une expression régulière pour extraire le texte après 'uttp'
        $URL = $ContenuFichier | Select-String -Pattern 'http.*' -AllMatches | ForEach-Object { $_.Matches.Value }
        $NomFichier = Split-Path -Path $URL -Leaf

        if (-not (Test-Path ".\Download\$NomFichier")) {
            Write-Host "Téléchargement du fichier '$NomFichier'" -NoNewline -ForegroundColor Yellow
            try {
                Invoke-WebRequest -Uri "$URL" -OutFile ".\Download\$NomFichier" 
                Write-Host " [Terminée]" -ForegroundColor Green
            } catch {
                Write-Host " [Erreur]" -ForegroundColor Red
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
                Write-Host "Exécution terminée" -ForegroundColor Green
                Remove-Item $cheminFichier -Force  # Suppression du fichier
                Write-Host "Suppression réussie" -ForegroundColor Green
                exit 0
            } catch {
                Write-Host "Erreur à l'exécution du fichier '$NomFichier' !" -ForegroundColor Red
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
                Write-Host "Le dossier 'Download' est crée !" -ForegroundColor Yellow
            }


            # Retirer la termineson .zip au $NomFichier
            $DossierZip = $NomFichier.Split('.')[0]

            try {
                Expand-Archive -Path $cheminFichier -DestinationPath ".\Download\$DossierZip"
            } catch {
                Write-Host "Erreur de l'éxtraction du fichier !" -ForegroundColor Red
            }

            try {
                Remove-Item "$cheminFichier" -Force
            } catch {
                Write-Host "Erreur de supression du fichier ZIP !" -ForegroundColor Red
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
                        Write-Host "Installation términée" -ForegroundColor Green
                    } catch {
                        Write-Host "Erreur lord de l'éxecution du fichier '${$batFile.FullName}'" -ForegroundColor Red
                    }
                } elseif ($heaviestExe -and $heaviestMsi) {
                    # Exécution du fichier exe ou msi le plus lourd
                    if ($heaviestExe.Length -gt $heaviestMsi.Length) {
                        try {
                            Start-Process -FilePath $heaviestExe.FullName -Wait
                            Write-Host "Installation términée" -ForegroundColor Green
                        }   catch {
                        Write-Host "Erreur lord de l'éxecution du fichier '${$heaviestExe.FullName}'" -ForegroundColor Red
                        }
                    } else {
                        try {
                            Start-Process -FilePath $heaviestMsi.FullName -Wait
                            Write-Host "Installation términée" -ForegroundColor Green
                        } catch {
                        Write-Host "Erreur lord de l'éxecution du fichier '${$heaviestMsi.FullName}'" -ForegroundColor Red
                    }
                    }
                } elseif ($heaviestExe) {
                    # Exécution du fichier exe s'il existe
                    try {
                        Start-Process -FilePath $heaviestExe.FullName -Wait
                        Write-Host "Installation términée" -ForegroundColor Green
                    } catch {
                        Write-Host "Erreur lord de l'éxecution du fichier '${$heaviestExe.FullName}'" -ForegroundColor Red
                    }
                } elseif ($heaviestMsi) {
                    # Exécution du fichier msi s'il existe
                    try {
                        Start-Process -FilePath $heaviestMsi.FullName -Wait
                        Write-Host "Installation términée" -ForegroundColor Green
                    } catch {
                        Write-Host "Erreur lord de l'éxecution du fichier '${$heaviestMsi.FullName}'" -ForegroundColor Red
                    }
                }
            }

            # Supression de l'arrichive décompresser 
            try {
                Remove-Item "$DossierZip" -Force
            } catch {
                Write-Host "Erreur a la supression de l'arrchive '$DossierZip'" -ForegroundColor Red
            }
            
        }

    }

    ################################

    
    $ContenuFichier = Get-Content -Path ".\list.GetDriver" | Where-Object { $_ -match [regex]::Escape($Str) }
    $ContenuFichier = $ContenuFichier -replace "'", '' # Retire les apostrophes

    Write-Host "Test '$ContenuFichier'"

    # Verifier ci plusieur Sortil corespond
    if ($ContenuFichier.Count -gt 1) {
        # "Le tableau contient plus d'une entrée."
        while ($True) {
            Write-Host "Plusieurs fichier coresponde a votre choi !" -ForegroundColor Yellow
            $i = 0
            foreach ($chemin in $ContenuFichier) {
                Write-Host "[$i] ► $chemin[$i]"

                $i= $i + 1
                if ($i -gt 10) {break}
            }
            Write-Host "Etrée le numero corespondent a votre choit !"
            $user = Read-host "-> "

            if ($user -eq "exit") {exit(0)}

            if ($user -gt 10) {
                Write-Host "Erreur 10 maximum !" -ForegroundColor Red
            }
            if ($user -lt 0) {
                Write-Host "Erreur 0 minimum !" -ForegroundColor Red
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
    

    Write-Host "Séléction : '$ContenuFichier'"



    if ($ContenuFichier.Contains("\\")) {
        # Le mot rechercher contien des \ c'est probablement un Driveur local
        if (-not ($ContenuFichier.Contains("http"))) {
            # Le chemin n'est définitivement pas une url
            try {
                installLocal($ContenuFichier)   # Appel la fonction avec le nom du fichier choisit
            } catch {
                Write-Host "Erreur lord de l'appele de la fonction installLocal"
            }
        }
    } else {
        # C'est une URL a télécharger et installer
        if (-not($InternetAccessible)) {    # Verifit ci internet est accecible
            Write-Host "Internet n'est pas accessible. `nCommand imposible !" -ForegroundColor Red
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
        Write-Host "Erreur la commande à échouée !" -ForegroundColor Red
    }
}
######################

function upgrade($Str) {          # Permet de rechercher des drivers et avec la valeur apply elle sont ajoutée

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
                        Write-Host "L'URL existe déjà dans le fichier 'url.txt'. Aucune action nécessaire."
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
                Write-Host "Erreur l'a fonction apply permetent de rajouter les donnée trouvez a échouer !" -ForegroundColor Red
                exit(1)
            }
        } else {
            Write-Host "Erreur le fichier introuvable utiliser -upgrade 'apply' !" -ForegroundColor Red
            Write-Host "changement automatique du paramètre 'applyold' par 'apply' !" -ForegroundColor Yellow
            $Str = "apply"
        }
    }

    try {
        python --version > $null
        pip --version > $null
    } catch {
        Write-Host "Erreur Python n'es pas installer ou n'es pas ajouter au 'Path' !" -ForegroundColor Red
        try {
            Start-Process -FilePath ".\Install.bat" -Wait
        } catch {
            Write-Host "Erreur la tentative d'execution de 'Install.bat' à échouer !" -ForegroundColor Red
        }
    }

    Write-Host "Initialisation de la recherche de drivers" -NoNewline -ForegroundColor Yellow
    Write-Host "..." -ForegroundColor Green

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
                Write-Host "Erreur l'a fonction apply permetent de rajouter les donnée trouvez a échouer !" -ForegroundColor Red
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
                "Version 0.0.1" | Out-File -FilePath $Path
            }
        }

        # Utilisation d'une expression régulière pour extraire la version dans le format "Version 0.0.1"
        $pattern = 'Version (\d+\.\d+\.\d+)'
        $version = Get-Content -Path $Path | Select-String -Pattern $pattern | ForEach-Object { $_.Matches.Groups[1].Value }

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
        Write-Host "Erreur à la récupération de la version locale !" -ForegroundColor Red
        exit(1)
    }

    try {
        $GitVersion = UpdateGitDistantVersion
    } catch {
        Write-Host "Erreur à la récupération de la version distante !" -ForegroundColor Red
        exit(1)
    }

    if ($GitVersion -eq "") {$GitVersion = "X-Erreur"}
    if ($LocalVersion -eq "") {$GitVersion = "X-Erreur"}
    

    # Comparaison des versions
    if ($LocalVersion -lt $GitVersion) {
        Write-Host ""
        Write-Host "▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬" -ForegroundColor Magenta
        Write-Host "▐ Votre version est inférieure à la nouvelle !"
        Write-Host "▐ Utilisez la commande '-upgradeGit' pour l'installer."
        Write-Host "▐ Version installée  :" -NoNewline
        Write-Host " '$LocalVersion'" -ForegroundColor Cyan
        Write-Host "▐ Version disponible :" -NoNewline
        Write-Host " '$GitVersion'" -ForegroundColor Cyan
        Write-Host "▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬" -ForegroundColor Magenta
        Write-Host ""
        $fileContent = Get-Content -Path ".\Version.GetDriver"
        if ($fileContent -match "Depasser") {
            # "Le mot 'Depasser' a été trouvé dans le fichier." ce mot permet de valider ci il faut apliquer le upgrdeGit ou non
        } else {
            " " >> ".\Version.GetDriver"
            "Depasser" >> ".\Version.GetDriver"
        }
    } else {
        Write-Host ""
        Write-Host "▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬" -ForegroundColor Magenta
        Write-Host "▐ Votre version est à jour !"
        Write-Host "▐ Version installée  :" -NoNewline
        Write-Host " '$LocalVersion'" -ForegroundColor Cyan
        Write-Host "▐ Version disponible :" -NoNewline
        Write-Host " '$GitVersion'" -ForegroundColor Cyan
        Write-Host "▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬" -ForegroundColor Magenta
        Write-Host ""
    }



}
######################

function version($Path) {
    # Récupère la version du fichier mis en paramètre
    $VersionLocal = Get-Content -Path $Path -ErrorAction SilentlyContinue

    if (-not $VersionLocal) {
        # Crée le fichier avec une valeur 0.0.1 pour forcer la mise à jour
        "Version 0.0.1" > $Path
        $VersionLocal = "Version 0.0.1"
    }

    # Utilisation d'une expression régulière pour extraire la version dans le format "Version 0.0.1"
    $pattern = 'Version (\d+\.\d+\.\d+)'
    $version = $VersionLocal | Select-String -Pattern $pattern | ForEach-Object { $_.Matches.Groups[1].Value }

    # Extraction de la valeur numérique et suppression des '.' et des '0' avant le premier chiffre non '0'
    $versionNumerique = $version -replace '^0*|\.0*',''

    # Affichage de la version numérique
    Write-Host "Verssion actuel de Get-Drivers :" -NoNewline -ForegroundColor Yellow
    Write-Host " $versionNumerique" -ForegroundColor Cyan
}
######################

function upgradeGit() {         # Permet de metre à joure le programe

    $fileContent = Get-Content -Path ".\Version.GetDriver"
    if ($fileContent -match "Depasser") {
        # "Le mot 'Depasser' a été trouvé dans le fichier. Ce mot permet de valider ci il faut apliquer le upgrdeGit ou non
        if (-not (git --version 2>$null)) {
            # Erreur git n'est pas disponible 
            Start-Process ".\install.bat"
            Write-Host "Erreur git ne fonctionne pas, vérifiez votre installation ou téléchargez-la. Si l'erreur persiste, installer GIT !" -ForegroundColor Red
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
                Write-Host "Backup créé !" -ForegroundColor Green
            } catch {
                Write-Host "Erreur lors de la création de la sauvegarde." -ForegroundColor Red
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
                    Write-Host "Mise à joure réusit !" -ForegroundColor Green
                } catch {
                    Write-Host "Erreur lors de la mise à jour, récupération en cours !" -ForegroundColor Red
                    try {
                        Copy-Item -Path ".\Backup\*" -Destination ".\" -Recurse -Force
                        Remove-Item ".\Backup" -Recurse -Force -Confirm:$false
                    } catch {
                        Write-Host "Erreur, la récupération a échoué !" -ForegroundColor Red
                    }
                }
            }
        }
    } else {
        Write-Host "Erreur votre Verssion n'as pas besoin de mise à jour" -ForegroundColor Red
        Write-Host "Entrez -updateGit pour chercher les mis à jour disponible" -ForegroundColor Red
    }
    
}
######################

























#################################################################################
# MAIN

Set-Location "$PSScriptRoot"    # Permet d'aller dans le répertoire du script peu import la location de l'appelent
$NBParametre = $args.Count      # Récupère le nombre de paramètre
$Parametres = @{}               # Crée un dictionnaire vide
$currentKey = $null             # Variable pour stocker la clé actuelle

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
    Write-Host "Internet n'est pas accessible. `nCertaine commend peuvent ne pas fonctioner !" -ForegroundColor Red
}


# Chemin complet du répertoire contenant le script
$scriptDir = (Get-Item -Path ".\").FullName

# Vérifier si le chemin du répertoire du script est déjà présent dans le PATH
if (-Not ($env:PATH -split ";" -contains $scriptDir)) {

    if ($Host.Runspace.IsRunspacePushed -and (-not $Host.Runspace.IsRunAsAdministrator >$null)) {
        Write-Host "La session n'est pas en mode administrateur." -ForegroundColor Red
        Write-Host "Executer le script en Administrateur pour ajouter le chemin du programme" -ForegroundColor Magenta
    } else {
        Write-Host "La session est en mode administrateur."
        Write-Host "Ajout du répertoire au PATH..." -ForegroundColor Yellow

        # Ajouter le répertoire au PATH pour le compte machine
        $env:PATH += ";$scriptDir"
        [System.Environment]::SetEnvironmentVariable("PATH", $env:PATH, "Machine")

        Write-Host "Le répertoire a été ajouté au PATH." -ForegroundColor Green
    }
} else {
    # "Le répertoire est déjà présent dans le PATH."
}

# Mettre à jour le chemin d'accès actuel pour cette session
$env:PATH += ";$scriptDir"





# Pas de Paramètre entré !
if ($NBParametre -eq 0) {
    Write-Host "Aucun parametre entré ! `nEntrez un paramètre example '-help'" -ForegroundColor Red 
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
            Write-Host "Erreur n7w2pJ9B" -ForegroundColor Red
            exit(1)             # Commande à u une erreur
        }
    }

    if ($key -eq "serch") {    # Permet de rechercher un driver 
        try {
            $Str = $global:Parametres[$key]    # Récupère le mot a rechercher
        } catch {
            Write-Host "Erreur lord de la récupération du txt a chercher !" -ForegroundColor Red
        }
        try {
            serch($Str)             # Appel fonction 
        } catch {
            Write-Host "Erreur 3wrPiS98" -ForegroundColor Red
            exit(1)             # Commande à u une erreur
        }
    }

    if ($key -eq "mydr") {
        try {
            mydr
        } catch {
            Write-Host "Erreur 4G3irtJc" -ForegroundColor Red
            exit(1)
        }
    }

    if ($key -eq "update") {
        if (-not($InternetAccessible)) {    # Verifit ci internet est accecible
            Write-Host "Internet n'est pas accessible. `nCommand imposible !" -ForegroundColor Red
            exit(1)
        }
        try {
            update                # Appel fonction
            Write-Host "Update términée !" -ForegroundColor Green
        } catch {
            Write-Host "Erreur T5sj22Gd" -ForegroundColor Red
            exit(1)             # Commande à u une erreur
        }
    }

    if ($key -eq "list") {
        try {
            $Str = $global:Parametres[$key]    # Récupère le mot a rechercher
        } catch {
            Write-Host "Erreur lord de la récupération du txt a chercher !" -ForegroundColor Red
        }
        try {
            list($Str)                # Appel fonction
        } catch {
            Write-Host "Erreur y6F6i6fP" -ForegroundColor Red
            exit(1)             # Commande à u une erreur
        }
    }

    if ($key -eq "install") {
        try {
            $Str = $global:Parametres[$key]    # Récupère le mot a rechercher
        } catch {
            Write-Host "Erreur lord de la récupération du txt a chercher !" -ForegroundColor Red
        }
        try {
            install($Str)             # Appel fonction 
        } catch {
            Write-Host "Erreur Z8rPuS91" -ForegroundColor Red
            exit(1)             # Commande à u une erreur
        }
    }

    if ($key -eq "upgrade") {
        try {
            $Str = $global:Parametres[$key]    # Récupère le mot a rechercher
        } catch {
            Write-Host "Erreur lord de la récupération du txt a chercher !" -ForegroundColor Red
        }
        try {
            upgrade($Str)             # Appel fonction 
            Write-Host "Commande términer !" -ForegroundColor Green
        } catch {
            Write-Host "Erreur Z88Pll91" -ForegroundColor Red
            exit(1)             # Commande à u une erreur
        }
    }

    if ($key -eq "updategit") {
        try {
            updateGit
        } catch {
            Write-Host "Erreur yf5Eg7C2" -ForegroundColor Red
            exit(1)             # Commande à u une erreur
        }
    }

    if ($key -eq "version") {
        try {
            version(".\Version.GetDriver")
        } catch {
            Write-Host "Erreur yf5Eg7C2" -ForegroundColor Red
            exit(1)             # Commande à u une erreur
        }
    }

    if ($key -eq "upgradegit") {
        if (-not($InternetAccessible)) {    # Verifit ci internet est accecible
            Write-Host "Internet n'est pas accessible. `nCommand imposible !" -ForegroundColor Red
            exit(1)
        }
        try {
            upgradegit
        } catch {
            Write-Host "Erreur BfUEg6h2" -ForegroundColor Red
            exit(1)    
        }
    }





}

exit(0)             #Commande términer corectement

















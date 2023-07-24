#Retirer la réstriction d'execution de code powershell
Set-ExecutionPolicy Unrestricted -Force



$Back = $PWD

Set-Location "$env:USERPROFILE\Get-Drivers"
$scriptDir = "$env:USERPROFILE\Get-Drivers"


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
} 





winget --version 2>$null
if ($LASTEXITCODE -ne 0) {
    Write-Host "Winget n'est pas installé !"
    Write-Host "Téléchargement" -NoNewline
    Write-Host "..." -ForegroundColor Cyan
    Install-Module -Name Microsoft.WinGet.Client -Force
    if ($LASTEXITCODE -ne 0) {
        Write-Host "Installation réusit !"
        $wingetInstalled = "y"
    } else {
        $wingetInstalled = "n"
    }
}

if (-Not (Test-Path "$env:USERPROFILE\Get-Drivers\Download")) {
    New-Item -ItemType Directory -Path "$env:USERPROFILE\Get-Drivers\Download" | Out-Null
    Write-Host "Creation du dossier de téléchargement !" -ForegroundColor Green
}



if ($wingetInstalled -eq "y") {

    # Vérifier si Python est déjà installé avec Winget
    $pythonApp = Get-WinGetPackage -Name "Python" -Exact
    if ($pythonApp -eq $null) {
        Write-Host "Python n'est pas installé !"
        # Installation de Python avec Winget
        winget install -e --exact "Python"
    } else {
        Write-Host "Python est déjà installé."
    }

    # Vérifier si Git est déjà installé avec Winget
    $gitApp = Get-WinGetPackage -Name "Git" -Exact
    if ($gitApp -eq $null) {
        Write-Host "Git n'est pas installé !"
        # Installation de Git avec Winget
        winget install -e --exact "Git"
    } else {
        Write-Host "Git est déjà installé."
    }

    

    # Vérification de la version installée de Python
    $pythonVersion = & python --version 2>$null
    if ($LASTEXITCODE -eq 0) {
        Write-Host "Python a été installé avec succès !"
    } else {
        Write-Host "Une erreur s'est produite lors de l'installation de Python."
    }

    # Vérification de la version installée de Git
    $gitVersion = & git --version 2>$null
    if ($LASTEXITCODE -eq 0) {
        Write-Host "Git a été installé avec succès."
    } else {
        Write-Host "Une erreur s'est produite lors de l'installation de Git."
    }


}





if ($wingetInstalled -eq "n") {

    Set-Location "$env:USERPROFILE\Get-Drivers\Download"

    # Vérifier si Python est déjà installé
    $pythonVersion = & python --version 2>$null
    if ($LASTEXITCODE -eq 0) {
        Write-Host "Python est déjà installé. Vérification de la version..."
        & python --version
    }

    if (-Not (Test-Path "$env:USERPROFILE\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Python311\python.exe")) {
        Write-Host "Il y a une erreur d'installation de Python. Veuillez vérifier que le chemin du programme est ajouté à la variable d'environnement 'Path'."
    }

    $PYTHON_URL = "https://www.python.org/ftp/python/3.11.4/python-3.11.4-amd64.exe"
    $INSTALLER_FILENAME = "python_installer.exe"

    # Vérifier si le fichier d'installation existe déjà
    if (Test-Path $INSTALLER_FILENAME) {
        Write-Host "Le fichier d'installation de Python est déjà présent."
    } else {
        Write-Host "Téléchargement de Python..."
        Invoke-WebRequest -Uri $PYTHON_URL -OutFile $INSTALLER_FILENAME
    }

    Write-Host "Installation de Python en cours..."
    $null = Start-Process -FilePath $INSTALLER_FILENAME -ArgumentList "/quiet InstallAllUsers=1 PrependPath=1" -Wait

    # Mettre à jour le chemin d'accès actuel pour cette session
    $env:PATH += ";$script_dir"

    if (Test-Path "$env:USERPROFILE\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Python311\python.exe") {
        $env:PATH = "$env:PATH;$env:USERPROFILE\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Python311"
    }

    Write-Host "Nettoyage..."
    Remove-Item $INSTALLER_FILENAME

    # Vérification de la version installée de Python
    $pythonVersion = & python --version 2>$null
    if ($LASTEXITCODE -eq 0) {
        Write-Host "Python a été installé avec succès !"
    } else {
        Write-Host "Une erreur s'est produite lors de l'installation de Python."
    }

    # Vérifier si Git est déjà installé
    $gitVersion = & git --version 2>$null
    if ($LASTEXITCODE -ne 0) {
        if (Test-Path "C:\Program Files\Git") {
            Write-Host "Il y a une erreur d'installation de Git. Vérifiez que le chemin du programme est ajouté à la variable d'environnement 'Path'."
            exit
        } else {
            Write-Host "Git n'est pas installé !"

            # Définir le répertoire de sauvegarde 
            $back = "D:\MonRépertoire"

            # Télécharger Git s'il n'existe pas déjà dans le répertoire de sauvegarde
            $gitSetupPath = "$env:USERPROFILE\Get-Drivers\Download\GitSetup.exe"
            if (-Not (Test-Path $gitSetupPath)) {
                Write-Host "Téléchargement de Git..."
                Invoke-WebRequest -Uri "https://github.com/git-for-windows/git/releases/download/v2.41.0.windows.3/Git-2.41.0.3-64-bit.exe" -OutFile $gitSetupPath
            }

            # Installer Git (modifier le nom du fichier téléchargé si nécessaire)
            Write-Host "Installation de Git..."
            Start-Process -FilePath $gitSetupPath -ArgumentList "/SILENT" -Wait

            # Vérifier à nouveau si Git est installé après l'installation
            $gitVersion = & git --version 2>$null
            if ($LASTEXITCODE -eq 0) {
                Write-Host "Git a été installé avec succès."
            } else {
                Write-Host "Une erreur s'est produite lors de l'installation de Git."
            }
        }
    } else {
        Write-Host "Git est déjà installé avec succès."
    }
}


$pipVersion = & pip --version 2>$null
if ($LASTEXITCODE -eq 0) {
    & python get-pip.py
    Write-Host "PIP est installé !"
} else {
    Write-Host "PIP n'est pas installé !"
}


& pip install --upgrade requests 2>$null
if ($LASTEXITCODE -eq 0) {
    Write-Host "Installation de requests [OK]"
} else {
    Write-Host "Installation de requests [ERREUR]"
}


& pip install --upgrade bs4 2>$null
if ($LASTEXITCODE -eq 0) {
    Write-Host "Installation de bs4 [OK]"
} else {
    Write-Host "Installation de bs4 [ERREUR]"
}


& pip install --upgrade urljoin 2>$null
if ($LASTEXITCODE -eq 0) {
    Write-Host "Installation de urljoin [OK]"
} else {
    Write-Host "Installation de urljoin [ERREUR]"
}


if (-Not ($env:PATH -split ";" -contains $scriptDir)) {
    Write-Host "Erreur le chemin n'est pas ajoutée corectement !"
} else {
    # "Le répertoire est déjà présent dans le PATH."
    if (Test-Path ".\Install.ps1") {
        Remove-Item ".\Install.ps1" -Force
    }
}

Set-Location "$back"


exit(0)
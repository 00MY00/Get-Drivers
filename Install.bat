@echo off
chcp 65001
mode con cols=60 lines=30
title Verification integraliter
set back=%~dp0
title Installation des pakets Git-Drivers
setlocal enabledelayedexpansion
rem !!!!!!!!!!!!!!!!!!!!!!
rem Utiliser Python 3.11.4
rem !!!!!!!!!!!!!!!!!!!!!!




net session >nul 2>&1
if %errorlevel% == 0 (
    echo L'exécution est en tant qu'administrateur.
    rem Ajout du script au Path
    REM Chemin complet du répertoire contenant le script
    set "script_dir=%back%;"

    REM Vérifier si le chemin du répertoire du script est déjà présent dans le PATH
    echo %PATH% | find /i "%script_dir%;" >nul

    REM Si le chemin n'est pas trouvé (erreurlevel = 1), ajouter le répertoire au PATH
    if %errorlevel% == 1 (
        echo Ajout du répertoire au PATH...
        setx PATH "%PATH%;%script_dir%;" /M
		powershell.exe -Command "$env:PATH += \";%script_dir%\"; [System.Environment]::SetEnvironmentVariable(\"PATH\", $env:PATH, \"Machine\")"
        echo Le répertoire a été ajouté au PATH.
        powershell -command "Set-ExecutionPolicy RemoteSigned -Force"
    ) else (
        echo Le répertoire est déjà présent dans le PATH.
    )

    REM Mettre à jour le chemin d'accès actuel pour cette session
    set "PATH=%PATH%;%script_dir%"
) else (
    echo L'exécution n'est pas en tant qu'administrateur.
)



rem Verifier que le répertoire .\Download existe
if not exist "%back%Download" mkdir "%back%Download" & echo Creation du dossier de téléchargement !

cd "%back%Download"

REM Mettre à jour le chemin d'accès actuel pour cette session
set PATH=%PATH%;%script_dir%

rem Vérification si Python est déjà installé
python --version 2>nul
if %errorlevel% == 0 (
    echo Python est déjà installé. Vérification de la version...
    python --version
    goto Install-Pip
)
if not exist "%USERPROFILE%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Python311\python.exe" echo Il y a une erreur d'installation de Python. Veuillez vérifier que le chemin du programme est ajouté à la variable d'environnement 'Path'.
set PYTHON_URL=https://www.python.org/ftp/python/3.11.4/python-3.11.4-amd64.exe
set INSTALLER_FILENAME=python_installer.exe

rem Vérification si le fichier d'installation existe déjà
if exist %INSTALLER_FILENAME% (
    echo Le fichier d'installation de Python est déjà présent.
) else (
    echo Téléchargement de Python...
    curl -o %INSTALLER_FILENAME% %PYTHON_URL%
)

echo Installation de Python en cours...
rem echo Ci le script reste blocker trop longtempt entrer une touche pour continuer
%INSTALLER_FILENAME% /quiet InstallAllUsers=1 PrependPath=1


REM Mettre à jour le chemin d'accès actuel pour cette session
set PATH=%PATH%;%script_dir%

if exist "%USERPROFILE%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Python311\python.exe" setx PATH "%PATH%;%USERPROFILE%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Python311"


echo Nettoyage...
del %INSTALLER_FILENAME%

rem Vérification de la version installée de Python
python --version 2>nul
if %errorlevel% == 0 (
    echo Python a été installé avec succès ! & goto Install-Pip
) else (
    echo Une erreur s'est produite lors de l'installation de Python.
)




rem Vérifier si Git est déjà installé
git --version >nul 2>&1
if not %errorlevel% == 0 (
	if exist "C:\Program Files\Git" echo il y a une erreur d'installation de Git verifier que le chemin du programme est ajouter a la variable d'environement 'Path' & pause & exit
    echo Git est pas installer !
	rem Télécharger Git
	if not exist "%back%Download\GitSetup.exe" echo Téléchargement de Git... & curl -L -o GitSetup.exe https://objects.githubusercontent.com/github-production-release-asset-2e65be/23216272/e93af75b-8038-4c9d-b5e7-50504c6353ca?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAIWNJYAX4CSVEH53A%2F20230719%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20230719T115705Z&X-Amz-Expires=300&X-Amz-Signature=4f101ca091fcf0e714c910d8fa2cb71b41bca3549997d17d53edb4eaa5bd0806&X-Amz-SignedHeaders=host&actor_id=0&key_id=0&repo_id=23216272&response-content-disposition=attachment%3B%20filename%3DGit-2.41.0.3-64-bit.exe&response-content-type=application%2Foctet-stream

	rem Installer Git (modifier le nom du fichier téléchargé si nécessaire)
	echo Installation de Git...
	start /wait GitSetup.exe /SILENT

	rem Nettoyer le fichier d'installation téléchargé
	del GitSetup.exe

	rem Vérifier à nouveau si Git est installé après l'installation
	git --version >nul 2>&1
	if %errorlevel% == 0 (
		echo Git a été installé avec succès.
	) else (
		echo Une erreur s'est produite lors de l'installation de Git.
	)
    
)























:Install-Pip
pip --version 2>nul
if %errorlevel% == 1 (python get-pip.py & echo PIP est installer !) else (echo PIP est installer !)
pip --version 2>nul
if %errorlevel% == 0 (goto Pip-Install) else (echo erreur d'installation de PIP & pause & exit)






:Pip-Install
pip install --upgrade requests 2>nul
if %errorlevel% == 0 (echo Installation de requests [OK]) else (echo Installation de requests [ERREUR])
pip install --upgrade bs4 2>nul
if %errorlevel% == 0 (echo Installation de bs4 [OK]) else (echo Installation de bs4 [ERREUR])
pip install --upgrade urljoin 2>nul
if %errorlevel% == 0 (echo Installation de urljoin [OK]) else (echo Installation de urljoin [ERREUR])






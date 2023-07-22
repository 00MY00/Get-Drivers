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


rem Verifit droi administrateur
if exist "admin.txt" del admin.txt
if exist "t.txt" del t.txt
for /F  "skip=21 eol=* tokens=5,6*" %%i IN (admin.txt) Do @echo %%i >> t.txt
set /p DroiAdmin=< t.txt
rem net user %USERNAME% >> admin.txt
set DroiAdmin=%DroiAdmin:~1%
if exist "admin.txt" del admin.txt
if exist "t.txt" del t.txt
rem récupère le nom du group administrateur
for /F "tokens=1" %G in ('net localgroup ^| find /I "Admin"') do @echo %G > t.txt
set /p Administrateurs=< t.txt
set Administrateurs=%Administrateurs:~1,-1%
if exist "t.txt" del t.txt
cls 


pause

if %DroiAdmin% == %Administrateurs% (
    echo L'exécution est en tant qu'administrateur.
    rem Ajout du script au Path
    REM Chemin complet du répertoire contenant le script
    set "script_dir=%USERPROFILE%\Get-Drivers;"

    REM Vérifier si le chemin du répertoire du script est déjà présent dans le PATH
    set "path_to_check=%USERPROFILE%\Get-Drivers"
	set "found=0"

     
	 
	 
	rem Séparation du PATH en plusieurs chemins en utilisant des points-virgules
	for %%P in ("%PATH:;=";"%") do (
		rem Supprime les guillemets ajoutés autour de chaque chemin
		set "path=%%~P"

		rem Affiche chaque chemin (pour des fins de vérification, vous pouvez le retirer si vous le souhaitez)
		echo Chemin trouvé : !path!

		rem Vérifie si le chemin (!path!) est identique au chemin à vérifier (%path_to_check%)
		if /I "!path!"=="%path_to_check%" (
			set "found=1"
			goto :FOUND
		)
	)
	 
	goto :NOTFOUND
	 
	 
	 
	:NOTFOUND
     rem ------------------------------
     echo Ajout du répertoire au PATH...
     powershell.exe -Command "$env:PATH += \"$env:USERPROFILE\Get-Drivers\"; [System.Environment]::SetEnvironmentVariable(\"PATH\", $env:PATH, \"Machine\")"
     echo Le répertoire a été ajouté au PATH.
     powershell -command "Set-ExecutionPolicy RemoteSigned -Force"
    
	
    :FOUND
	echo le chemin est déja ajouter !
	

       REM Mettre à jour le chemin d'accès actuel pour cette session
       set "PATH=%PATH%;%script_dir%"
) else (
    echo L'exécution n'est pas en tant qu'administrateur.
)



rem Verifier que le répertoire .\Download existe
if not exist "%USERPROFILE%\Get-Drivers\Download" mkdir "%USERPROFILE%\Get-Drivers\Download" & echo Creation du dossier de téléchargement !

cd "%USERPROFILE%\Get-Drivers\Download"

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
    if exist "C:\Program Files\Git" (
        echo Il y a une erreur d'installation de Git. Vérifiez que le chemin du programme est ajouté à la variable d'environnement 'Path'.
        pause
        exit
    ) else (
        echo Git n'est pas installé !

        rem Définir le répertoire de sauvegarde 
        set "back=D:\MonRépertoire"

        rem Télécharger Git s'il n'existe pas déjà dans le répertoire de sauvegarde
        if not exist "%USERPROFILE%\Get-Drivers\Download\GitSetup.exe" (
            echo Téléchargement de Git...
            curl -L -o "%USERPROFILE%\Get-Drivers\Download\GitSetup.exe" https://github.com/git-for-windows/git/releases/download/v2.41.0.windows.3/Git-2.41.0.3-64-bit.exe
        )

        rem Installer Git (modifier le nom du fichier téléchargé si nécessaire)
        echo Installation de Git...
        start /wait "%USERPROFILE%\Get-Drivers\Download\GitSetup.exe" /SILENT

        rem Vérifier à nouveau si Git est installé après l'installation
        git --version >nul 2>&1
        if %errorlevel% == 0 (
            echo Git a été installé avec succès.
        ) else (
            echo Une erreur s'est produite lors de l'installation de Git.
        )
    )
) else (
    echo Git est déjà installé avec succès.
)










:Install-Pip
pip --version 2>nul
if %errorlevel% == 0 (python get-pip.py & echo PIP est installer !) else (echo PIP est pas installer !)
pip --version 2>nul
if %errorlevel% == 0 (goto Pip-Install) else (echo erreur d'installation de PIP )






:Pip-Install
pip install --upgrade requests 2>nul
if %errorlevel% == 0 (echo Installation de requests [OK]) else (echo Installation de requests [ERREUR])
pip install --upgrade bs4 2>nul
if %errorlevel% == 0 (echo Installation de bs4 [OK]) else (echo Installation de bs4 [ERREUR])
pip install --upgrade urljoin 2>nul
if %errorlevel% == 0 (echo Installation de urljoin [OK]) else (echo Installation de urljoin [ERREUR])







<button class="bouton-lang">Francais</button> <button class="bouton-lang">English</button> <button class="bouton-lang">Español</button>
-------------
- # Compatible avec : <button class="bouton-w">Windows 10</button>  <button class="bouton-p">Powershell 5</button> <button class="bouton-py">Python 3.11.4</button>
-------------
- Langues : <button class="bouton-lang">Francais</button> 
-------------
# Premier démarrage manuel
- téléchargér l'archive. <span style="color: #00E4DA;">https://github.com/00MY00/Get-Drivers.git</span>
- Décompressez-l'archive dans votre dossier utilisateur. '%USERPROFILE'
- executer le script <span style="color: #0EE400;">'Install.ps1'</span> en administrateur la première fois.

# Premier démarrage Powershell

- $archiveUrl = "https://github.com/00MY00/Get-Drivers/archive/main.zip"
- $destinationFolder = "$env:USERPROFILE"
- cd "$destinationFolder"
- Invoke-WebRequest -Uri $archiveUrl -OutFile "$destinationFolder\Get-Drivers.zip"
- Expand-Archive -Path "$destinationFolder\Get-Drivers.zip" -DestinationPath $destinationFolder
- Rename-Item -Path ".\Get-Drivers-main" -NewName ".\Get-Drivers"
- Remove-Item "Get-Drivers.zip"
- Set-ExecutionPolicy UnRestricted -Force
- Start-Process -FilePath "powershell.exe" -ArgumentList "-File ""$destinationFolder\Get-Drivers\Install.ps1""" -Verb RunAs
-------------

# Auteur : <button class="bouton-u">Kuroakashiro</button> <button class="bouton-u">00MY00</button>

# Déscription du projet 

- Get-Drivers est un outil en PowerShell qui permet d'avoir accès à une grande liste de drivers. Les drivers peuvent être téléchargés depuis l'outil, et celui-ci propose un script Python permettant de rechercher d'autres drivers. Get-Drivers ne contient pas beaucoup de drivers en local, mais des liens qui permettent une meilleure portabilité. Il est aussi possible d'ajouter ses propres drivers manuellement dans '.\Drivers\Nom_Du_Fabricant_de_drivers\Mon_Driver_local_exe'. Les formats de drivers supportés sont actuellement <span style="color: #0EE400;">EXE, ZIP, MSI</span>.

-------------

# Commande à copier coler dans un terminal Administrateur Powershell

     $archiveUrl = "https://github.com/00MY00/Get-Drivers/archive/main.zip";
     $destinationFolder = "$env:USERPROFILE";
     cd "$destinationFolder";
     Invoke-WebRequest -Uri $archiveUrl -OutFile "$destinationFolder\Get-Drivers.zip";
     Expand-Archive -Path "$destinationFolder\Get-Drivers.zip" -DestinationPath $destinationFolder;
     Rename-Item -Path ".\Get-Drivers-main" -NewName ".\Get-Drivers";
     Remove-Item "Get-Drivers.zip";
     Set-ExecutionPolicy UnRestricted -Force # Nécécite drois Administrateur;
     Start-Process -FilePath "powershell.exe" -ArgumentList "-File ""$destinationFolder\Get-Drivers\Install.ps1""" -Verb RunAs

-------------
# ----------------------------
# Get-Drivers
-------------
- # Compatible with : <button class="bouton-w">Windows 10</button>  <button class="bouton-p">Powershell 5</button> <button class="bouton-py">Python 3.11.4</button>
-------------
- Languages : <button class="bouton-lang">English</button>
-------------
# Initial Manual Startup
- Download the archive. <span style="color: #00E4DA;">https://github.com/00MY00/Get-Drivers.git</span>
- Decompress the archive in your user folder. '%USERPROFILE'
- Run the script <span style="color: #0EE400;">'Install.ps1'</span> as administrator for the first time.

# Initial Powershell Startup

- $archiveUrl = "https://github.com/00MY00/Get-Drivers/archive/main.zip"
- $destinationFolder = "$env:USERPROFILE"
- cd "$destinationFolder"
- Invoke-WebRequest -Uri $archiveUrl -OutFile "$destinationFolder\Get-Drivers.zip"
- Expand-Archive -Path "$destinationFolder\Get-Drivers.zip" -DestinationPath $destinationFolder
- Rename-Item -Path ".\Get-Drivers-main" -NewName ".\Get-Drivers"
- Remove-Item "Get-Drivers.zip"
- Set-ExecutionPolicy UnRestricted -Force
- Start-Process -FilePath "powershell.exe" -ArgumentList "-File ""$destinationFolder\Get-Drivers\Install.ps1""" -Verb RunAs
-------------

# Author : <button class="bouton-u">Kuroakashiro</button> <button class="bouton-u">00MY00</button>

# Project Description

- Get-Drivers is a PowerShell tool that provides access to a large list of drivers. The drivers can be downloaded from the tool, and it offers a Python script to search for more drivers. Get-Drivers does not contain many drivers locally, but links that allow better portability. It is also possible to add your own drivers manually in '.\Drivers\Name_Of_Driver_Manufacturer\My_Local_Driver_exe'. The currently supported driver formats are <span style="color: #0EE400;">EXE, ZIP, MSI</span>.

-------------

# Command to copy and paste into a Administrator Powershell terminal

     $archiveUrl = "https://github.com/00MY00/Get-Drivers/archive/main.zip";
     $destinationFolder = "$env:USERPROFILE";
     cd "$destinationFolder";
     Invoke-WebRequest -Uri $archiveUrl -OutFile "$destinationFolder\Get-Drivers.zip";
     Expand-Archive -Path "$destinationFolder\Get-Drivers.zip" -DestinationPath $destinationFolder;
     Rename-Item -Path ".\Get-Drivers-main" -NewName ".\Get-Drivers";
     Remove-Item "Get-Drivers.zip";
     Set-ExecutionPolicy UnRestricted -Force # Requires Administrator rights;
     Start-Process -FilePath "powershell.exe" -ArgumentList "-File ""$destinationFolder\Get-Drivers\Install.ps1""" -Verb RunAs

-------------
# ----------------------------
# Get-Drivers
-------------
- # Compatible con: <button class="bouton-w">Windows 10</button>  <button class="bouton-p">Powershell 5</button> <button class="bouton-py">Python 3.11.4</button>
-------------
- Idiomas: <button class="bouton-lang">Español</button> 
-------------
# Primer inicio manual
- Descargar el archivo. <span style="color: #00E4DA;">https://github.com/00MY00/Get-Drivers.git</span>
- Descomprime el archivo en tu carpeta de usuario. '%USERPROFILE'
- Ejecute el script <span style="color: #0EE400;">'Install.ps1'</span> como administrador la primera vez.

# Primer inicio en Powershell

- $archiveUrl = "https://github.com/00MY00/Get-Drivers/archive/main.zip"
- $destinationFolder = "$env:USERPROFILE"
- cd "$destinationFolder"
- Invoke-WebRequest -Uri $archiveUrl -OutFile "$destinationFolder\Get-Drivers.zip"
- Expand-Archive -Path "$destinationFolder\Get-Drivers.zip" -DestinationPath $destinationFolder
- Rename-Item -Path ".\Get-Drivers-main" -NewName ".\Get-Drivers"
- Remove-Item "Get-Drivers.zip"
- Set-ExecutionPolicy UnRestricted -Force
- Start-Process -FilePath "powershell.exe" -ArgumentList "-File ""$destinationFolder\Get-Drivers\Install.ps1""" -Verb RunAs
-------------

# Autor: <button class="bouton-u">Kuroakashiro</button> <button class="bouton-u">00MY00</button>

# Descripción del proyecto 

- Get-Drivers es una herramienta en PowerShell que permite acceder a una gran lista de controladores. Los controladores se pueden descargar desde la herramienta, y esta ofrece un script en Python para buscar más controladores. Get-Drivers no contiene muchos controladores localmente, pero enlaces que permiten una mejor portabilidad. También es posible agregar sus propios controladores manualmente en '.\Drivers\Nombre_Del_Fabricante_del_Controlador\Mi_Controlador_Local_exe'. Los formatos de controladores actualmente admitidos son <span style="color: #0EE400;">EXE, ZIP, MSI</span>.

-------------

# Commande à copier coler dans un terminal Administrateur Powershell

     $archiveUrl = "https://github.com/00MY00/Get-Drivers/archive/main.zip";
     $destinationFolder = "$env:USERPROFILE";
     cd "$destinationFolder";
     Invoke-WebRequest -Uri $archiveUrl -OutFile "$destinationFolder\Get-Drivers.zip";
     Expand-Archive -Path "$destinationFolder\Get-Drivers.zip" -DestinationPath $destinationFolder;
     Rename-Item -Path ".\Get-Drivers-main" -NewName ".\Get-Drivers";
     Remove-Item "Get-Drivers.zip";
     Set-ExecutionPolicy UnRestricted -Force # Necesita derechos de Administrador;
     Start-Process -FilePath "powershell.exe" -ArgumentList "-File ""$destinationFolder\Get-Drivers\Install.ps1""" -Verb RunAs





















<style>
    /*-----------------------------------------------------------------------*/
    /* Style de base pour le bouton Windows*/
    .bouton-w {
      background-color: #0169C5; /* Vert */
      border: none;
      color: #ffffff; /* Blanc */
      padding: 8px 30px;
      text-align: center;
      text-decoration: none;
      display: inline-block;
      font-size: 10px;
      border-radius: 20px; /* Bordures arrondies pour l'effet 3D */
      cursor: pointer;
      position: relative;
      overflow: hidden;
    }

    /* Ombre pour l'effet 3D */
    .bouton-w::before {
      content: '';
      position: absolute;
      top: 100%;
      left: 0;
      width: 100%;
      height: 100%;
      background: rgba(0, 0, 0, 0.15);
      opacity: 0;
      transition: opacity 0.3s;
    }

    /* Révéler l'ombre lors du survol */
    .bouton-w:hover::before {
      top: 0;
      opacity: 1;
    }

    /* Style de base pour le bouton Powershell */
    .bouton-p {
      background-color: #06A1CE; /* Vert */
      border: none;
      color: #ffffff; /* Blanc */
      padding: 8px 30px;
      text-align: center;
      text-decoration: none;
      display: inline-block;
      font-size: 10px;
      border-radius: 20px; /* Bordures arrondies pour l'effet 3D */
      cursor: pointer;
      position: relative;
      overflow: hidden;
    }

    /* Ombre pour l'effet 3D */
    .bouton-p::before {
      content: '';
      position: absolute;
      top: 100%;
      left: 0;
      width: 100%;
      height: 100%;
      background: rgba(0, 0, 0, 0.15);
      opacity: 0;
      transition: opacity 0.3s;
    }

    /* Révéler l'ombre lors du survol */
    .bouton-p:hover::before {
      top: 0;
      opacity: 1;
    }

    /* Style de base pour le bouton Python */
    .bouton-py {
      background-color: #4CAF50; /* Vert */
      border: none;
      color: #ffffff; /* Blanc */
      padding: 8px 30px;
      text-align: center;
      text-decoration: none;
      display: inline-block;
      font-size: 10px;
      border-radius: 20px; /* Bordures arrondies pour l'effet 3D */
      cursor: pointer;
      position: relative;
      overflow: hidden;
    }

    /* Ombre pour l'effet 3D */
    .bouton-py::before {
      content: '';
      position: absolute;
      top: 100%;
      left: 0;
      width: 100%;
      height: 100%;
      background: rgba(0, 0, 0, 0.15);
      opacity: 0;
      transition: opacity 0.3s;
    }

    /* Révéler l'ombre lors du survol */
    .bouton-py:hover::before {
      top: 0;
      opacity: 1;
    }

    /* Style de base pour le bouton Users */
    .bouton-u {
      background-color: #A40A5E; /* Vert */
      border: none;
      color: #ffffff; /* Blanc */
      padding: 8px 30px;
      text-align: center;
      text-decoration: none;
      display: inline-block;
      font-size: 10px;
      border-radius: 20px; /* Bordures arrondies pour l'effet 3D */
      cursor: pointer;
      position: relative;
      overflow: hidden;
    }

    /* Ombre pour l'effet 3D */
    .bouton-u::before {
      content: '';
      position: absolute;
      top: 100%;
      left: 0;
      width: 100%;
      height: 100%;
      background: rgba(0, 0, 0, 0.15);
      opacity: 0;
      transition: opacity 0.3s;
    }

    /* Révéler l'ombre lors du survol */
    .bouton-u:hover::before {
      top: 0;
      opacity: 1;
    }

  
  /* Style de base pour le bouton Langues */
  .bouton-lang {
    background-color: #D8E400; /* Vert */
    border: none;
    color: #020202; /* Blanc */
    padding: 8px 30px;
    text-align: center;
    text-decoration: none;
    display: inline-block;
    font-size: 10px;
    font-weight: bold; /* Ajout du gras */
    border-radius: 20px; /* Bordures arrondies pour l'effet 3D */
    cursor: pointer;
    position: relative;
    overflow: hidden;
  }

  /* Ombre pour l'effet 3D */
  .bouton-lang::before {
    content: '';
    position: absolute;
    top: 100%;
    left: 0;
    width: 100%;
    height: 100%;
    background: rgba(0, 0, 0, 0.15);
    opacity: 0;
    transition: opacity 0.3s;
  }

  /* Révéler l'ombre lors du survol */
  .bouton-lang:hover::before {
    top: 0;
    opacity: 1;
  }

  </style>


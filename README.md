# Get-Drivers V : 0.0.4
-------------
- # Compatible avec : <button class="bouton-w">Windows 10</button>  <button class="bouton-p">Powershell 5</button> <button class="bouton-py">Python 3.11.4</button>
-------------
# Premier démarrage manuel
- téléchargér l'archive. <span style="color: #00E4DA;">https://github.com/00MY00/Get-Drivers.git</span>
- executer le script <span style="color: #0EE400;">'Install.ps1'</span> en administrateur la première fois.

# Premier démarrage Powershell

- $archiveUrl = "https://github.com/00MY00/Get-Drivers/archive/main.zip"
- $destinationFolder = "."
- Invoke-WebRequest -Uri $archiveUrl -OutFile "$destinationFolder\Get-Drivers.zip"
- Expand-Archive -Path "$destinationFolder\Get-Drivers.zip" -DestinationPath $destinationFolder
- Rename-Item -Path ".\Get-Drivers-main" -NewName ".\Get-Drivers"
- Remove-Item "Get-Drivers.zip"
- Set-ExecutionPolicy Restricted -Force
- Start-Process -FilePath ".\Get-Drivers\Install.bat" -Verb RunAs
- Start-Process -FilePath ".\Get-Drivers\Install.ps1"
-------------

# Auteur : <button class="bouton-u">Kuroakashiro</button> <button class="bouton-u">00MY00</button>

# Déscription du projet 

- Get-Drivers est un outil en PowerShell qui permet d'avoir accès à une grande liste de drivers. Les drivers peuvent être téléchargés depuis l'outil, et celui-ci propose un script Python permettant de rechercher d'autres drivers. Get-Drivers ne contient pas beaucoup de drivers en local, mais des liens qui permettent une meilleure portabilité. Il est aussi possible d'ajouter ses propres drivers manuellement dans '.\Drivers\Nom_Du_Fabricant_de_drivers\Mon_Driver_local_exe'. Les formats de drivers supportés sont actuellement <span style="color: #0EE400;">EXE, ZIP, MSI</span>.

-------------

























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
  </style>


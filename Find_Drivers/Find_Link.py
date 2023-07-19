import Creat_List_Of_Valid_Download_Link
import Find_Drivers_Link_On_Web_Page
import re
import requests
from bs4 import BeautifulSoup
from urllib.parse import urljoin

# Récupère les URL du site entré et les ajoute à une liste

# URL du site web contenant les liens de téléchargement des pilotes MSI
base_url = "https://www.touslesdrivers.com"
url = "https://www.touslesdrivers.com/index.php?v_page=25&v_moteur=tld&v_mots=Drivers"

# Liste pour stocker les liens et les noms des fichiers
file_links = []

print("Début de la recherche de Drivers !")

def process_page(url):
    # Faire une requête HTTP GET à l'URL
    response = requests.get(url)

    # Créer un objet BeautifulSoup pour analyser le contenu HTML de la page
    soup = BeautifulSoup(response.text, "html.parser")

    # Trouver tous les éléments <a> qui contiennent les liens de téléchargement
    download_links = soup.find_all("a", href=True)

    # Vérifier que la requête s'est effectuée avec succès
    if response.status_code == 200:

        # Parcourir les liens de téléchargement
        for link in download_links:
            # Obtenir le lien de téléchargement
            file_link = link["href"]

            # Obtenir le nom du fichier à partir de l'attribut "title" ou du texte du lien
            file_name = link.get("title") or link.text

            # Vérifier si le lien ressemble à '/index.php?v_page=*&v_code=*'
            if "/index.php?v_page=" in file_link and "&v_code=" in file_link:
                # Ajouter le préfixe 'https://www.touslesdrivers.com' à l'URL
                file_link = urljoin(base_url, file_link)

                # Ajouter le nom du fichier et l'URL à la liste
                file_links.append((file_name, file_link))

        # Écrire les noms des fichiers et les URL concaténées dans un fichier (ajouter au lieu d'écraser)
        with open("Valid_Link.txt", "a") as file:
            for file_name, file_link in file_links:
                file.write(f"Nom du fichier : '{file_name}'\n")
                file.write(f"URL : {file_link}\n")


        # Afficher un message indiquant que les résultats ont été ajoutés dans le fichier
        print(3 * ".", end="")

    else:
        print("La requête GET a échoué.")

# Appeler la fonction de traitement de la page pour la première URL
process_page(url)

# Lire le contenu du fichier Valid_Link.txt
with open("Valid_Link.txt", "r") as file:
    content = file.read()

# Utiliser une expression régulière pour extraire les URLs et les noms correspondants
matches = re.findall(r"URL : (https?://\S+)", content)
names = re.findall(r"Nom du fichier : '([^']+)\'", content)

# Appeler la fonction de traitement de la page pour les URLs restantes

for url, name in zip(matches, names):
    process_page(url)
    

# Appeler les fonctions appropriées ici selon votre intention
Find_Drivers_Link_On_Web_Page.Find_Drivers_Link_On_Web_Page()
Creat_List_Of_Valid_Download_Link.Creat_List_Of_Valid_Download_Link()
with open("ok.txt", "w") as file:
    pass

#exit(0)
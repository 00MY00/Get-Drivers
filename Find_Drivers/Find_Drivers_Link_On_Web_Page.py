import re
import requests
from bs4 import BeautifulSoup
from urllib.parse import urljoin

# Récuperation des URL crée par Find_Link.py et récuperation d'information sur la page 
# pour crée une url pouvent contenir un download

def Find_Drivers_Link_On_Web_Page():

    # Fonction pour récupérer les liens correspondants à partir du contenu HTML
    def get_matching_links(content):
        soup = BeautifulSoup(content, "html.parser")
        link_elements = soup.find_all("a")
        
        matching_links = []
        regex_pattern = r"javascript:fenetre\('telechargement','(\w+)','(\w+)'\);"
        
        for link in link_elements:
            link_url = link.get("href")
            
            if link_url and re.match(regex_pattern, link_url):
                matching_links.append(link_url)
        
        return matching_links

    # Lire le contenu du fichier Valid_Link.txt
    with open("Valid_Link.txt", "r") as file:
        content = file.read()

    # Utiliser une expression régulière pour extraire les URLs et les noms correspondants
    matches = re.findall(r"URL : (https?://\S+)", content)
    names = re.findall(r"Nom du fichier : '([^']+)\'", content)

    # Liste pour stocker les URLs uniques
    unique_urls = []

    # Parcourir les URLs avec leurs noms correspondants
    for url, names in zip(matches, names):

        # Vérifier si l'URL est déjà dans la liste des URLs uniques
        if url in unique_urls:
            #print("URL en double détectée :", url)
            continue

        # Ajouter l'URL à la liste des URLs uniques
        unique_urls.append(url)

        # Afficher l'URL et son nom si elle est disponible
        #print("URL récupérée :", url)

        # Envoyer une requête GET à l'URL
        response = requests.get(url)

        # Vérifier que la requête s'est effectuée avec succès
        if response.status_code == 200:
            # Obtenir le contenu HTML de la page
            html_content = response.text
            
            # Récupérer les liens correspondants
            matching_links = get_matching_links(html_content)
            

            # Extraire les paramètres des liens correspondants
            for link in matching_links:
                matches = re.findall(r"javascript:fenetre\('telechargement','(\w+)','(\w+)'\);", link)
                if matches:
                    variable1 = matches[0][0]
                    variable2 = matches[0][1]
                    # Créer la nouvelle URL en complétant les variables
                    new_url = f"https://www.touslesdrivers.com/php/constructeurs/telechargement.php?v_code={variable1}&v_langue={variable2}"
                    #print(f"Nom : {names}")  # Affiche le nom correspondant à l'URL
                    #print(f"URL : {new_url}")
                    print(1 * ".", end="")

                    # Écrire les variables names et new_url dans un fichier
                    with open("Valid_Download_Link.txt", "a") as output_file:
                        output_file.write(f"Nom du fichier : '{names}'\n")
                        output_file.write(f"URL : {new_url}\n")
                    output_file.close()
        else:
            print("La requête GET a échoué.")
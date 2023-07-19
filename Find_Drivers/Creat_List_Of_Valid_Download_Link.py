import re
import requests
from bs4 import BeautifulSoup

def Creat_List_Of_Valid_Download_Link():
    import re
    import requests
    from bs4 import BeautifulSoup

    # Lire le contenu du fichier Valid_Link.txt
    with open("Valid_Download_Link.txt", "r") as file:
        content = file.read()

    # Utiliser une expression régulière pour extraire les URLs et les noms correspondants
    matches = re.findall(r"URL : (https?://\S+)", content)
    name = re.findall(r"Nom du fichier : '([^']+)\'", content)
    # Liste pour stocker les URLs uniques
    unique_urls = []

    for url, name in zip(matches, name):
        # Envoyer une requête GET à l'URL
        response = requests.get(url)

        # Vérifier que la requête s'est effectuée avec succès
        if response.status_code == 200:
            # Obtenir le contenu HTML de la page
            html_content = response.text

            # Créer un objet BeautifulSoup à partir du contenu HTML
            soup = BeautifulSoup(html_content, "html.parser")

            # Trouver tous les éléments <a> de la page
            link_elements = soup.find_all("a")

            # Parcourir les éléments <a> et afficher leur contenu
            for link in link_elements:
                # Récupérer l'URL du lien
                link_url = link.get("href")

                # Vérifier si l'URL contient "https://fichiers.touslesdrivers.com/"
                if link_url and "https://fichiers.touslesdrivers.com/" in link_url:
                    # Afficher l'URL du lien
                    print(f"URL du lien : {link_url}")

                    # Écrire les variables name et link_url dans un fichier
                    with open("Nouvel_List.txt", "a") as output_file:
                        output_file.write(f"Nom du fichier : '{name}'\n")
                        output_file.write(f"URL : {link_url}\n")

        else:
            print("La requête GET a échoué.")

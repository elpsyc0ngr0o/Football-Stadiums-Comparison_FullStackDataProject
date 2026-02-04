# Football-Stadiums-Comparison_FullStackDataProject
Projet data end-to-end dans le but d'analyser la capacité des stades de football dans le monde entier : Python → Azure Data Lake & Data Factory → Synapse Analytics SQL & Tableau. Automatisation de la pipeline via Airflow.

<img width="781" height="707" alt="image" src="https://github.com/user-attachments/assets/8a842519-4acc-4062-913e-9f0604cc04b3" />

1ère partie automatisée avec Airflow : Scraping des données avec BeautifulSoup -> Obtention des latitudes/longitudes avec ArcGIS Geocoder -> Normalisation et formatage avec pandas -> Envoi du CSV vers Azure Data Lake.
2ème partie : Transformation du fichier CSV en Parquet dans Data Factory -> Analyse des données via SQL dans Synapse Analytics -> Création d'un dashboard dans Tableau.

# Valorisation des données OISON et PMCC de l'OFB
## Description du projet
### Assets
Elements concernants les espèces et les limites administratives
Les assets sont utilisées à la fois directement dans le Rmarkdown mais aussi pour générer des fichiers intermédiaires dans processed_data.
### Output
Sorties des rapports. Vous trouverez un aperçu du rapport régional des Hauts-de-France.
### Processed_data
Fichiers intémédiaires créés à partir des scripts et des fichiers dans assets et raw_data.
### Raw_data
Le géopackage OISON (version mars 2024). Un excel PMCC et le csv de la première feuille du excel.
### Scripts
- 0_chargement_packages
- 0_importations_statuts_especes
- 1_importation_communes_departements
- 1_importation_listes_rouge : importation des espèces menacées et envahissantes dans les Hauts-de-France du dossier assets
- 1_importation_OISON : mise en forme du fichier OISON
- 1_importation_PMC : mise en forme du fichier PMC
- 2_assemblage_bases : script le plus important permettant de faire le lien entre toutes les bases (ajout des espèces protégées dans les Hauts-de-France)

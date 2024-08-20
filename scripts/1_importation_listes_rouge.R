# Lire les fichiers des espèces en liste rouge
#Ajouter pour chaque fichier un identifiant "Origine_LR" pour retrouver l'origine après

# Importation type de fichier 1
monde_toute_especes <- read.table("assets/listes_rouge/monde_toute_especes.csv", header=TRUE , sep=";", fill=TRUE, row.name=NULL, na.strings = "")
monde_toute_especes$Origine_LR <- "monde_toute_especes"

europe_toute_especes <- read.table("assets/listes_rouge/europe_toute_especes.csv", header=TRUE , sep=";", fill=TRUE, row.name=NULL, na.strings = "")
europe_toute_especes$Origine_LR <- "europe_toute_especes"

fr_toute_especes <- read.table("assets/listes_rouge/fr_toute_especes.csv", header=TRUE , sep=";", fill=TRUE, row.name=NULL, na.strings = "")
fr_toute_especes$Origine_LR <- "fr_toute_especes"

fr_poissons_eau_douce <- read.table("assets/listes_rouge/fr_poissons_eau_douce.csv", header=TRUE , sep=";", fill=TRUE, row.name=NULL, na.strings = "")
fr_poissons_eau_douce$Origine_LR <- "fr_poissons_eau_douce"

fr_crustaces_eau_douce <- read.table("assets/listes_rouge/fr_crustaces_eau_douce.csv", header=TRUE , sep=";", fill=TRUE, row.name=NULL, na.strings = "")
fr_crustaces_eau_douce$Origine_LR <- "fr_crustaces_eau_douce"

nord_airaignees <- read.table("assets/listes_rouge/nord_airaignees.csv", header=TRUE , sep=";", fill=TRUE, row.name=NULL, na.strings = "")
nord_airaignees$Origine_LR <- "nord_airaignees"

nord_amphibiens_reptiles <- read.table("assets/listes_rouge/nord_amphibiens_reptiles.csv", header=TRUE , sep=";", fill=TRUE, row.name=NULL, na.strings = "")
nord_amphibiens_reptiles$Origine_LR <- "nord_amphibiens_reptiles"

nord_odonates <- read.table("assets/listes_rouge/nord_odonates.csv", header=TRUE , sep=";", fill=TRUE, row.name=NULL, na.strings = "")
nord_odonates$Origine_LR <- "nord_odonates"

hdf_flore <- read.table("assets/listes_rouge/hdf_flore.csv", header=TRUE , sep=";", fill=TRUE, row.name=NULL, na.strings = "")
hdf_flore$Origine_LR <- "hdf_flore"

picardie_faune <- read.table("assets/listes_rouge/picardie_faune.csv", header=TRUE , sep=";", fill=TRUE, row.name=NULL, na.strings = "")
picardie_faune$Origine_LR <- "picardie_faune"

#Noms différents aussi
fr_especes_envahissantes <- read.table("assets/fr_especes_envahissantes.csv", header=TRUE , sep=";", fill=TRUE, row.name=NULL)
fr_especes_envahissantes$Origine_LR <- "fr_especes_envahissantes"

# Importation type de fichier 2
hdf_mollusques <- read.table("assets/listes_rouge/hdf_mollusques.csv", header=TRUE , sep=";", na.strings = "")
hdf_mollusques$Origine_LR <- "hdf_mollusques"

hdf_oiseaux_nicheurs <- read.table("assets/listes_rouge/hdf_oiseaux_nicheurs.csv", header=TRUE , sep=";", na.strings = "")
hdf_oiseaux_nicheurs$Origine_LR <- "hdf_oiseaux_nicheurs"

hdf_papillons_de_jour <- read.table("assets/listes_rouge/hdf_papillons_de_jour.csv", header=TRUE , sep=";", na.strings = "")
hdf_papillons_de_jour$Origine_LR <- "hdf_papillons_de_jour"

# Renommer les colonnes pour faire correspondre les bases
hdf_mollusques <- hdf_mollusques %>% 
  rename(CD_NOM = CDNOM,
         STATUT = CATEGORIE_HAUTS.DE.FRANCE,
         NOM_CITE = NOM_SCIENTIFIQUE)

hdf_oiseaux_nicheurs <- hdf_oiseaux_nicheurs %>% 
  rename(CD_NOM = CDNOM,
         STATUT = CATEGORIE_HAUTS.DE.FRANCE,
         NOM_CITE = NOM_SCIENTIFIQUE)

hdf_papillons_de_jour <- hdf_papillons_de_jour %>% 
  rename(CD_NOM = CDNOM,
         STATUT = CATEGORIE_HAUTS.DE.FRANCE,
         NOM_CITE = NOM_SCIENTIFIQUE)

fr_especes_envahissantes <- fr_especes_envahissantes %>% 
  rename(STATUT = Statut.,
         NOM_CITE = Nom.de.référence)

# Ne garder que les colonnes CD_NOM, NOM_CITE, STATUT et Origine_LR
monde_toute_especes <- monde_toute_especes %>% select(CD_NOM, NOM_CITE, STATUT, Origine_LR)
europe_toute_especes <- europe_toute_especes %>% select(CD_NOM, NOM_CITE, STATUT, Origine_LR)
fr_toute_especes <- fr_toute_especes %>% select(CD_NOM, NOM_CITE, STATUT, Origine_LR)
fr_crustaces_eau_douce <- fr_crustaces_eau_douce %>% select(CD_NOM, NOM_CITE, STATUT, Origine_LR)
fr_poissons_eau_douce <- fr_poissons_eau_douce %>% select(CD_NOM, NOM_CITE, STATUT, Origine_LR)
nord_airaignees <- nord_airaignees %>% select(CD_NOM, NOM_CITE, STATUT, Origine_LR)
nord_amphibiens_reptiles <- nord_amphibiens_reptiles %>% select(CD_NOM, NOM_CITE, STATUT, Origine_LR)
nord_odonates <- nord_odonates %>% select(CD_NOM, NOM_CITE, STATUT, Origine_LR)
hdf_flore <- hdf_flore %>% select(CD_NOM, NOM_CITE, STATUT, Origine_LR)
picardie_faune <- picardie_faune %>% select(CD_NOM, NOM_CITE, STATUT, Origine_LR)
fr_especes_envahissantes <- fr_especes_envahissantes %>% select(CD_NOM, NOM_CITE, STATUT, Origine_LR)
hdf_mollusques <- hdf_mollusques %>% select(CD_NOM, NOM_CITE, STATUT, Origine_LR)
hdf_oiseaux_nicheurs <- hdf_oiseaux_nicheurs %>% select(CD_NOM, NOM_CITE, STATUT, Origine_LR)
hdf_papillons_de_jour <- hdf_papillons_de_jour %>% select(CD_NOM, NOM_CITE, STATUT, Origine_LR)

# Combiner les bases de données dans l'ordre des dates (et en dernier la liste fr_toute_especes)
liste_rouge <- bind_rows(hdf_mollusques,
                         hdf_oiseaux_nicheurs,
                         hdf_papillons_de_jour,
                         fr_poissons_eau_douce,
                         hdf_flore,
                         nord_airaignees,
                         nord_amphibiens_reptiles,
                         picardie_faune,
                         nord_odonates,
                         fr_crustaces_eau_douce,
                         fr_toute_especes,
                         europe_toute_especes,
                         monde_toute_especes,
                         fr_especes_envahissantes)

# Gérer les doublons CD_REF en priorisant les premiers dans la liste de bind_rows(...)
liste_rouge <- liste_rouge %>% distinct(CD_NOM, .keep_all = TRUE)

# Output liste_rouge
write.csv(liste_rouge, "processed_data/liste_rouge.csv", row.names=FALSE)
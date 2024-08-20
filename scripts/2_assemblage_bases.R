#Assemblage des bases

################### PMC - OISON #################################

#Importation OISON
OISON <- st_read("processed_data/OISON.gpkg")

#Importation PMC
PMC <- st_read("processed_data/PMC.gpkg")

#Jointure
OISON_PMC <- bind_rows(OISON,PMC)

################### COMMUNES #################################

#Importation communes
communes <- st_read("processed_data/communes.gpkg")

# Jointure spatiale pour  les communes les plus proches des points "geom"
#(le departement est deja dans le fichier communes.csv)
OISON_PMC <- OISON_PMC %>% 
  st_join(communes, join = st_nearest_feature)

################### LISTE ROUGE #################################
# Importation liste rouge
liste_rouge <- read.csv("processed_data/liste_rouge.csv", na = c("")) %>%
  rename(cd_nom = CD_NOM, statut_LR = STATUT, NOM_LR = NOM_CITE) %>%
  mutate(cd_nom = as.character(cd_nom))

# Effectuer la jointure avec left_join et catégoriser les espèces menacées...
OISON_PMC <- OISON_PMC %>%
  left_join(liste_rouge, by = "cd_nom") %>%
  relocate(statut_LR, .after = GROUP2_INPN) %>%
  relocate(NOM_LR, .after = nom_scientifique) %>%
  relocate(Origine_LR, .after = statut_LR) %>% 
  mutate(
    statut_LR = case_when(
      is.na(statut_LR) ~ NA_character_,
      statut_LR == "J" ~ "envahissante",
      statut_LR %in% c("RE", "EN", "VU", "CR", "CR*") ~ "menacée",
      TRUE ~ "normale"
    )
  )

# Voir les valeurs de statut_LR uniques
unique(OISON_PMC$statut_LR)
unique(liste_rouge$statut_LR)

################### LISTE ESPECES PRO #################################

liste_especes_pro <- read.csv("processed_data/liste_especes_pro.csv") %>% 
  select(CD_NOM,Nom.valide) %>% 
  rename(cd_nom=CD_NOM,Nom_espece_pro=Nom.valide) %>% 
  mutate(espece_pro="protégée") %>% 
  mutate(cd_nom=as.character(cd_nom))

OISON_PMC <- OISON_PMC %>% 
  left_join(liste_especes_pro) %>% 
  mutate(espece_pro = replace_na(espece_pro, "non protégée")) %>% 
  relocate(espece_pro,.after=Origine_LR) %>% 
  relocate(Nom_espece_pro,.after=NOM_LR)

################### SAUVEGARDE ###############################

# Sauvegarder le résultat
st_write(OISON_PMC, "processed_data/OISON_PMC.gpkg", append = FALSE)


################### VERIFIER LA REDONDANCE cd_nom ######################

# 1) Afficher les noms scientifiques

#noms_scientifique <- OISON_PMC %>%
#  group_by(nom_scientifique) %>%
#  summarise(count = n()) %>%
#  filter(count > 1)

# Puis 2) Affichier les cd_nom differents pour un même nom_scientifique (resultat = 0)

#noms_diff_cd_nom <- OISON_PMC %>%
#  group_by(nom_scientifique) %>%
#  summarise(cd_nom_unique = n_distinct(cd_nom)) %>%
#  filter(cd_nom_unique > 1)

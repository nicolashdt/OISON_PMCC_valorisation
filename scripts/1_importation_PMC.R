#Importation "especes_pmc" pour faire correspondre les noms d'espèces à un code nom et un nom scientifique

especes_PMC <- read.csv2("assets/especes_pmc.csv", fileEncoding = "latin1") %>% 
  mutate(cd_nom = as.character(cd_nom))

#Importation des données PMCC
PMC <- read.csv2("raw_data/PMC_brute.csv", fileEncoding = "latin1") #Prendre à partir du serveur

PMC <- PMC %>% 
  filter(!is.na(X_L93)) %>% 
  mutate(annee = as.integer(substr(Date, 7, 10))) %>% 
  mutate(INSEE_DEP = str_extract(Département, "\\d+")) %>% 
  rename(INSEE_COM=Insee_Commune) %>% 
  mutate(GROUP2_INPN = "PMC") %>%   # groupe d'espèce = PMC
  stringdist_join(especes_PMC, by = c("Espèce" = "nom_vernaculaire"), method = "jw", max_dist = 0.1) %>% 
  select(annee,
         Observateur,
         cd_nom,
         nom_scientifique,
         nom_vernaculaire,
         GROUP2_INPN,
         X_L93,
         Y_L93
         ) %>% 
  st_as_sf(coords = c("X_L93", "Y_L93"), crs = 2154) # 2154 est le code EPSG pour Lambert 93

# Sauvegarder en GeoPackage
st_write(PMC, "processed_data/PMC.gpkg", driver = "GPKG",append=FALSE)  

# Importation des fichiers COMMUNE.gpkg et DEPARTEMENT.gpkg

departements <- st_read("assets/limites_administratives/DEPARTEMENTS.gpkg") %>% 
  
  select(INSEE_DEP,
         NOM,
         geom) %>% 
  
  rename(Departement=NOM)

communes <- st_read("assets/limites_administratives/COMMUNES.gpkg") %>% 
  
  select(code_insee_du_departement,
         code_insee,
         nom_officiel,
         geom) %>% 
  
  rename(INSEE_DEP=code_insee_du_departement,
         INSEE_COM=code_insee,
         Commune=nom_officiel)

st_write(communes, "processed_data/communes.gpkg",append=FALSE)
st_write(departements, "processed_data/departements.gpkg",append=FALSE)
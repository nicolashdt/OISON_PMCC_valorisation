#Permet de retrouver les GROUP2_INP à partir du cd_nom
#Script à lancer avant "importation_OISON"

statuts_especes <- read.csv ("assets/statuts_especes.csv") %>% 
  select(CD_NOM,GROUP2_INPN) %>% 
  rename(cd_nom=CD_NOM) %>% 
  mutate(cd_nom = as.character(cd_nom)) %>% 
  group_by(cd_nom) %>%
  slice(1)

write.csv(statuts_especes, file= "processed_data/statuts_especes_simple.csv", row.names=FALSE)
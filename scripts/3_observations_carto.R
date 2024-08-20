# Importation OISON_PMC
OISON_PMC <- st_read("processed_data/OISON_PMC.gpkg")

# Importation communes
communes <- st_read("processed_data/communes.gpkg")

# Importation departements
departements <- st_read("processed_data/departements.gpkg")


###############################################
#          Carte par commune
###############################################

#
observations_par_commune <- OISON_PMC %>% 
  group_by(annee,INSEE_DEP,INSEE_COM) %>%
  summarise(observations = n()) %>%
  filter(annee >= 2020) %>% 
  st_set_geometry(NULL) %>% 
  right_join(communes) %>% 
  group_by(INSEE_COM) %>%
  slice(1)

class_intervals <- classIntervals(observations_par_commune$observations, n = 5, style = "jenks")

ggplot(observations_par_commune) +
  geom_sf(aes(geometry = geom, fill = observations), lwd = 0.05, color = "lightgrey") +
  geom_sf(data = departements, fill = NA, color = "black", lwd = 0.5) +
  scale_fill_fermenter(
    name = "Nombre de saisies par commune depuis 2020",
    type = "seq",
    direction = 1,
    palette = "Reds",
    na.value = "white",
    breaks = class_intervals$brks
  ) +
  theme_minimal()

###############################################
#             Carte de chaleur
###############################################

colors_statut <- c("envahissante" = "#E41A1C",   # Rouge
                   "protégée" = "#377EB8",      # Bleu
                   "normal" = "#4DAF4A"        # Vert
                   )

observations_chaleur <- OISON_PMC %>% 
  filter(annee >= 2020)

ggplot(observations_chaleur) +
  geom_sf(aes(geometry = geom), lwd = 0.5, color = "red",alpha=0.2,size=3)+
  geom_sf(data = departements, fill = NA, color = "black", lwd = 0.5)+
  labs(title="Saisies depuis 2020 (OISON+PMC)")+
  theme_minimal()

ggplot(observations_chaleur) +
  geom_sf(aes(geometry = geom, color = statut_LR), lwd = 0.5, alpha = 0.3, size = 3, shape = 19) +
  geom_sf(data = departements, fill = NA, color = "black", lwd = 0.5) +
  scale_color_manual(values = colors_statut, name = "Statut espèces") +
  labs(title = "Saisies depuis 2020 (OISON+PMC)") +
  theme_minimal()

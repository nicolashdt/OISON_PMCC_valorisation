#Importation OISON_PMC
OISON_PMC <- st_read("processed_data/OISON_PMC.gpkg")

###############################################
#  Evolution de la saisie par groupe d'espèce
###############################################
colors_esp <- c(
  "Arachnides" = "#E41A1C",      # Rouge vif
  "Autres" = "#377EB8",          # Bleu foncé
  "Reptiles" = "#4DAF4A",        # Vert
  "Poissons" = "#984EA3",        # Violet foncé
  "Angiospermes" = "#FF7F00",    # Orange
  "Amphibiens" = "#FFFF33",      # Jaune vif
  "Insectes" = "#A65628",        # Brun
  "Mammifères" = "#F781BF",      # Rose
  "PMC" = "#D8B365",             # Brun clair
  "Crustacés" = "#66C2A5",       # Vert turquoise
  "Oiseaux" = "#3288BD"          # Bleu clair
)

colors_dep <- c(
  "02" = "#FF6F61",   # Coral
  "80" = "#6B5B95",   # Purple
  "62" = "#88B04B",   # Greenery
  "59" = "#F7CAC9",   # Rose Quartz
  "60" = "#92A8D1"    # Serenity
)

#
groupes_espece_par_annee <- OISON_PMC %>% 
  group_by(annee,GROUP2_INPN) %>% 
  summarise(nb_saisies = n()) %>% 
  st_set_geometry(NULL) %>% 
  filter(annee >= 2020) %>%
  arrange(desc(nb_saisies))

# Ordre des espèces dans la légende décroissante
groupes_espece_par_annee$GROUP2_INPN <- factor(groupes_espece_par_annee$GROUP2_INPN, 
                                               levels = unique(groupes_espece_par_annee$GROUP2_INPN))

# Graphique
ggplot(groupes_espece_par_annee) +
  aes(x = annee, y = nb_saisies, colour = GROUP2_INPN) +
  geom_smooth(se = FALSE) +
  scale_colour_manual(values = colors_esp) +
  labs(x = "Années",
       y = "Nombre de saisies",
       colour = "Groupes d'espèce",
       title = "Evolution du nombre de saisies par groupe d'espèce (OISON+PMC)") +
  theme_minimal()

######################################################
#   Proportion de groupes d'espèces par département
######################################################

# Graphique Radar
ggplot(OISON_PMC) +
  aes(x = GROUP2_INPN, fill = INSEE_DEP) +
  geom_bar(position = "fill") +
  scale_fill_manual(values = colors_dep) +
  labs(
    x = "",
    y = "",
    fill = "Départements",
    title = "Proportion des groupes d'espèces par département (OISON+PMC)"
  ) +
  coord_polar(theta = "x") +
  theme_minimal()

groupes_espece_radar <- OISON_PMC %>% 
  group_by(GROUP2_INPN,INSEE_DEP) %>% 
  summarise(nombre_saisies=n()) %>% 
  st_set_geometry(NULL)


###############################################
# Proportion des saisies par groupe d'espèce
###############################################

#
groupes_espece <- OISON_PMC %>% 
  group_by(GROUP2_INPN) %>% 
  summarise(nb_saisies = n()) %>% 
  st_set_geometry(NULL) %>% 
  arrange(nb_saisies) %>% 
  mutate(pourcentage = round((nb_saisies / sum(nb_saisies)) * 100)) %>% 
  mutate(cumulative = pourcentage / 2 + c(0, cumsum(pourcentage)[-length(pourcentage)]))

# Ordre des espèces décoissant  
groupes_espece$GROUP2_INPN <- groupes_espece$GROUP2_INPN %>% 
  factor(levels = rev(groupes_espece$GROUP2_INPN))

# Graphique Camembert
ggplot(groupes_espece)+
  aes(x = factor(1), y = pourcentage, fill = GROUP2_INPN) +
  geom_bar(width = 1, stat = "identity", color = "white") +
  coord_polar(theta = "y")+
  theme_void()+
  scale_fill_manual(values = colors_esp) +
  
  geom_text(data=tail(groupes_espece,4),
            aes(x = 1.7, 
                y = cumulative, 
                label=paste(GROUP2_INPN,"\n",pourcentage, "%"))
            )+
  labs(
    fill = "Groupes d'espèce",
    title = "Proportion des saisies par groupe d'espèce depuis 2020 (OISON+PMC)"
    )

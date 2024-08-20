#Importation OISON_PMC
OISON_PMC <- st_read("processed_data/OISON_PMC.gpkg")

##LES COULEURS

colors_dep <- c(
  "02" = "#FF6F61",   # Coral
  "80" = "#6B5B95",   # Purple
  "62" = "#88B04B",   # Greenery
  "59" = "#F7CAC9",   # Rose Quartz
  "60" = "#92A8D1"    # Serenity
)

###############################################
#      Saisies par annee par departement
###############################################

# Compter le nombre de saisies par année et département
saisies <- OISON_PMC %>% 
  group_by(annee, INSEE_DEP) %>%
  summarise(nombre_saisies = n()) %>%
  st_set_geometry(NULL) %>% 
  filter(annee >= 2020)

saisie_derniere_annee <- saisies %>% 
  filter(annee == max(saisies$annee)) %>% 
  arrange(nombre_saisies) %>% 
  mutate(pourcentage = round((nombre_saisies / sum(nombre_saisies)) * 100)) %>% 
  mutate(cumulative = pourcentage / 2 + c(0, cumsum(pourcentage)[-length(pourcentage)]))

saisie_derniere_annee$INSEE_DEP <- saisie_derniere_annee$INSEE_DEP %>% 
  factor(levels = rev(saisie_derniere_annee$INSEE_DEP))

saisies$INSEE_DEP <- saisies$INSEE_DEP %>% 
  factor(levels = rev(saisie_derniere_annee$INSEE_DEP))

total_saisies <- sum(saisie_derniere_annee$nombre_saisies)

# Graphique courbes
ggplot(saisies) +
  aes(x = annee, y = nombre_saisies, fill = INSEE_DEP) +
  geom_area() +
  scale_fill_manual(values = colors_dep) +
  labs(
    x = "Années",
    y = "Nombre de saisies",
    fill = "Départements",
    title = "Evolution du nombre de saisies par département (OISON+PMC)"
  ) +
  geom_text(data = filter(saisies, annee == max(saisies$annee)),
            aes(label = nombre_saisies, x = annee + 0.2),
            position = position_stack(vjust = 0.5)) +
  theme_minimal()

#histogramme des departements par annee
saisies_histo <- saisies
saisies_histo$annee <- as.factor(saisies_histo$annee)

ggplot(saisies_histo) +
  aes(x = INSEE_DEP, y = nombre_saisies, fill = annee) +
  geom_col(position = "dodge2") +
  scale_fill_brewer(palette = "Blues") +
  labs(
    x = "Départements",
    y = "Nombre de saisies",
    fill = "Années"
  ) +
  theme_minimal()+
  guides(fill = guide_legend(reverse = TRUE))


# Graphique Camembert répartition pour la dernière année
ggplot(saisie_derniere_annee) +
  aes(x = factor(1), y = pourcentage, fill = INSEE_DEP) +
  geom_bar(width = 1, stat = "identity", color = "white") +
  scale_fill_manual(values = colors_dep) +
  coord_polar(theta = "y") +
  theme_void() +
  geom_text(aes(x = 1.2, 
                y = cumulative, 
                label = paste(nombre_saisies, "\n", pourcentage, "%"))
  ) +
  labs(
    fill = "Départements",
    title = paste("Saisies sur l'année", max(saisies$annee), "(OISON+PMC)")
  )

###############################################
#   Nombre d'observateurs par année et département
###############################################

observateurs <- OISON_PMC %>% 
  group_by(annee, INSEE_DEP) %>%
  summarise(nombre_observateurs = n_distinct(Observateur)) %>% 
  st_set_geometry(NULL) %>% 
  filter(annee >= 2020)

observateurs_derniere_annee <- observateurs %>% 
  filter(annee == max(observateurs$annee)) %>% 
  arrange(nombre_observateurs) %>% 
  mutate(pourcentage = round((nombre_observateurs / sum(nombre_observateurs)) * 100)) %>% 
  mutate(cumulative = pourcentage / 2 + c(0, cumsum(pourcentage)[-length(pourcentage)]))

observateurs_derniere_annee$INSEE_DEP <- observateurs_derniere_annee$INSEE_DEP %>% 
  factor(levels = rev(observateurs_derniere_annee$INSEE_DEP))

observateurs$INSEE_DEP <- observateurs$INSEE_DEP %>% 
  factor(levels = rev(observateurs_derniere_annee$INSEE_DEP))

total_observateur <- sum(observateurs_derniere_annee$nombre_observateurs)

# Graphique courbes
ggplot(observateurs) +
  aes(x = annee, y = nombre_observateurs, fill = INSEE_DEP) +
  geom_area() +
  scale_fill_manual(values = colors_dep) +
  labs(
    x = "Années",
    y = "Nombre d'observateurs par année",
    fill = "Départements",
    title = "Evolution du nombre d'observateurs par département (OISON+PMC)"
  ) +
  geom_text(data = filter(observateurs, annee == max(observateurs$annee)),
            aes(label = nombre_observateurs, x = annee + 0.2),
            position = position_stack(vjust = 0.5)) +
  theme_minimal()

# Graphique Camembert pour les observateurs
ggplot(observateurs_derniere_annee) +
  aes(x = factor(1), y = pourcentage, fill = INSEE_DEP) +
  geom_bar(width = 1, stat = "identity", color = "white") +
  scale_fill_manual(values = colors_dep) +
  coord_polar(theta = "y") +
  theme_void() +
  geom_text(aes(x = 1.2, 
                y = cumulative, 
                label = paste(nombre_observateurs, "\n", pourcentage, "%"))
  ) +
  labs(
    fill = "Départements",
    title = paste("Nombre d'observateurs sur l'année", max(observateurs$annee), "(OISON+PMC)")
  )

###############################################
#   Nombre moyen de saisies par observateur par année et département
###############################################

saisies_observateur <- OISON_PMC %>%
  group_by(annee, INSEE_DEP, Observateur) %>%
  summarise(nombre_saisies = n()) %>%
  group_by(annee, INSEE_DEP) %>%
  summarise(moyenne_saisies_observateur = mean(nombre_saisies)) %>%
  st_set_geometry(NULL) %>%
  filter(annee >= 2020)

saisies_observateur_derniere_annee <- saisies_observateur %>% 
  filter(annee == max(saisies_observateur$annee)) %>% 
  arrange(moyenne_saisies_observateur) %>% 
  mutate(pourcentage = round((moyenne_saisies_observateur / sum(moyenne_saisies_observateur)) * 100)) %>% 
  mutate(cumulative = pourcentage / 2 + c(0, cumsum(pourcentage)[-length(pourcentage)]))

saisies_observateur_derniere_annee$INSEE_DEP <- saisies_observateur_derniere_annee$INSEE_DEP %>% 
  factor(levels = rev(saisies_observateur_derniere_annee$INSEE_DEP))

saisies_observateur$INSEE_DEP <- saisies_observateur$INSEE_DEP %>% 
  factor(levels = rev(saisies_observateur_derniere_annee$INSEE_DEP))

saisies_observateur_moy <- OISON_PMC %>%
  group_by(annee, Observateur) %>%
  summarise(nombre_saisies = n()) %>%
  group_by(annee) %>%
  filter(annee == max(saisies_observateur$annee)) %>% 
  summarise(moyenne_saisies_observateur = mean(nombre_saisies)) %>% 
  st_set_geometry(NULL)

# Moyenne totale avec tous les observateurs réunis
moyenne_tot <- round(mean(saisies_observateur_moy$moyenne_saisies_observateur),1)

# Graphique courbes
ggplot(saisies_observateur) +
  aes(x = annee, y = moyenne_saisies_observateur, fill = INSEE_DEP) +
  geom_area() +
  scale_fill_manual(values = colors_dep) +
  labs(
    x = "Années",
    y = "Nombre moyen de saisie par observateur",
    fill = "Départements",
    title = "Evolution du nombre moyen de saisies par observateur par département (OISON+PMC)"
  ) +
  geom_text(data = filter(saisies_observateur, annee == max(saisies_observateur$annee)),
            aes(label = round(moyenne_saisies_observateur,1), x = annee + 0.2),
            position = position_stack(vjust = 0.5)) +
  theme_minimal()

# Graphique Camembert pour les saisies par observateur
ggplot(saisies_observateur_derniere_annee) +
  aes(x = factor(1), y = pourcentage, fill = INSEE_DEP) +
  geom_bar(width = 1, stat = "identity", color = "white") +
  scale_fill_manual(values = colors_dep) +
  coord_polar(theta = "y") +
  theme_void() +
  geom_text(aes(x = 1.2, 
                y = cumulative, 
                label = paste(round(moyenne_saisies_observateur, 1), "\n", pourcentage, "%"))) +
  labs(
    fill = "Départements",
    title = paste("Nombre moyen de saisies par observateur sur l'année", max(saisies_observateur$annee), "(OISON+PMC)")
  )

saisies_observateur2 <- OISON_PMC %>%
  group_by(annee, INSEE_DEP, Observateur) %>%
  summarise(nombre_saisies = n()) %>%
  filter(annee == max(saisies_observateur$annee))

# Créer le boxplot
ggplot(saisies_observateur2, aes(x = factor(INSEE_DEP), y = nombre_saisies)) +
  geom_boxplot(fill = colors_dep, color = "black") +
  stat_summary(fun = mean, geom = "point", shape = 18, size = 3, color = "red", fill = "red") +
  labs(
    x = "Départements",
    y = "Nombre de saisies par observateur",
    title = paste("Nombre de saisies par observateur et département en",max(saisies_observateur$annee), "(OISON+PMC)"),
    caption = "Explications :\n
    - La ligne centrale dans chaque boîte représente la médiane.\n
    - Les extrémités de la boîte représentent les 1er et 3e quartiles (Q1 et Q3).\n
    - Les 'moustaches' s'étendent jusqu'aux points les plus éloignés qui ne sont pas des valeurs aberrantes.\n
    - Les losanges rouges représentent la moyenne."
  ) +
  theme_minimal()+
  theme(plot.caption = element_text(hjust = 0, size = 10, margin = margin(t = 10)))
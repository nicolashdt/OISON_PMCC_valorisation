Picardie_vegetaux <- read.csv2("assets/especes_pro/Picardie_vegetaux.csv")
Nord_vegetaux <- read.csv2("assets/especes_pro/Nord_vegetaux.csv")
FR_escargots <- read.csv2("assets/especes_pro/FR_escargots.csv")
FR_vegetaux <- read.csv2("assets/especes_pro/FR_vegetaux.csv")
FR_écrevisses <- read.csv2("assets/especes_pro/FR_écrevisses.csv")
FR_vegetaux_marins <- read.csv2("assets/especes_pro/FR_vegetaux_marins.csv")
FR_poissons <- read.csv2("assets/especes_pro/FR_poissons.csv")
FR_oiseaux_austral_antartique <- read.csv2("assets/especes_pro/FR_oiseaux_austral_antartique.csv")
FR_esturgeon <- read.csv2("assets/especes_pro/FR_esturgeon.csv")
FR_faune_marine <- read.csv2("assets/especes_pro/FR_faune_marine.csv")
FR_gypaète_barbu <- read.csv2("assets/especes_pro/FR_gypaète_barbu.csv")
FR_insectes <- read.csv2("assets/especes_pro/FR_insectes.csv")
FR_mammiferes_terrestres <- read.csv2("assets/especes_pro/FR_mammiferes_terrestres.csv")
FR_mollusques <- read.csv2("assets/especes_pro/FR_mollusques.csv")
FR_oiseaux <- read.csv2("assets/especes_pro/FR_oiseaux.csv")
FR_mammiferes_marins <- read.csv2("assets/especes_pro/FR_mammiferes_marins.csv")
FR_amphibiens_reptiles <- read.csv2("assets/especes_pro/FR_amphibiens_reptiles.csv")
FR_tortues_marines <- read.csv2("assets/especes_pro/FR_tortues_marines.csv")

liste_especes_pro <- bind_rows( Picardie_vegetaux,
                                Nord_vegetaux,
                                FR_escargots,
                                FR_vegetaux,
                                FR_écrevisses,
                                FR_vegetaux_marins,
                                FR_poissons,
                                FR_oiseaux_austral_antartique,
                                FR_esturgeon,
                                FR_faune_marine,
                                FR_gypaète_barbu,
                                FR_insectes,
                                FR_mammiferes_terrestres,
                                FR_mollusques,
                                FR_oiseaux,
                                FR_mammiferes_marins,
                                FR_amphibiens_reptiles,
                                FR_tortues_marines)

# Gérer les doublons CD_REF en priorisant les premiers dans la liste de bind_rows(...)
liste_especes_pro <- liste_especes_pro %>% distinct(CD_NOM, .keep_all = TRUE)

write.csv(liste_especes_pro,"processed_data/liste_especes_pro.csv", row.names = FALSE)

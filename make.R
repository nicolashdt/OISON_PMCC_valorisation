##%######################################################%##
#                                                          #
####        Bilan réseau PMCC et OISON (OFB HDF)       ####
#                                                          #
##%------------------------------------------------------%##
##%------------------------------------------------------%##  
####                      N.HOUDANT                     ####
####          Stage OFB DR. Hauts-de-France             ####
#                                                          #
##%######################################################%##

##--------------------------------------------------------------------##
## 1. Lancement des scripts

# Ne pas prendre en compte les messages d'avis

source("scripts/0_chargement_packages.R")
source("scripts/0_importation_statuts_especes.R")
source("scripts/1_importation_communes_departements.R")
source("scripts/1_importation_listes_rouge.R")
source("scripts/1_importation_OISON.R")
source("scripts/1_importation_PMC.R")
source("scripts/2_assemblage_bases.R")

##--------------------------------------------------------------------##
## 2. Création des bilans région et départements`avec les paramètres

# Un message s'affiche à l'ouverture des bilans : faire oui

dir.create("output")

list_dep <- c("02","59","80","60","62")

#LES BILANS DEPARTEMENTAUX
purrr:: map(.x = list_dep,   
            .f = ~ 
              rmarkdown::render(input = "templates/Bilan_Départemental_OISON_Rézo-PMCC.Rmd",
                                output_file = paste0("../output/Bilan_SD-", .x, "_OISON_Rézo-PMCC.docx"),
                                params= list(dep = .x, 
                                             annee_fin= 2024,   # CHANGER SI BESOIN
                                             annee_debut= 2020,  # CHANGER SI BESOIN
                                             OISON= 'TRUE',  # mettre "TRUE"/"FALSE" pour prendre en compte les données OISON ou non
                                             PMC= 'TRUE'   # mettre "TRUE"/"FALSE" pour prendre en compte les données PMCC ou non
                                            )))
# LE BILAN REGIONAL
rmarkdown::render(input = "templates/Bilan_Régional_OISON_Rézo-PMCC.Rmd",
                  output_file = paste0("../output/Bilan_Régional_OISON_Rézo-PMCC.docx"),
                  params= list(annee_fin= 2024,   # CHANGER SI BESOIN
                               annee_debut= 2020,  # CHANGER SI BESOIN
                               OISON= 'TRUE',  # mettre "TRUE"/"FALSE" pour prendre en compte les données OISON ou non
                               PMC= 'TRUE'   # mettre "TRUE"/"FALSE" pour prendre en compte les données PMCC ou non
                                ))

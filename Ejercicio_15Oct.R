#Método largo para obtener las 10 principales causas de muerte

library(dplyr)
library(openxlsx)
library(stringr)

setwd("Ruta")

dfMorta22 <- read.csv("conjunto_de_datos_defunciones_registradas_2022.CSV")
View(dfMorta22)
names(dfMorta22)

#Crear una nueva variable en un dataframe usando el verbo mutate (dplyr)
#Vamos a usar una función de cadena (letras, números, caracteres)
#str_sub

dfMorta22 <- dfMorta22 %>% mutate(gr_lismexn = str_sub(gr_lismex,2,3))

# Enfermedades isquémicas del corazón.
totenfisq <- dfMorta22 %>% filter(gr_lismex == ' 28') %>% tally()
#totenfisq <- dfMorta22 %>% filter(lista_mex == '28' 
# | lista_mex == '28A' | lista_mex == '28Z') %>% tally()

totenfisq_h <- dfMorta22 %>% filter(gr_lismex == ' 28') %>% 
  filter(sexo == 1) %>% tally()
totenfisq_m <- dfMorta22 %>% filter(gr_lismex == ' 28' & sexo == 2) %>% 
  tally()
totenfisq_h + totenfisq_m

# Diabetes mellitus
totdb <- dfMorta22 %>% filter(lista_mex == '20D') %>% tally()

totdb_m <- dfMorta22 %>% filter(lista_mex == '20D') %>% 
  filter(sexo == 2) %>% tally()

totdb_h <- dfMorta22 %>% filter(lista_mex == '20D' & sexo == 1) %>% 
  tally()

#Tumores malignos
tottm <- dfMorta22 %>% filter(gr_lismex == ' 08' | 
                              gr_lismex == ' 09' |
                              gr_lismex == ' 10' |
                              gr_lismex == ' 11' |
                              gr_lismex == ' 12' |
                              gr_lismex == ' 13' |
                              gr_lismex == ' 14' |
                              gr_lismex == ' 15') %>% tally()

tottm <- dfMorta22 %>% filter(as.numeric(gr_lismexn)>=8 &
                              as.numeric(gr_lismexn)<=15) %>% tally()

repor_1 <- loadWorkbook(file = "Cuadro1.xlsx", isUnzipped = F)

writeData(repor_1, "Hoja1", totenfisq[[1]], startRow = 10, startCol = 'C', rowNames = F)
writeData(repor_1, "Hoja1", totenfisq_m[[1]], startRow = 10, startCol = 'D', rowNames = F)
writeData(repor_1, "Hoja1", totenfisq_h[[1]], startRow = 10, startCol = 'E', rowNames = F)

saveWorkbook(repor_1, "Cuadro1.xlsx", overwrite = T)

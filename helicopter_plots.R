# Workspace és változók tisztítása
rm(list = ls())

# Konzol tisztítása
cat("\014")

library(interactions)
library(jtools)
library(readxl)
library(sandwich)
library(huxtable)
library(broom.mixed)


heli <- read_excel(".../helicopter.xlsx", sheet = "forR") # helicopter fájl elérési útja, sheet = goodcountries_nooutliers vagy forR


# GDP

fitgdpmodel <- lm(`GDP 2020` ~ `kormányzati kiadások` * `kormányzattal szembeni bruttó követelés` + `2019 reál GDP növekedés` + 
                    `szolgáltatások (GDP százalékában)` + `Covid lezárás index (stringency)`, data = heli)

fitgdpmodel2 <- lm(GDP_2020 ~ kormanyzati_kiadasok * kormanyzattal_szembeni_brutto_kovetelesek + `2019 reál GDP növekedés` + 
                    `szolgáltatások (GDP százalékában)` + `Covid lezárás index (stringency)`, data = heli) # amikor a forR sheet van beolvasva, akkor ez kell


summ(fitgdpmodel1, robust = "HC1", digits = 4) # nem centrált eredmények

# Dolgozatban használt fő ábrák
interact_plot(fitgdpmodel, pred = `kormányzati kiadások`, modx = `kormányzattal szembeni bruttó követelés`, 
              modx.labels = c("-1 szórás", " átlag", "+1 szórás"), line.thickness = 1.5, colors = "blue")


ss <-sim_slopes(fitgdpmodel, pred = `kormányzati kiadások`, modx = `kormányzattal szembeni bruttó követelés`, 
                johnson_neyman = FALSE, robust = "HC1", modx.values = c(-0.28, 0.67, 11.04)) # dolgozatban kiemelt országokhoz tartozó értékek

plot(ss)
as_huxtable(ss)

# Johnson-Neyman interval
# nem tudja beolvasni a goodcountries_nooutliers sheet-ből a változó neveket, forR-rel működik csak
sim_slopes(fitgdpmodel2, pred = kormanyzati_kiadasok, modx = kormanyzattal_szembeni_brutto_kovetelesek, johnson_neyman = TRUE, robust = "HC1")

johnson_neyman(fitgdpmodel2, pred = kormanyzati_kiadasok, modx = kormanyzattal_szembeni_brutto_kovetelesek, alpha = .05)



# INFLÁCIÓ

fitinflation1 <- lm(`infláció 2020` ~ `bruttó adósság` * `kormányzattal szembeni bruttó követelés` + `átlagos infláció (2009-2019)` +
                      `szolgáltatások (GDP százalékában)` + `Covid lezárás index (stringency)`, data = heli)

fitinflation2 <- lm(inflacio_2020 ~ brutto_adossag * kormanyzattal_szembeni_brutto_kovetelesek + `átlagos infláció (2009-2019)` +
                     `2020 reál GDP növekedés` + `szolgáltatások (GDP százalékában)` + `Covid lezárás index (stringency)`, data = heli)


summ(fitinflation1, robust = "HC1", digits = 4)

interact_plot(fitinflation1, pred = `bruttó adósság`, modx = `kormányzattal szembeni bruttó követelés`, 
              modx.labels = c("-1 szórás", " átlag", "+1 szórás"), line.thickness = 1.5)

ss2 <-sim_slopes(fitinflation1, pred = `bruttó adósság`, modx = `kormányzattal szembeni bruttó követelés`, 
                 johnson_neyman = FALSE, robust = "HC1", modx.values = c(-0.28, 0.67, 11.04))

ss2 <-sim_slopes(fitinflation2, pred = brutto_adossag, modx = kormanyzattal_szembeni_brutto_kovetelesek, 
                 johnson_neyman = FALSE, robust = "HC1")

plot(ss2)
as_huxtable(ss2)

# Johnson - Neyman interval

sim_slopes(fitinflation2, pred = brutto_adossag, modx = kormanyzattal_szembeni_brutto_kovetelesek, johnson_neyman = TRUE, robust = "HC1")

johnson_neyman(fitinflation2, pred = brutto_adossag, modx = kormanyzattal_szembeni_brutto_kovetelesek, alpha = .05)


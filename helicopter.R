# Clear the workspace and remove all variables
rm(list = ls())

# Clear the console (optional)
cat("\014")

library(interactions)
library(jtools)
library(readxl)
library(sandwich)
library(huxtable)
library(broom.mixed)


heli <- read_excel("C:/Users/kissr/Downloads/helicopter_ez_gengov.xlsx", sheet = "forR")


# GDP
fitintmodel <- lm(`GDP 2020` ~ `kormányzati kiadások` * `kormányzattal szembeni bruttó követelés` + `2019 reál GDP növekedés` + 
                    `szolgáltatások (GDP százalékában)` + `Covid lezárás index (stringency)`, data = heli)
fitintmodel2 <- lm(GDP_2020 ~ kormanyzati_kiadasok * kormanyzattal_szembeni_brutto_kovetelesek + `2019 reál GDP növekedés` + 
                    `szolgáltatások (GDP százalékában)` + `Covid lezárás index (stringency)`, data = heli)

summ(fitintmodel2, robust = "HC1", digits = 4)

# without confidence intervals
interact_plot(fitintmodel, pred = `kormányzati kiadások`, modx = `kormányzattal szembeni bruttó követelés`, 
              modx.values = "terciles", colors = "black")

# with confidence intervals
interact_plot(fitintmodel, pred = `kormányzati kiadások`, modx = `kormányzattal szembeni bruttó követelés`, interval = TRUE,
              int.width = 0.95)

ss <-sim_slopes(fitintmodel, pred = `kormányzati kiadások`, modx = `kormányzattal szembeni bruttó követelés`, 
                johnson_neyman = FALSE, robust = "HC1", modx.values = c(-0.28, 0.67, 11.04))

plot(ss)
as_huxtable(ss)

# Johnson-Neyman interval
#can't read in the names of the variables from the goodcountries_nooutliers sheet, change it to "forR" and run fitintmodel2
sim_slopes(fitintmodel2, pred = kormanyzati_kiadasok, modx = kormanyzattal_szembeni_brutto_kovetelesek, johnson_neyman = TRUE, robust = "HC1")

johnson_neyman(fitintmodel2, pred = kormanyzati_kiadasok, modx = kormanyzattal_szembeni_brutto_kovetelesek, alpha = .05)

# inflation

fitinflation <- lm(inflacio_3 ~ brutto_adossag * kormanyzattal_szembeni_brutto_kovetelesek + `átlagos infláció (2009-2019)` +
                     `2020 reál GDP növekedés` + `szolgáltatások (GDP százalékában)` + `Covid lezárás index (stringency)`, data = heli)
fitinflation <- lm(`infláció (3 év)` ~ `bruttó adósság` * `kormányzattal szembeni bruttó követelés` + `átlagos infláció (2009-2019)` +
                     `szolgáltatások (GDP százalékában)` + `Covid lezárás index (stringency)`, data = heli)

summ(fitinflation, robust = "HC1", digits = 4)

interact_plot(fitinflation, pred = `bruttó adósság`, modx = `kormányzattal szembeni bruttó követelés`, 
              modx.labels = c("-1 szórás", " átlag", "+1 szórás"), line.thickness = 1.5)

ss2 <-sim_slopes(fitinflation, pred = `bruttó adósság`, modx = `kormányzattal szembeni bruttó követelés`, 
                 johnson_neyman = FALSE, robust = "HC1", modx.values = c(-0.28, 0.67, 11.04))

ss2 <-sim_slopes(fitinflation, pred = brutto_adossag, modx = kormanyzattal_szembeni_brutto_kovetelesek, 
                 johnson_neyman = FALSE, robust = "HC1")

plot(ss2)
as_huxtable(ss2)

sim_slopes(fitinflation, pred = brutto_adossag, modx = kormanyzattal_szembeni_brutto_kovetelesek, johnson_neyman = TRUE, robust = "HC1")

johnson_neyman(fitinflation, pred = brutto_adossag, modx = kormanyzattal_szembeni_brutto_kovetelesek, alpha = .05)


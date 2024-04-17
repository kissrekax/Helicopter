# Helicopter

Ez a repozitórium a 2024. tavaszi Tudományos Diákköri Konferencia (TDK) dolgozatom során felhasznált adatokat és kódokat tartalmazza.

A helicopter_readindata kód a több forrásból származó nyers adatokat olvassa be, transzformálja, majd fűzi egy adatbázisba.
A helicopter.xlsx fájl a helicopter_readindata által előállított végső adatbázis, amit a dolgozatban használtam. 
A helicopter_regressions kód a dolgozatban bemutatott regressziós becsléseket állítja elő.
A helicopter_plots R fájl a dolgozatban bemuatott ábrákat készíti el.

## A nyers adatok beolvasásához az alábbi lépésekre van szükség:

Az elemzés során számos forrásból dolgoztam, először szükséges a nyers adatok letöltése. A forrás (és a forrásban az adott változó kódja a dolgozatban meg van jelölve)
* [ISO ország kódok](https://github.com/lukes/ISO-3166-Countries-with-Regional-Codes/blob/master/all/all.csv)
* [IMF World Economic Outlook 2023 October](https://www.imf.org/en/Publications/WEO/weo-database/2023/October)
* [reál GDP növekedési ütem](https://www.imf.org/external/datamapper/NGDP_RPCH@WEO/OEMDC/ADVEC/WEOWORLD)
* [negyedéves GDP](https://data.imf.org/regular.aspx?key=63122827)
* [infláció](https://data.imf.org/regular.aspx?key=63087884)
* [Monetary and Financial Statistisc (MFS) adatbázis](https://data.imf.org/?sk=b83f71e8-61e3-4cf1-8cf3-6d7fe04d0930&sid=1409151240976)
  - Bejelentkezés után letölthető a teljes adatbázis (bulk download), én panel formában töltöttem, a kód valószínűleg csak ekkor fog működni
* [World Bank adatok](https://data.worldbank.org/indicator?tab=all)
  - Egy csv fájlban letöltve a kívánt változók
* [Covid-19 kontroll adatok](https://github.com/owid/covid-19-data/tree/master/public/data)
* [IMF Covid-19 fiskális kiadások](https://www.imf.org/en/Topics/imf-and-covid19/Fiscal-Policies-Database-in-Response-to-COVID-19)
  - Végül nem használtam fel

Az adatbázisok megfelelő formában való letöltése után csak be kell helyettesíteni a beolvasásnál az elérési utat. Néhány helyen apró változtatások lehetnek szükségesek (ezt a kódban jeleztem).
A kód a "helicopter.xlsx" Excel fájl "original" munkalapját fogja replikálni. Mivel nem minden adatbázisban van megadva egységes ISO kód (és a név sem pontosan egyezik), a végleges összefűzéshez szükséges az Excelben "kézzel" párosítani az ugyanazon országhoz tartozó adatokat. Továbbá vannak számítások (pl. interakciós tag kiszámolása), később bekerült változók, melyek nem a helicopter_readindata kód alapján lettek beolvasva. Ezek képletei a _formulas munkalapon megtekinthetők. Az Excel _justvalues, _nooutliers és _forR munkalapján már a végleges formátumú adatok szerepelnek, amikkel a becslések elvégezhetők. Az Excelben számos olyan adat is van, mely nem került be a dolgozatba (kísérleteztem sok más specifikációval, melyeket különböző okokból nem találtam annyira megfelelőnek, mint a kutatásban felhasználtakat).

## A replikáláshoz, egyéb modellspecifikációk lefuttatásához az alábbiakra van szükség:

A helicopter_regressions fájl már a véglegesített helicopter Excel adataival dolgozik. 
A beolvasásnál szükséges az elérési út módosítása.
Az eredménytáblák előállításához szükséges a Stargazer csomag, mely [ezen a linken](https://github.com/StatsReporting/stargazer/tree/master) érhető el. Minden elismerés a szerzőké, én csak magyarra átírtam a változók nevét (ezért a kód egy másik csomagot tölt be, a Stargazer1 nevűt (ezt a lefuttatáshoz a kódban jelöltek szerint át kell írni Stargazer-re), ami csak annyiban más, hogy magyar nyelvű).
A lefuttatáshoz szükséges további információ a kódba belekommentelve megtalálható.
A különböző specifikációkhoz, időtávokhoz változtatni kell a kódot, a jelöltek szerint.

## Az ábrák elkészítéséhez az alábbiakra van szükség:

Az ábrákat R-ben készítettem, a használt kód feltöltve.
A futtatáshoz több csomagra is szükség lesz, melyek a kód elején jelölve vannak.
A kódok változtatásához, értelmezéséhez lásd [Jacob Long bejegyzését](https://cran.r-project.org/web/packages/interactions/vignettes/interactions.html)

## Kontakt
* Kiss Réka, MNB Intézet, Neumann János Egyetem
* email: kissrekax@gmail.com

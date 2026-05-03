## Nädal 4: SQL Aggregation — numbritest äriotsusteni

### Mida ma tegin

Sellel nädalal keskendusin andmete koondamisele ja analüüsimisele SQL-is. Õppisin kasutama `GROUP BY` lauset, et jagada suur hulk UrbanStyle’i müügiandmeid loogilisteks gruppideks (nt kuude, linnade ja tootekategooriate kaupa).

Arvutasin erinevaid KPI-sid, kasutades agregaatfunktsioone nagu `SUM`, `AVG`, `COUNT`, `MIN` ja `MAX`. Nende abil leidsin näiteks kogukäibe, keskmise tellimuse väärtuse (AOV) ja unikaalsete klientide arvu.

Kasutasin `HAVING` tingimust, et filtreerida juba grupeeritud tulemusi ja leida võimalikke anomaaliaid – näiteks olukordi, kus süsteemi ja tegeliku laoseisu vahe oli ebatavaliselt suur.

Lisaks võtsin kasutusele CTE-d (`WITH`), mis aitasid keerulisemad mitmeastmelised päringud teha loetavamaks ja lihtsamini hallatavaks.

Tutvusin ka aknafunktsioonidega (`OVER`, `ROW_NUMBER`, `LAG`), mille abil koostasin näiteks toodete edetabeleid kategooriate lõikes ning arvutasin müügi muutust ajas (nt kuine kasv võrreldes eelmise kuuga).

Osalesin meeskonnatöös, kus analüüsisime koos müügi koondandmeid ja panime kokku ühise raporti.

Kõik tehtud tööd vormistasin ja lisasin oma GitHubi portfooliosse.

---

### Peamised õppetunnid

Sain selgeks, et `WHERE` filtreerib andmeid enne grupeerimist, samas kui `HAVING` töötab juba koondatud tulemuste peal.

Õppisin, kuidas agregaatfunktsioonid käituvad `NULL` väärtustega (nt `AVG` jätab need arvestusest välja) ning kuidas kasutada `COALESCE`, et vältida ebakorrektseid tulemusi.

Samuti sain paremini aru erinevusest `GROUP BY` ja aknafunktsioonide vahel – esimene koondab read üheks tulemuseks, teine aga lisab koondinfo iga rea juurde, säilitades detailse vaate.

---

### AI kasutamine

Kasutasin ChatGPT-d abivahendina, et paremini aru saada CTE-de ja aknafunktsioonide loogikast. AI aitas mul ka päringuid kontrollida ja vigu leida, eriti `OVER()` ja `PARTITION BY` kasutamisel.

---

### Failid

* [week4_sales_aggregation.sql](./week4_sales_aggregation.sql) – SQL päringud müügi koondandmete analüüsimiseks koos kommentaaridega

---

### Meeskonna töö

* [week4_team_aggregation_report.md](./week4_team_aggregation_report.md) – meeskonna koostatud müügi koondraport

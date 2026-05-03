## Nädal 5: Visualiseerimise disain — andmetest dashboardiks

### Mida ma tegin

Sellel nädalal keskendusin andmete visualiseerimisele ja dashboard’i disainile. Minu eesmärk oli muuta varasemate nädalate SQL analüüsid visuaalseks ja kergesti arusaadavaks ülevaateks.

Lõin stakeholder’i (nt CEO / Marketing / Operations) vajadustest lähtuva dashboard’i, mis vastab konkreetsetele äriküsimustele. Valisin iga küsimuse jaoks sobiva diagrammitüübi (joondiagramm, tulpdiagramm, sektordiagramm, KPI kaart), et info oleks kiiresti hoomatav.

Rakendasin dashboard’i disainipõhimõtteid, nagu visuaalne hierarhia ja Z-muster, et kõige olulisem info oleks nähtav esimesena. Kasutasin KPI kaarte, et tuua välja peamised näitajad (nt kogukäive, klientide arv, kasv).

Lisaks pöörasin tähelepanu data-ink ratio põhimõttele — eemaldasin kõik üleliigsed visuaalsed elemendid (nt liigsed jooned, efektid), et dashboard oleks puhas ja professionaalne.

Lisasin ka filtrid (nt periood, linn, kategooria), mis võimaldavad kasutajal andmeid interaktiivselt uurida ilma eraldi dashboard’e tegemata.

---

### Peamised õppetunnid

Õppisin, et visualiseerimise puhul ei ole kõige olulisem “ilus graafik”, vaid õige graafik õigele küsimusele.

Sain aru, et:

* ajatrendi näitamiseks sobib joondiagramm
* kategooriate võrdlemiseks tulpdiagramm
* osa tervikust näitamiseks sektordiagramm
* ühe olulise numbri jaoks KPI kaart

Lisaks mõistsin, kui oluline on dashboard’i loogiline paigutus — kui info ei ole õigesti struktureeritud, siis ka hea graafik ei aita.

---

### AI kasutamine

Kasutasin ChatGPT-d, et valida sobivaid diagrammitüüpe ja kontrollida dashboard’i loogikat. AI aitas mul ka ideid struktureerida ning veenduda, et visualiseering vastab äriküsimustele.

---

### Failid

* [dashboard_screenshot.png](./dashboard_screenshot.png) – dashboard’i ekraanipilt
* [app.py](./app.py) *(või pbix fail)* – dashboard’i kood / Power BI fail

---

### Lühike selgitus (disainiotsused)

Minu dashboard on üles ehitatud nii, et kasutaja näeb kõigepealt peamisi KPI-sid ning seejärel müügitrendi.

Peamised otsused:

* Joondiagramm näitab müügi muutust ajas (kasvutrend)
* Tulpdiagramm toob välja TOP tooted või kanalid
* Sektordiagramm näitab müügi jaotust (nt linnade või kategooriate lõikes)
* Filtrid võimaldavad vaadet kohandada (nt valida linn või periood)

Selline ülesehitus aitab kasutajal kiiresti aru saada, mis toimub ja miks.

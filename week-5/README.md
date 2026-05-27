## Nädal 5: Visualiseerimise disain — andmetest dashboardiks

### Mida ma tegin

Sellel nädalal keskendusin andmete visualiseerimisele ja dashboard’i loomisele. Minu eesmärk oli muuta varasemate nädalate SQL analüüsid selgeks ja kiiresti arusaadavaks visuaalseks ülevaateks.

Lõin dashboard’i, mis vastab äriküsimustele nagu:

* kas ettevõte kasvab
* millised tooted müüvad kõige paremini
* kust tuleb müügitulu

Valisin iga küsimuse jaoks sobiva diagrammitüübi:

* **joondiagramm** müügitulu trendi näitamiseks ajas
* **tulpdiagramm** TOP toodete võrdlemiseks
* **sektordiagramm** müügi jaotuse kuvamiseks asukohtade lõikes

---

### Dashboard’i ülesehitus ja disain

Dashboard on üles ehitatud loogilise visuaalse hierarhia järgi:

* Ülaosas on pealkiri ja filtrid (periood, linn)
* Keskel on peamine diagramm (müügitulu trend), mis vastab küsimusele “kas me kasvame?”
* All ja kõrval on toetavad graafikud, mis aitavad mõista “miks”

Rakendasin **Z-mustrit**, kus kasutaja pilk liigub vasakult ülevalt paremale ja sealt alla — seetõttu on kõige olulisem info paigutatud nähtavaimasse kohta.

Lisaks kasutasin **data-ink ratio põhimõtet**, eemaldades üleliigsed visuaalsed elemendid (nt liigsed jooned ja efektid), et fookus jääks andmetele.

---

### Äritõlgendus

Dashboard’i põhjal saab teha järgmised järeldused:

* Müügitulu trend näitab perioodilist kõikumist, kuid üldiselt on näha kasvu, mis viitab stabiilsele arengule
* TOP toodete analüüs näitab, millised tooted toovad suurima osa käibest
* Müügi jaotus näitab, et suurim osa tulust tuleb Tallinnast, kuid online kanal on samuti väga oluline

Need järeldused aitavad teha otsuseid, näiteks kuhu suunata turundust või milliseid tooteid rohkem esile tõsta.

---

### AI kasutamine

Kasutasin ChatGPT-d, et valida sobivaid diagrammitüüpe ja kontrollida dashboard’i loogikat. AI aitas mul ka paremini mõista, kuidas paigutada visuaale nii, et info oleks kasutajale kiiresti arusaadav.

---

### Failid

* [dashboard_screenshot.png](./dashboard_screenshot.png) – minu dashboard’i ekraanipilt
* [week5_dashboard.pbix](./week5_dashboard.pbix) – Power BI dashboard fail

---

### Kokkuvõte

Selle nädala jooksul õppisin, et visualiseerimise puhul ei ole kõige olulisem graafikute hulk, vaid nende selgus ja eesmärgipärasus. Õigesti disainitud dashboard võimaldab teha ärilisi järeldusi palju kiiremini kui toorandmete põhjal.

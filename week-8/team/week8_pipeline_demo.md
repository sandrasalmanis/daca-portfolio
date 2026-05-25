# Automatiseeritud *Pipeline*

## 1. Ülevaade ja eesmärk
Käesolev dokumentatsioon kirjeldab UrbanStyle OÜ jaoks loodud Pythoni-põhist *pipeline*'i, mis automatiseerib müügiandmete kogumise, töötlemise ja visualiseerimise protsessi. Süsteem on loodud liikuma manuaalselt Exceli-põhiselt tööviisilt dünaamilisele, API-põhisele ja ajastatavale lahendusele.

Peamine eesmärk on varustada ettevõtet värskete äriandmetega (KPI-d, nädalased trendid), säilitades samal ajal nõutud andmekvaliteedi ja turvalisuse standardid.

## 2. *Pipeline*'i arhitektuur (ETL)
Süsteem järgib standardset ***Extract-Transform-Load (ETL)*** mustrit ning on ehitatud modulaarselt:

| Etapp | Funktsioon koodis | Kirjeldus |
| :--- | :--- | :--- |
| ***EXTRACT*** | `data_fetcher.fetch_sales`, `fetch_customers` | Pärib andmed *Supabase REST API*-st. Toetab kuupäevapõhist filtreerimist. |
| ***TRANSFORM*** | `transform.clean_data`, `calculate_kpis`, `merge_datasets` | Puhastab andmed (duplikaadid, NULL-id), arvutab KPI-d ja liidab tabelid. |
| ***LOAD*** | `visualize_export.export_results`, `create_weekly_chart` | Genereerib *Plotly* interaktiivsed graafikud (HTML) ja salvestab puhastatud andmed CSV-sse. |

## 3. Tehnilised nõuded
*   **Keel:** Python 3.13
*   **Andmetöötlus:** *Pandas*
*   **Visualiseerimine:** *Plotly*
*   **Turvalisus:** `.env` faili tugi tundlike API-võtmete hoidmiseks (ei asu koodis).
*   **Logimine:** Kasutusel on `logging` moodul, mis salvestab sündmused koos ajatemplitega, võimaldades jälgida iga etapi (*EXTRACT*, *TRANSFORM*, *LOAD*) edukust.

## 4. Kasutamine ja paindlikkus
*Pipeline* on juhitav läbi käsurea argumentide, mis muudab selle eriti väärtuslikuks ad-hoc analüüside tegemiseks:

**Vaikimisi käivitamine (kõik andmed):**
```bash
python pipeline.py

**Konkreetse ajavahemiku analüüs:**
python pipeline.py --start-date=2024-03-01 --end-date=2024-03-31

# Nädal 8: Automatiseeritud ETL Pipeline

## Projekti eesmärk

Selle nädala eesmärk oli ehitada automatiseeritud ETL pipeline, mis ühendab andmete pärimise, töötlemise ja raportite loomise üheks terviklikuks süsteemiks. Kasutasime Pythonit, pandas’t ja Supabase API ühendust, et muuta varasem käsitsi tehtud analüüs automatiseerituks.

---

## Minu roll – Data Processing (TRANSFORM)

Minu peamine vastutus meeskonnas oli andmete töötlemine ja puhastamine enne analüüsi ning visualiseerimist.

### Peamised ülesanded
- puhastasin andmestikke (`drop_duplicates`, NULL väärtuste käsitlemine);
- teisendasin kuupäevad õigesse datetime formaati;
- arvutasin nädalased KPI-d ja koondnäitajad;
- ühendasin müügi- ja kliendiandmeid `customer_id` alusel;
- valmistasin andmed ette pipeline’i järgmiste etappide jaoks.

---

## Kasutatud tehnoloogiad

- Python
- pandas
- Supabase API
- Plotly
- Git & GitHub

---

## Õpitu ja kogemus

See nädal aitas mul paremini aru saada, kuidas päris andmepipeline töötab ja miks ETL protsess on oluline. Õppisin, kuidas automatiseerida korduvaid analüüsiülesandeid ning kuidas pandas andmetöötlus ühendub API kaudu saadud andmetega.

Sain ka rohkem praktilist kogemust:
- andmete valideerimises,
- funktsioonide kirjutamises,
- meeskonnatöös GitHubi kaudu,
- ning suurema projekti moodulite ühendamises.

---

## AI kasutamine

Kasutasin AI abi pandas funktsioonide kontrollimiseks ja debugimiseks, eriti `groupby`, `merge` ja KPI arvutuste juures. AI aitas kiiremini leida vigu ja paremini mõista ETL pipeline’i ülesehitust.

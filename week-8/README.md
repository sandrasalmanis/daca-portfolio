# Nädal 8: Automatiseeritud ETL Pipeline

## Minu roll – Andmete töötlemine (TRANSFORM)

Minu ülesandeks meeskonnas oli tegeleda andmete puhastamise ja töötlemisega. Kirjutasin/aitasin koostada funktsioone, mis eemaldavad duplikaadid, käsitlevad puuduvaid väärtusi ja teisendavad kuupäevad õigesse formaati.

Peamised tegevused:
- puhastasin müügiandmeid enne analüüsi;
- arvutasin nädalased koondnäitajad ja KPI-d;
- ühendasin müügi- ja kliendiandmeid `customer_id` alusel;
- aitasin muuta andmed pipeline’i jaoks kasutatavaks.

## Õpitu

Sain paremini aru, kuidas üksikust pandas analüüsist saab osa suuremast automatiseeritud süsteemist. Eriti kasulik oli näha, kuidas Extract, Transform ja Load etapid koos töötavad ning miks andmete puhastamine on oluline enne raportite ja graafikute loomist.

## AI kasutamine

Kasutasin AI abi pandas funktsioonide kontrollimiseks ja andmete töötlemise loogika sõnastamiseks, eriti `groupby`, `merge` ja KPI arvutuste juures.

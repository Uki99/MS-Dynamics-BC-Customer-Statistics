# Uvod

Zadatak je pisan za NAV, ali napravi kompatibilno i za NAV i BC.
Radiš na NAV 2018 i BC koji imaš kod sebe.

**Rok: 3-4 dana.**

Ovako nešto može da se radi i kroz Report, ovde sada namerno prolazimo kao Page.


## Zadatak 2: Pregled prodaje po kupcima i mesecima
Napraviti novi page vrsta Lista, čiji je source Customer table. Za svakog kupca prikazati:
- 	Ime
- 	Adresu (ulica, broj)
- 	Grad
- 	PIB (VAT Registration No.)
-	trenutni saldo (Balance (LCY))
-	iznose prodaje za prethodnih 12 meseci u odvojenim kolonama (po jedna kolona za svaki mesec) 
-	ukupan iznos prodaje za ceo period
-	ukupan iznos troška za isti period.

Iznosi prodaje su niz promenljivih dimenzije 12 i dinamički se izračunavaju na page-u filtriranjem tabele `Value Entry` po 
-	šifri kupca („`Source No.`“)
-	„Source Type“=`Customer`
-	„Item Ledger Entry Type“ = `Sale` 
-	i po „`Posting Date`“ polju za odgovarajući period.
       
Za pravljenje perioda za filter po polju Posting Date iskoristiti virtuelnu tabelu Date, napraviti loop kroz redove gde je `„Period Type“ = „Period Type“::Month`.
Iznos je suma vrednosti polja „`Sales Amount (Actual)`“ (Pogledati `CALCSUMS` kako radi). 
Iznos troška je isto iz tabele `Value Entry` sa istim filterima suma vredonsti polja „`Cost Amount (Actual)`“.

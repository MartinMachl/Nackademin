-- Utbildningar.Nackademin.Martin_Machl.Query
-- H�r finns utf�rande av procedurer och beskrivning av vad de g�r

-- V�xla till databas
USE UtbildningarNackademinMM
GO


-- De f�rsta procedurerna �r till f�r anv�ndare med r�ttighet att enbart l�sa i databasen

-- Denna procedur visar alla kurser och utbildningar med all tillg�nglig information
-- Om en kurs eller utbildning g�r p� fler �n en plats visas de f�r samtliga platser.
-- Proceduren g�r att k�ra med en variabel, tex "S" f�r att f� alla kurser/utbildningar som b�rjar p� bokstaven S
EXEC Utbildningar

-- Exempel
EXEC Utbildningar Dev
EXEC Utbildningar Agi


-- Denna procedur visar alla kurser och utbildningar sorterade efter ort
-- Proceduren g�r att k�ra med en eller flera variabler (upp till tre), tex "Stock" f�r att f� alla kurser/utbildningar som g�r i Stockholm
EXEC Orter

-- Exempel
EXEC Orter Distans
EXEC Orter Stock
EXEC Orter Visby, Uppsala, N�ssj�


-- Denna procedur visar alla kurser och utbildningar sorterade efter inriktning
-- Proceduren g�r att k�ra med en variabel, tex "IT" f�r att f� alla IT-kurser/utbildningar
EXEC Inriktning

-- Exempel
EXEC Inriktning IT


-- Denna procedur visar alla kurser och utbildningar vars beskrivning inneh�ller variabeln
-- som man s�ker med.
EXEC Detalj

-- Exempel
EXEC Detalj Databas
EXEC Detalj web
EXEC Detalj ingenj�r




-- Dessa procedurer �r endast f�r administrat�rer
-- Denna procedur uppdaterar beskrivningen av en kurs/utbildning
-- K�r f�rst proceduren som h�mtar ID f�r kurser och utbildningar
EXEC ID

-- Anv�nd sedan ID i n�sta procedur samt beskrivning, max 300 tecken
-- EXEC Beskrivning [ID], ['Beskrivning']
-- Anledningen till att jag valt att proceduren anv�nder ID f�r att identifiera utbildningen �r f�r att det ska minimera risken f�r att fel utbildning redigeras.
-- Exempel
EXEC Beskrivning 7, 'DevOps Engineer �r ett av IT-branschens hetaste yrken med mycket stor efterfr�gan!'
EXEC Detalj devops

-- �terst�llning:
EXEC Beskrivning 7, 'DevOps �r en kombination av drifttekniker och systemutvecklare. Fokus f�r en DevOps Engineer �r att h�ja v�rdet av IT-leveransen genom att skapa ett snabbt och effektivt fl�de. Utbildningen inneh�ller bl.a databashantering, programmering i Python och Java, Continuous Integration, molndrift och LAN.'


-- Denna procedur raderar en kurs/utbildning
-- Kursen/utbildningen raderas ur b�de tabellen med utbildningar samt i tabellen d�r koppling mot plats g�rs
-- K�r f�rst proceduren som h�mtar ID f�r kurser och utbildningar
EXEC ID

-- Anv�nd sedan ID i n�sta procedur f�r att radera kurs/utbildning
-- Utan ID raderas ingen utbildning alls
-- Anledningen till att jag valt att proceduren anv�nder ID f�r att identifiera utbildningen �r f�r att det ska minimera risken f�r att fel utbildning raderas
-- Exempel
EXEC Radera 1
EXEC Utbildningar 'Agilt ledarskap' -- Nu helt raderad


-- Denna procedur l�gger till en kurs/utbildning, f�ljt av var kursen/utbildningen g�r
-- Proceduren beh�ver samtliga v�rden som exemplet visar.
-- EXEC L�ggaTillU ['Utb Namn'], [Typ: Kurs/Utbildning], [Inriktning], ['Utb l�ngd'], ['Praktik l�ngd'], ['Start datum'], ['Beskrivning max 300 tecken']
-- Om en kurs typ, l�ngd, ort, startdatum eller praktikens l�ngd inte redan finns med i databasen m�ste dessa l�ggas till f�rst
-- Exempel INSERT INTO [dbo].[Utbildning.Plats](EduLoc) VALUES ('V�ster�s')
EXEC L�ggaTillU 'Agilt ledarskap', Kurs, IT, '8 veckor', 'Ingen praktik', '2021-01-18', 'I en allt mer snabbr�rlig, f�r�ndringsben�gen och instabil omv�rld �kar f�retagens behov att kunna anpassa sig till den omst�llningen. F�retag som lyckas arbeta agilt rapporterar ett flertal positiva effekter. De kan h�lla en h�gre produktivitet, och kan �ppna upp f�r mer sj�lvst�ndigt arbete.'

-- L�gg till platsen f�r kurs/utbildning
EXEC L�ggaTillP 'Agilt ledarskap', Distans
EXEC Utbildningar 'Agilt ledarskap'


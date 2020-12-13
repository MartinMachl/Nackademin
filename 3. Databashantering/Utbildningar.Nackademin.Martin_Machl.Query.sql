-- Utbildningar.Nackademin.Martin_Machl.Query
-- Här finns utförande av procedurer och beskrivning av vad de gör

-- Växla till databas
USE UtbildningarNackademinMM
GO


-- De första procedurerna är till för användare med rättighet att enbart läsa i databasen

-- Denna procedur visar alla kurser och utbildningar med all tillgänglig information
-- Om en kurs eller utbildning går på fler än en plats visas de för samtliga platser.
-- Proceduren går att köra med en variabel, tex "S" för att få alla kurser/utbildningar som börjar på bokstaven S
EXEC Utbildningar

-- Exempel
EXEC Utbildningar Dev
EXEC Utbildningar Agi


-- Denna procedur visar alla kurser och utbildningar sorterade efter ort
-- Proceduren går att köra med en eller flera variabler (upp till tre), tex "Stock" för att få alla kurser/utbildningar som går i Stockholm
EXEC Orter

-- Exempel
EXEC Orter Distans
EXEC Orter Stock
EXEC Orter Visby, Uppsala, Nässjö


-- Denna procedur visar alla kurser och utbildningar sorterade efter inriktning
-- Proceduren går att köra med en variabel, tex "IT" för att få alla IT-kurser/utbildningar
EXEC Inriktning

-- Exempel
EXEC Inriktning IT


-- Denna procedur visar alla kurser och utbildningar vars beskrivning innehåller variabeln
-- som man söker med.
EXEC Detalj

-- Exempel
EXEC Detalj Databas
EXEC Detalj web
EXEC Detalj ingenjör




-- Dessa procedurer är endast för administratörer
-- Denna procedur uppdaterar beskrivningen av en kurs/utbildning
-- Kör först proceduren som hämtar ID för kurser och utbildningar
EXEC ID

-- Använd sedan ID i nästa procedur samt beskrivning, max 300 tecken
-- EXEC Beskrivning [ID], ['Beskrivning']
-- Anledningen till att jag valt att proceduren använder ID för att identifiera utbildningen är för att det ska minimera risken för att fel utbildning redigeras.
-- Exempel
EXEC Beskrivning 7, 'DevOps Engineer är ett av IT-branschens hetaste yrken med mycket stor efterfrågan!'
EXEC Detalj devops

-- Återställning:
EXEC Beskrivning 7, 'DevOps är en kombination av drifttekniker och systemutvecklare. Fokus för en DevOps Engineer är att höja värdet av IT-leveransen genom att skapa ett snabbt och effektivt flöde. Utbildningen innehåller bl.a databashantering, programmering i Python och Java, Continuous Integration, molndrift och LAN.'


-- Denna procedur raderar en kurs/utbildning
-- Kursen/utbildningen raderas ur både tabellen med utbildningar samt i tabellen där koppling mot plats görs
-- Kör först proceduren som hämtar ID för kurser och utbildningar
EXEC ID

-- Använd sedan ID i nästa procedur för att radera kurs/utbildning
-- Utan ID raderas ingen utbildning alls
-- Anledningen till att jag valt att proceduren använder ID för att identifiera utbildningen är för att det ska minimera risken för att fel utbildning raderas
-- Exempel
EXEC Radera 1
EXEC Utbildningar 'Agilt ledarskap' -- Nu helt raderad


-- Denna procedur lägger till en kurs/utbildning, följt av var kursen/utbildningen går
-- Proceduren behöver samtliga värden som exemplet visar.
-- EXEC LäggaTillU ['Utb Namn'], [Typ: Kurs/Utbildning], [Inriktning], ['Utb längd'], ['Praktik längd'], ['Start datum'], ['Beskrivning max 300 tecken']
-- Om en kurs typ, längd, ort, startdatum eller praktikens längd inte redan finns med i databasen måste dessa läggas till först
-- Exempel INSERT INTO [dbo].[Utbildning.Plats](EduLoc) VALUES ('Västerås')
EXEC LäggaTillU 'Agilt ledarskap', Kurs, IT, '8 veckor', 'Ingen praktik', '2021-01-18', 'I en allt mer snabbrörlig, förändringsbenägen och instabil omvärld ökar företagens behov att kunna anpassa sig till den omställningen. Företag som lyckas arbeta agilt rapporterar ett flertal positiva effekter. De kan hålla en högre produktivitet, och kan öppna upp för mer självständigt arbete.'

-- Lägg till platsen för kurs/utbildning
EXEC LäggaTillP 'Agilt ledarskap', Distans
EXEC Utbildningar 'Agilt ledarskap'


-- Utbildningar.Nackademin.Martin_Machl.Build
/*
Genom att trycka på F5 kommer databas att skapas,
sedan byggs alla tabeller och de fylls med data.
Index skapas och alla procedurer byggs.
Du kan självklart köra allt stegvis så länge de går i ordning.
Jag ville använda IF NOT EXISTS före bygge av databas och tabeller,
men det verkar inte fungera i SSMS.
I fil "Utbildningar.Nackademin.Martin_Machl.Query.sql" finns alla executions
med beskrivningar som behövs av användare.
Storleken på 16 MB är mer än tillräcklig för ändamålet men det finns utrymme för tillväxt.
*/

USE MASTER
GO

-- 1. Skapar databas
CREATE DATABASE [UtbildningarNackademinMM]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'UtbildningarNackademin', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\UtbildningarNackademinMM.mdf' , SIZE = 16384KB , FILEGROWTH = 16384KB )
 LOG ON 
( NAME = N'UtbildningarNackademin_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\UtbildningarNackademinMM_log.ldf' , SIZE = 16384KB , FILEGROWTH = 16384KB )
COLLATE Finnish_Swedish_CI_AS
GO
ALTER DATABASE [UtbildningarNackademinMM] SET COMPATIBILITY_LEVEL = 150
GO
ALTER DATABASE [UtbildningarNackademinMM] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [UtbildningarNackademinMM] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [UtbildningarNackademinMM] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [UtbildningarNackademinMM] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [UtbildningarNackademinMM] SET ARITHABORT OFF 
GO
ALTER DATABASE [UtbildningarNackademinMM] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [UtbildningarNackademinMM] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [UtbildningarNackademinMM] SET AUTO_CREATE_STATISTICS ON(INCREMENTAL = OFF)
GO
ALTER DATABASE [UtbildningarNackademinMM] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [UtbildningarNackademinMM] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [UtbildningarNackademinMM] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [UtbildningarNackademinMM] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [UtbildningarNackademinMM] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [UtbildningarNackademinMM] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [UtbildningarNackademinMM] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [UtbildningarNackademinMM] SET  DISABLE_BROKER 
GO
ALTER DATABASE [UtbildningarNackademinMM] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [UtbildningarNackademinMM] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [UtbildningarNackademinMM] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [UtbildningarNackademinMM] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [UtbildningarNackademinMM] SET  READ_WRITE 
GO
ALTER DATABASE [UtbildningarNackademinMM] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [UtbildningarNackademinMM] SET  MULTI_USER 
GO
ALTER DATABASE [UtbildningarNackademinMM] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [UtbildningarNackademinMM] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [UtbildningarNackademinMM] SET DELAYED_DURABILITY = DISABLED 
GO


-- 2. Växlar till databas
USE [UtbildningarNackademinMM]
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = Off;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET LEGACY_CARDINALITY_ESTIMATION = Primary;
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET MAXDOP = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = On;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET PARAMETER_SNIFFING = Primary;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = Off;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET QUERY_OPTIMIZER_HOTFIXES = Primary;
GO
USE [UtbildningarNackademinMM]
GO
IF NOT EXISTS (SELECT name FROM sys.filegroups WHERE is_default=1 AND name = N'PRIMARY') ALTER DATABASE [UtbildningarNackademinMM] MODIFY FILEGROUP [PRIMARY] DEFAULT
GO


-- 3. Tabeller skapas
-- Tabellerna är indexerade på Primary Key för att det är på ID som alla joins görs,
-- samt på namn, ort och inriktning då sökningar går att göra på dessa
BEGIN TRANSACTION
SET QUOTED_IDENTIFIER ON
SET ARITHABORT ON
SET NUMERIC_ROUNDABORT OFF
SET CONCAT_NULL_YIELDS_NULL ON
SET ANSI_NULLS ON
SET ANSI_PADDING ON
SET ANSI_WARNINGS ON
COMMIT
GO

-- 3.1 Utbildning.Plats
BEGIN TRANSACTION
GO
CREATE TABLE dbo.[Utbildning.Plats]
	(
	LocID int NOT NULL IDENTITY (1, 1),
	EduLoc varchar(20) NOT NULL
	)  ON [PRIMARY]
GO
ALTER TABLE dbo.[Utbildning.Plats] ADD CONSTRAINT
	[PK_Utbildning.Plats] PRIMARY KEY CLUSTERED 
	(
	LocID
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

GO
CREATE NONCLUSTERED INDEX IDX_EduLoc ON dbo.[Utbildning.Plats]
	(
	EduLoc
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE dbo.[Utbildning.Plats] SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
GO

-- 3.2 Utbildning.Typ
BEGIN TRANSACTION
GO
CREATE TABLE dbo.[Utbildning.Typ]
	(
	TypeID int NOT NULL IDENTITY (1, 1),
	EduType varchar(20) NOT NULL
	)  ON [PRIMARY]
GO
ALTER TABLE dbo.[Utbildning.Typ] ADD CONSTRAINT
	[PK_Utbildning.Typ] PRIMARY KEY CLUSTERED 
	(
	TypeID
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

GO
CREATE NONCLUSTERED INDEX IDX_EduType ON dbo.[Utbildning.Typ]
	(
	EduType
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE dbo.[Utbildning.Typ] SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
GO

-- 3.3 Utbildning.Klass
BEGIN TRANSACTION
GO
CREATE TABLE dbo.[Utbildning.Klass]
	(
	ClassID int NOT NULL IDENTITY (1, 1),
	EduClass varchar(20) NOT NULL
	)  ON [PRIMARY]
GO
ALTER TABLE dbo.[Utbildning.Klass] ADD CONSTRAINT
	[PK_Utbildning.Klass2] PRIMARY KEY CLUSTERED 
	(
	ClassID
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

GO
CREATE NONCLUSTERED INDEX IDX_EduClass ON dbo.[Utbildning.Klass]
	(
	EduClass
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE dbo.[Utbildning.Klass] SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
GO

-- 3.4 Utbildning.Längd
BEGIN TRANSACTION
GO
CREATE TABLE dbo.[Utbildning.Längd]
	(
	LenID int NOT NULL IDENTITY (1, 1),
	EduLen varchar(10) NOT NULL
	)  ON [PRIMARY]
GO
ALTER TABLE dbo.[Utbildning.Längd] ADD CONSTRAINT
	[PK_Utbildning.Längd] PRIMARY KEY CLUSTERED 
	(
	LenID
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

GO
ALTER TABLE dbo.[Utbildning.Längd] SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
GO

-- 3.5 Utbildning.Praktik
BEGIN TRANSACTION
GO
CREATE TABLE dbo.[Utbildning.Praktik]
	(
	PraID int NOT NULL IDENTITY (1, 1),
	PraLen varchar(15) NOT NULL
	)  ON [PRIMARY]
GO
ALTER TABLE dbo.[Utbildning.Praktik] ADD CONSTRAINT
	[PK_Utbildning.Praktik] PRIMARY KEY CLUSTERED 
	(
	PraID
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

GO
ALTER TABLE dbo.[Utbildning.Praktik] SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
GO

-- 3.6 Utbildning.Start
BEGIN TRANSACTION
GO
CREATE TABLE dbo.[Utbildning.Start]
	(
	StartID int NOT NULL IDENTITY (1, 1),
	StartDate date NOT NULL
	)  ON [PRIMARY]
GO
ALTER TABLE dbo.[Utbildning.Start] ADD CONSTRAINT
	[PK_Utbildning.Start] PRIMARY KEY CLUSTERED 
	(
	StartID
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

GO
ALTER TABLE dbo.[Utbildning.Start] SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
GO

-- 3.7 Utbildning
BEGIN TRANSACTION
GO
CREATE TABLE dbo.Utbildning
	(
	EduID int NOT NULL IDENTITY (1, 1),
	EduName varchar(50) NOT NULL,
	TypeID int NOT NULL,
	ClassID int NOT NULL,
	LenID int NOT NULL,
	PraID int NOT NULL,
	StartID int NOT NULL,
	EduDes varchar(300) NOT NULL
	)  ON [PRIMARY]
GO
ALTER TABLE dbo.Utbildning ADD CONSTRAINT
	PK_Utbildning PRIMARY KEY CLUSTERED 
	(
	EduID
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

GO
ALTER TABLE dbo.Utbildning ADD CONSTRAINT
	FK_Utb_Typ FOREIGN KEY
	(
	TypeID
	) REFERENCES dbo.[Utbildning.Typ]
	(
	TypeID
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.Utbildning ADD CONSTRAINT
	FK_Utb_Class FOREIGN KEY
	(
	ClassID
	) REFERENCES dbo.[Utbildning.Klass]
	(
	ClassID
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.Utbildning ADD CONSTRAINT
	FK_Utb_Len FOREIGN KEY
	(
	LenID
	) REFERENCES dbo.[Utbildning.Längd]
	(
	LenID
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.Utbildning ADD CONSTRAINT
	FK_Utb_Pra FOREIGN KEY
	(
	PraID
	) REFERENCES dbo.[Utbildning.Praktik]
	(
	PraID
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.Utbildning ADD CONSTRAINT
	FK_Utb_Start FOREIGN KEY
	(
	StartID
	) REFERENCES dbo.[Utbildning.Start]
	(
	StartID
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
CREATE NONCLUSTERED INDEX IDX_EduName ON dbo.[Utbildning]
	(
	EduName
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE dbo.Utbildning SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
GO

-- 3.8 Utbildning.Plats.Länk
BEGIN TRANSACTION
GO
CREATE TABLE dbo.[Utbildning.Plats.Länk]
	(
	LinkID int NOT NULL IDENTITY (1, 1),
	EduID int NOT NULL,
	LocID int NOT NULL
	)  ON [PRIMARY]
GO
ALTER TABLE dbo.[Utbildning.Plats.Länk] ADD CONSTRAINT
	[PK_Utbildning.Plats.Länk] PRIMARY KEY CLUSTERED 
	(
	LinkID
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

GO
ALTER TABLE dbo.[Utbildning.Plats.Länk] ADD CONSTRAINT
	FK_Link_Utb FOREIGN KEY
	(
	EduID
	) REFERENCES dbo.[Utbildning]
	(
	EduID
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.[Utbildning.Plats.Länk] ADD CONSTRAINT
	FK_Link_Loc FOREIGN KEY
	(
	LocID
	) REFERENCES dbo.[Utbildning.Plats]
	(
	LocID
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.[Utbildning.Plats.Länk] SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
GO


-- 4. Tabellerna fylls med data
-- 4.1
BEGIN TRANSACTION
INSERT INTO [dbo].[Utbildning.Plats]
			(EduLoc)
		VALUES
			('Stockholm'),
			('Distans'),
			('Uppsala'),
			('Visby'),
			('Nässjö')
COMMIT
GO

-- 4.2
BEGIN TRANSACTION
INSERT INTO [dbo].[Utbildning.Typ]
			(EduType)
		VALUES
			('Kurs'),
			('Utbildning')
COMMIT
GO

-- 4.3
BEGIN TRANSACTION
INSERT INTO [dbo].[Utbildning.Klass]
			(EduClass)
		VALUES
			('IT'),
			('Bygg'),
			('Elteknik och energi'),
			('Kommunikation'),
			('Design'),
			('Vård och hälsa'),
			('Pedagogik')
COMMIT
GO

-- 4.4
BEGIN TRANSACTION
INSERT INTO [dbo].[Utbildning.Längd]
			(EduLen)
		VALUES
			('8 veckor'),
			('10 veckor'),
			('1 år'),
			('1,5 år'),
			('2 år')
COMMIT
GO

-- 4.5
BEGIN TRANSACTION
INSERT INTO [dbo].[Utbildning.Praktik]
			(PraLen)
		VALUES
			('Ingen praktik'),
			('16 veckor'),
			('18 veckor'),
			('20 veckor'),
			('21 veckor'),
			('22 veckor'),
			('24 veckor'),
			('25 veckor'),
			('26 veckor'),
			('27 veckor'),
			('28 veckor'),
			('30 veckor')
COMMIT
GO

-- 4.6
BEGIN TRANSACTION
INSERT INTO [dbo].[Utbildning.Start]
			(StartDate)
		VALUES
			('2021-01-18'),
			('2021-02-17'),
			('2021-08-23'),
			('2021-11-10')
COMMIT
GO

-- 4.7
BEGIN TRANSACTION
INSERT INTO [dbo].[Utbildning]
			(EduName, TypeID, ClassID, LenID, PraID, StartID, EduDes)
		VALUES
			('Agilt ledarskap', 1, 1, 1, 1, 1, 'I en allt mer snabbrörlig, förändringsbenägen och instabil omvärld ökar företagens behov att kunna anpassa sig till den omställningen. Företag som lyckas arbeta agilt rapporterar ett flertal positiva effekter. De kan hålla en högre produktivitet, och kan öppna upp för mer självständigt arbete.'),
			('Testautomatiserare', 1, 1, 2, 1, 2, 'Kursen riktar sig till dig som är utbildad till eller arbetar som testare eller utvecklare inom IT och vill ta nästa steg i karriären. Efter avslutad kurs kommer du att självständigt kunna planera, designa, implementera och underhålla automatiserade testskripter.'),
			('Företagsekonomi och branschjuridik', 1, 5, 1, 1, 4, 'Målet med kursen är att de studerande ska förstå de allmänna principer för affärsmässiga relationer till kunder och leverantörer som finns samt juridiken som styr köp- och designmarknaden. De studerande ska ha kunskaper i cirkulär ekonomi, analyser för kostnadsberäkning och kravställning.'),
			('Juridik', 1, 2, 1, 1, 1, 'Denna kurs ger dig avancerad kunskap kring dokumentation, upphandling och de avtal och entreprenadformer som finns inom bygg- eller anläggningsprojekt. Kursen ska ge kursdeltagaren fördjupade kunskaper i hur ändringar, tillägg och avgående arbeten dokumenteras och hanteras enligt avtal.'),
			('Business Intelligence-analytiker', 2, 1, 5, 4, 3, 'Business Intelligence är ett samlingsbegrepp för olika funktioner som utvinner, hanterar och analyserar stora mängder data. Som Business Intelligence-analytiker skapar du kvalificerade underlag för strategiska och taktiska affärsbeslut baserat på den insamlade datan.'),
			('Virtual Reality-utvecklare', 2, 1, 5, 4, 3, 'Som Virtual Reality-utvecklare skapar du verklighetstrogna digitala och artificiella miljöer med hjälp av 3D. Inom samhällsbyggnad används redan tekniken för att visa hur framtida bostäder och bostadsområden kan se ut innan de är färdigbyggda.'),
			('DevOps Engineer', 2, 1, 5, 4, 3, 'DevOps är en kombination av drifttekniker och systemutvecklare. Fokus för en DevOps Engineer är att höja värdet av IT-leveransen genom att skapa ett snabbt och effektivt flöde. Utbildningen innehåller bl.a databashantering, programmering i Python och Java, Continuous Integration, molndrift och LAN.'),
			('Kvalitetssäkrare och testare', 2, 1, 5, 4, 3, 'Som kvalitetssäkrare och testare inom IT säkerställer du hög kvalitet i produkter och tjänster innan de släpps till release på marknaden. Du har en viktig roll inom utvecklingen av ny programvara, för att säkerställa att tekniken möter användarnas behov på ett tillfredsställande sätt.'),
			('IT-infrastrukturspecialist', 2, 1, 5, 4, 3, 'Utbildningen IT-infrastrukturspecialist passar dig som tycker om att lösa problem. Du har ett stort intresse för datorer och nätverk samt har god samarbetsförmåga. Efter utbildningen blir du expert på IT-infrastruktur vare sig den finns i molnet eller fysiskt på plats.'),
			('IT-säkerhetstekniker', 2, 1, 5, 4, 3, 'Som IT-säkerhetstekniker jobbar du med att skydda företag, myndigheter och organisationers nätverk, information, system och utrustning för att minska riskerna för intrång och attacker. Viktiga arbetsuppgifter för en IT-säkerhetstekniker är att upprätta rutiner för att underhålla intrångsskydd.'),
			('Frontend-utvecklare', 2, 1, 5, 6, 3, 'Som Frontend-utvecklare arbetar du med presentationslagret – det man ser och använder när man surfar på en webbplats. Det gäller att skapa logisk och effektiv Frontend-kod för att göra sidorna så välfungerande, innovativa och funktionella som möjligt.'),
			('Programutvecklare Java', 2, 1, 5, 8, 3, 'Java är ett plattformsoberoende, objektorienterat programmeringsspråk. Det används på många olika sorters företag då det passar för många typer av mjukvarusystem. Du hittar det i serverbaserade backend-system, webblösningar, olika inbyggda system t ex i flygplan och bilar samt mobila applikationer.'),
			('Platschef', 2, 2, 3, 1, 3, 'Under ett år kan du som varit yrkesverksam som arbetsledare eller entreprenadingenjör inom bygg i minst tre år vidareutbilda dig till platschef på Nackademin. Utbildningen riktar sig till dig som jobbar som arbetsledare och behöver fördjupa dina kunskaper inom ledarskap, ekonomi och juridik.'),
			('Arbetsledare bygg och anläggning', 2, 2, 4, 2, 3, 'En arbetsledare ansvarar för att planera, leda, samordna och fördela arbetet för arbetslaget och att bevaka maskiner och material. Det innebär uppsikt över maskiner och material, kontroll över att arbetet utförs enligt gällande ritningar och anvisningar/beskrivningar.'),
			('Byggnadsingenjör mark och vatten', 2, 2, 4, 2, 3, 'En byggnadsingenjör med inriktning mark och vatten står för den tekniska kompetensen när det gäller projektering och utförande av mark- och anläggningsarbeten. Det kan vara allt ifrån bostadsgårdar, skolgårdar, lek- och idrottsplatser, parker och parkeringsplatser till trottoarer och cykelbanor.'),
			('VA-projektör', 2, 2, 4, 4, 3, 'Som VA-projektör kommer du att ha kunskaper om byggprocessens alla tekniska, såväl som juridiska och administrativa, delar. Arbetet innebär att skapa modeller, ritningar och tekniska beskrivningar samt ta fram nödvändiga handlingar för projekt inom vatten och avlopp.'),
			('Järnvägsingenjör', 2, 2, 5, 4, 3, 'Programmet Järnvägsingenjör får du lära dig saker som allmän och tillämpad underhållsteknik av järnvägen, spårgeometri, tågdrift och om järnvägens kraftförsörjning och elsystem. Du kommer lära dig att utforma ett drift- och underhållsprojekt från planeringsskedet till genomförande och uppföljning.'),
			('Byggnadsingenjör Produktion', 2, 2, 5, 9, 3, 'Som byggnadsingenjör kan du arbeta med nyproduktion inom bygg. Att arbeta som byggnadsingenjör är lite som att lägga ett omfattande och komplext pussel, där små detaljer skapar en betydligt större helhet.'),
			('Byggnadsingenjör ROT', 2, 2, 5, 9, 3, 'Är du intresserad av att renovera och bygga om äldre hus och byggnader? ROT står för Renovering, Ombyggnad och Tillbyggnad. Äldre byggnader kräver kunskaper om byggnadsvård och underhåll, tålamod, ett metodiskt arbetssätt, god planering och förmåga att praktisk tillämpa det man lärt sig.'),
			('Elkraftingenjör', 2, 3, 5, 4, 3, 'Efter avslutad utbildning har du förståelse för energiformer som vattenkraft, kärnkraft, vågraft, vindkraft och solenergi. Du förstår elförsörjningsystemets uppbyggnad, planering och genomföring av projekt inom elkraftsområdet samt beslutsfattning om hållbara och kostnadseffektiva energilösningar.'),
			('Elingenjör konstruktion', 2, 3, 5, 6, 3, 'Som Elingenjör konstruktion är det du som gör ritningarna för all elektronik som ska dras och monteras i en byggnad – som belysning, datanät och elinstallationer. Det kan gälla bostadshus, kontor, industrimiljöer eller andra ny-, till- och ombyggnationer som behöver avancerad teknik.'),
			('Social Media Manager', 2, 4, 4, 4, 3, 'Som Social Media Manager förmedlar du ett tydligt syfte för ett företags kommunikation utåt, det kan till exempel handla om att öka antalet sålda produkter, skapa varumärkeskännedom eller attrahera nya medarbetare.'),
			('UX-designer', 2, 5, 5, 4, 3, 'UX står för User eXperience och handlar om interaktionen mellan en användare och en produkt eller tjänst. Det kan gälla digitala appar för mobiltelefoner och webbtjänster, men även fysiska produkter. En UX–Designers roll är att förstå sig på användaren genom olika väletablerade metoder.'),
			('Förpackningsutvecklare/-designer', 2, 5, 5, 4, 3, 'I utbildningen Förpackningsdesign lär du dig hur hela förpackningsprocessen fungerar och vad som avgör hur en förpackning utformas. Du får kunskaper om olika material och deras egenskaper, om konstruktion, grafisk form, produktionsteknik, tryckprocesser, ekonomi, marknadsföring, projektledning mm.'),
			('Välfärdstekniksamordnare', 2, 6, 3, 1, 3, 'Välfärdsteknik är digital teknik som syftar till att öka självständigheten hos personer med funktionsnedsättning. Det kan vara smarta läkemedelsdoserare, intelligenta duschar, GPS-klockar och ätrobotar. Tekniken är lätt att köpa in, men den måste också användas på ett effektivt sätt.'),
			('Tandsköterska', 2, 6, 3, 2, 1, 'Har du drömt om att jobba inom vård och hälsa? Funderar du på att byta karriär och vill satsa på ett stimulerande jobb? Vill du ha varierande och intressanta arbetsuppgifter? Det finns behov av fler tandsköterskor i stora delar av landet.'),
			('Lärarassistent', 2, 7, 4, 2, 3, 'I rollen som lärarassistent bistår du lärarna i deras pedagogiska och sociala arbete. Utbildningen ger färdigheter att både hantera olika administrativa system, samverka i och utanför klassrummet samt kommunicera med både personal, vårdnadshavare, myndigheter och barn.')
COMMIT
GO

-- 4.8
BEGIN TRANSACTION
INSERT INTO [dbo].[Utbildning.Plats.Länk]
			(EduID, LocID)
		VALUES
			(1, 2),
			(2, 2),
			(3, 1),
			(4, 1),
			(4, 2),
			(5, 1),
			(6, 1),
			(7, 1),
			(8, 1),
			(9, 1),
			(10, 1),
			(10, 2),
			(11, 1),
			(12, 1),
			(12, 2),
			(13, 2),
			(14, 1),
			(14, 4),
			(15, 2),
			(16, 1),
			(17, 1),
			(18, 2),
			(18, 3),
			(19, 1),
			(20, 1),
			(21, 1),
			(21, 2),
			(22, 1),
			(22, 2),
			(23, 1),
			(24, 1),
			(25, 1),
			(25, 2),
			(26, 2),
			(27, 1),
			(27, 2),
			(27, 5)
COMMIT
GO


-- 5. Stored procedures skapas
-- 5.1 Procedur som hämtar samtliga kurser och utbildningar
CREATE PROC Utbildningar (@Name varchar(50) = '%')
AS
BEGIN
	SELECT @Name = @Name + '%'
	SELECT U.EduName AS 'Utbildning', UT.EduType AS 'Typ', UK.EduClass 'Inriktning', UP.EduLoc AS 'Plats', UL.EduLen AS 'Längd', UPR.PraLen AS 'Praktik', US.StartDate AS 'Start', U.EduDes AS 'Beskrivning'
	FROM [dbo].[Utbildning] AS U
	INNER JOIN [dbo].[Utbildning.Typ] AS UT
	ON U.TypeID = UT.TypeID
	INNER JOIN [dbo].[Utbildning.Klass] AS UK
	ON U.ClassID = UK.ClassID
	INNER JOIN [dbo].[Utbildning.Plats.Länk] UPL
	ON U.EduID = UPL.EduID
	INNER JOIN [dbo].[Utbildning.Plats] UP
	ON UP.LocID = UPL.LocID 
	INNER JOIN [dbo].[Utbildning.Längd] AS UL
	ON U.LenID = UL.LenID
	INNER JOIN [dbo].[Utbildning.Praktik] AS UPR
	ON U.PraID = UPR.PraID
	INNER JOIN [dbo].[Utbildning.Start] AS US
	ON U.StartID = US.StartID
	WHERE U.EduName LIKE @Name
	GROUP BY U.EduName, UP.EduLoc, UT.EduType, UK.EduClass, UL.EduLen, UPR.PraLen, US.StartDate, U.EduDes
END
GO


-- 5.1 Procedur som hämtar kurser och utbildningar sorterade efter ort
CREATE PROCEDURE Orter (@Ort1 varchar(20) = '%', @Ort2 varchar(20) = '%', @Ort3 varchar(20) = '%')
AS
BEGIN
	SELECT @Ort1 = @Ort1 + '%'
	IF @Ort2 = '%'
		SELECT @Ort2 = @Ort2 + 'ZZZ'
	ELSE
		SELECT @Ort2 = @Ort2 + '%'
	IF @Ort3 = '%'
		SELECT @Ort3 = @Ort3 + 'ZZZ'
	ELSE
		SELECT @Ort2 = @Ort2 + '%'
	SELECT UP.EduLoc AS 'Plats', U.EduName AS 'Utbildning', UT.EduType AS 'Typ'
	FROM [dbo].[Utbildning] AS U
	INNER JOIN [dbo].[Utbildning.Typ] AS UT
	ON U.TypeID = UT.TypeID
	INNER JOIN [dbo].[Utbildning.Plats.Länk] UPL
	ON U.EduID = UPL.EduID
	INNER JOIN [dbo].[Utbildning.Plats] UP
	ON UP.LocID = UPL.LocID
	WHERE UP.EduLoc LIKE @Ort1 OR UP.EduLoc LIKE @Ort2 OR UP.EduLoc LIKE @Ort3
	GROUP BY UP.EduLoc, U.EduName, UT.EduType
END
GO

-- 5.2 Procedur som hämtar kurser och utbildningar sorterade efter inriktning
CREATE PROCEDURE Inriktning (@Class varchar(50) = '%')
AS
BEGIN
	SELECT @Class = @Class + '%'
	SELECT UK.EduClass 'Inriktning', U.EduName AS 'Utbildning', UT.EduType AS 'Typ'
	FROM [dbo].[Utbildning] AS U
	INNER JOIN [dbo].[Utbildning.Typ] AS UT
	ON U.TypeID = UT.TypeID
	INNER JOIN [dbo].[Utbildning.Klass] AS UK
	ON U.ClassID = UK.ClassID
	WHERE UK.EduClass LIKE @Class
	GROUP BY UK.EduClass, U.EduName, UT.EduType
END
GO

-- 5.3 Procedur som hämtar kurser och utbildningar med beskrivning
CREATE PROCEDURE Detalj (@Desc varchar(50) = '%')
AS
BEGIN
	SELECT @Desc = '%' + @Desc + '%'
	SELECT EduName AS 'Utbildning', EduDes AS 'Beskrivning'
	FROM [dbo].[Utbildning]
	WHERE EduDes LIKE @Desc
END
GO

-- 5.4 Procedur som hämtar ID och Namn för kurser och utbildningar
CREATE PROCEDURE ID
AS
BEGIN
	SELECT EduName AS 'Utbildning', EduID AS 'ID'
	FROM [dbo].[Utbildning]
END
GO

-- 5.5 Procedur som uppdaterar beskrivning för kurser och utbildningar
CREATE PROCEDURE Beskrivning(@ID int, @Desc varchar(300))
AS
BEGIN
	UPDATE [dbo].[Utbildning]
	SET EduDes = @Desc
	WHERE EduID = @ID
end
go


-- 5.6 Procedur som tar bort en kurs eller utbildning
CREATE PROCEDURE Radera(@ID int)
AS
BEGIN
	DELETE FROM [dbo].[Utbildning.Plats.Länk] WHERE EduID = @ID
	DELETE FROM [dbo].[Utbildning] WHERE EduID = @ID
END
GO


-- 5.7 Procedur som lägger till en kurs eller utbildning
CREATE PROCEDURE LäggaTillU(@Name varchar(50),@Type varchar(20),@Class varchar(20),@EduLen varchar(10),@PraLen varchar(15),@Date date,@Desc varchar(300))
AS
BEGIN
	INSERT INTO [dbo].[Utbildning]
				(EduName, TypeID, ClassID, LenID, PraID, StartID, EduDes)
			VALUES 
				(@Name, 
				(SELECT TypeID FROM [dbo].[Utbildning.Typ] WHERE EduType = @Type), 
				(SELECT ClassID FROM [dbo].[Utbildning.Klass] WHERE EduClass = @Class), 
				(SELECT LenID FROM [dbo].[Utbildning.Längd] WHERE EduLen = @EduLen), 
				(SELECT PraID FROM [dbo].[Utbildning.Praktik] WHERE PraLen = @PraLen), 
				(SELECT StartID FROM [dbo].[Utbildning.Start] WHERE StartDate = @Date), 
				@Desc)
END
GO
CREATE PROCEDURE LäggaTillP(@Name varchar(50), @Ort varchar(20))
AS
BEGIN
	INSERT INTO [dbo].[Utbildning.Plats.Länk]
				(EduID, LocID)
			VALUES
				((SELECT EduID FROM [dbo].[Utbildning] WHERE EduName = @Name), 
				(SELECT LocID FROM [dbo].[Utbildning.Plats] WHERE EduLoc = @Ort))
END
GO



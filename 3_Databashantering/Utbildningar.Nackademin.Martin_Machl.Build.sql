-- Utbildningar.Nackademin.Martin_Machl.Build
/*
Genom att trycka p� F5 kommer databas att skapas,
sedan byggs alla tabeller och de fylls med data.
Index skapas och alla procedurer byggs.
Du kan sj�lvklart k�ra allt stegvis s� l�nge de g�r i ordning.
Jag ville anv�nda IF NOT EXISTS f�re bygge av databas och tabeller,
men det verkar inte fungera i SSMS.
I fil "Utbildningar.Nackademin.Martin_Machl.Query.sql" finns alla executions
med beskrivningar som beh�vs av anv�ndare.
Storleken p� 16 MB �r mer �n tillr�cklig f�r �ndam�let men det finns utrymme f�r tillv�xt.
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


-- 2. V�xlar till databas
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
-- Tabellerna �r indexerade p� Primary Key f�r att det �r p� ID som alla joins g�rs,
-- samt p� namn, ort och inriktning d� s�kningar g�r att g�ra p� dessa
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

-- 3.4 Utbildning.L�ngd
BEGIN TRANSACTION
GO
CREATE TABLE dbo.[Utbildning.L�ngd]
	(
	LenID int NOT NULL IDENTITY (1, 1),
	EduLen varchar(10) NOT NULL
	)  ON [PRIMARY]
GO
ALTER TABLE dbo.[Utbildning.L�ngd] ADD CONSTRAINT
	[PK_Utbildning.L�ngd] PRIMARY KEY CLUSTERED 
	(
	LenID
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

GO
ALTER TABLE dbo.[Utbildning.L�ngd] SET (LOCK_ESCALATION = TABLE)
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
	) REFERENCES dbo.[Utbildning.L�ngd]
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

-- 3.8 Utbildning.Plats.L�nk
BEGIN TRANSACTION
GO
CREATE TABLE dbo.[Utbildning.Plats.L�nk]
	(
	LinkID int NOT NULL IDENTITY (1, 1),
	EduID int NOT NULL,
	LocID int NOT NULL
	)  ON [PRIMARY]
GO
ALTER TABLE dbo.[Utbildning.Plats.L�nk] ADD CONSTRAINT
	[PK_Utbildning.Plats.L�nk] PRIMARY KEY CLUSTERED 
	(
	LinkID
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

GO
ALTER TABLE dbo.[Utbildning.Plats.L�nk] ADD CONSTRAINT
	FK_Link_Utb FOREIGN KEY
	(
	EduID
	) REFERENCES dbo.[Utbildning]
	(
	EduID
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.[Utbildning.Plats.L�nk] ADD CONSTRAINT
	FK_Link_Loc FOREIGN KEY
	(
	LocID
	) REFERENCES dbo.[Utbildning.Plats]
	(
	LocID
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.[Utbildning.Plats.L�nk] SET (LOCK_ESCALATION = TABLE)
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
			('N�ssj�')
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
			('V�rd och h�lsa'),
			('Pedagogik')
COMMIT
GO

-- 4.4
BEGIN TRANSACTION
INSERT INTO [dbo].[Utbildning.L�ngd]
			(EduLen)
		VALUES
			('8 veckor'),
			('10 veckor'),
			('1 �r'),
			('1,5 �r'),
			('2 �r')
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
			('Agilt ledarskap', 1, 1, 1, 1, 1, 'I en allt mer snabbr�rlig, f�r�ndringsben�gen och instabil omv�rld �kar f�retagens behov att kunna anpassa sig till den omst�llningen. F�retag som lyckas arbeta agilt rapporterar ett flertal positiva effekter. De kan h�lla en h�gre produktivitet, och kan �ppna upp f�r mer sj�lvst�ndigt arbete.'),
			('Testautomatiserare', 1, 1, 2, 1, 2, 'Kursen riktar sig till dig som �r utbildad till eller arbetar som testare eller utvecklare inom IT och vill ta n�sta steg i karri�ren. Efter avslutad kurs kommer du att sj�lvst�ndigt kunna planera, designa, implementera och underh�lla automatiserade testskripter.'),
			('F�retagsekonomi och branschjuridik', 1, 5, 1, 1, 4, 'M�let med kursen �r att de studerande ska f�rst� de allm�nna principer f�r aff�rsm�ssiga relationer till kunder och leverant�rer som finns samt juridiken som styr k�p- och designmarknaden. De studerande ska ha kunskaper i cirkul�r ekonomi, analyser f�r kostnadsber�kning och kravst�llning.'),
			('Juridik', 1, 2, 1, 1, 1, 'Denna kurs ger dig avancerad kunskap kring dokumentation, upphandling och de avtal och entreprenadformer som finns inom bygg- eller anl�ggningsprojekt. Kursen ska ge kursdeltagaren f�rdjupade kunskaper i hur �ndringar, till�gg och avg�ende arbeten dokumenteras och hanteras enligt avtal.'),
			('Business Intelligence-analytiker', 2, 1, 5, 4, 3, 'Business Intelligence �r ett samlingsbegrepp f�r olika funktioner som utvinner, hanterar och analyserar stora m�ngder data. Som Business Intelligence-analytiker skapar du kvalificerade underlag f�r strategiska och taktiska aff�rsbeslut baserat p� den insamlade datan.'),
			('Virtual Reality-utvecklare', 2, 1, 5, 4, 3, 'Som Virtual Reality-utvecklare skapar du verklighetstrogna digitala och artificiella milj�er med hj�lp av 3D. Inom samh�llsbyggnad anv�nds redan tekniken f�r att visa hur framtida bost�der och bostadsomr�den kan se ut innan de �r f�rdigbyggda.'),
			('DevOps Engineer', 2, 1, 5, 4, 3, 'DevOps �r en kombination av drifttekniker och systemutvecklare. Fokus f�r en DevOps Engineer �r att h�ja v�rdet av IT-leveransen genom att skapa ett snabbt och effektivt fl�de. Utbildningen inneh�ller bl.a databashantering, programmering i Python och Java, Continuous Integration, molndrift och LAN.'),
			('Kvalitetss�krare och testare', 2, 1, 5, 4, 3, 'Som kvalitetss�krare och testare inom IT s�kerst�ller du h�g kvalitet i produkter och tj�nster innan de sl�pps till release p� marknaden. Du har en viktig roll inom utvecklingen av ny programvara, f�r att s�kerst�lla att tekniken m�ter anv�ndarnas behov p� ett tillfredsst�llande s�tt.'),
			('IT-infrastrukturspecialist', 2, 1, 5, 4, 3, 'Utbildningen IT-infrastrukturspecialist passar dig som tycker om att l�sa problem. Du har ett stort intresse f�r datorer och n�tverk samt har god samarbetsf�rm�ga. Efter utbildningen blir du expert p� IT-infrastruktur vare sig den finns i molnet eller fysiskt p� plats.'),
			('IT-s�kerhetstekniker', 2, 1, 5, 4, 3, 'Som IT-s�kerhetstekniker jobbar du med att skydda f�retag, myndigheter och organisationers n�tverk, information, system och utrustning f�r att minska riskerna f�r intr�ng och attacker. Viktiga arbetsuppgifter f�r en IT-s�kerhetstekniker �r att uppr�tta rutiner f�r att underh�lla intr�ngsskydd.'),
			('Frontend-utvecklare', 2, 1, 5, 6, 3, 'Som Frontend-utvecklare arbetar du med presentationslagret � det man ser och anv�nder n�r man surfar p� en webbplats. Det g�ller att skapa logisk och effektiv Frontend-kod f�r att g�ra sidorna s� v�lfungerande, innovativa och funktionella som m�jligt.'),
			('Programutvecklare Java', 2, 1, 5, 8, 3, 'Java �r ett plattformsoberoende, objektorienterat programmeringsspr�k. Det anv�nds p� m�nga olika sorters f�retag d� det passar f�r m�nga typer av mjukvarusystem. Du hittar det i serverbaserade backend-system, webbl�sningar, olika inbyggda system t ex i flygplan och bilar samt mobila applikationer.'),
			('Platschef', 2, 2, 3, 1, 3, 'Under ett �r kan du som varit yrkesverksam som arbetsledare eller entreprenadingenj�r inom bygg i minst tre �r vidareutbilda dig till platschef p� Nackademin. Utbildningen riktar sig till dig som jobbar som arbetsledare och beh�ver f�rdjupa dina kunskaper inom ledarskap, ekonomi och juridik.'),
			('Arbetsledare bygg och anl�ggning', 2, 2, 4, 2, 3, 'En arbetsledare ansvarar f�r att planera, leda, samordna och f�rdela arbetet f�r arbetslaget och att bevaka maskiner och material. Det inneb�r uppsikt �ver maskiner och material, kontroll �ver att arbetet utf�rs enligt g�llande ritningar och anvisningar/beskrivningar.'),
			('Byggnadsingenj�r mark och vatten', 2, 2, 4, 2, 3, 'En byggnadsingenj�r med inriktning mark och vatten st�r f�r den tekniska kompetensen n�r det g�ller projektering och utf�rande av mark- och anl�ggningsarbeten. Det kan vara allt ifr�n bostadsg�rdar, skolg�rdar, lek- och idrottsplatser, parker och parkeringsplatser till trottoarer och cykelbanor.'),
			('VA-projekt�r', 2, 2, 4, 4, 3, 'Som VA-projekt�r kommer du att ha kunskaper om byggprocessens alla tekniska, s�v�l som juridiska och administrativa, delar. Arbetet inneb�r att skapa modeller, ritningar och tekniska beskrivningar samt ta fram n�dv�ndiga handlingar f�r projekt inom vatten och avlopp.'),
			('J�rnv�gsingenj�r', 2, 2, 5, 4, 3, 'Programmet J�rnv�gsingenj�r f�r du l�ra dig saker som allm�n och till�mpad underh�llsteknik av j�rnv�gen, sp�rgeometri, t�gdrift och om j�rnv�gens kraftf�rs�rjning och elsystem. Du kommer l�ra dig att utforma ett drift- och underh�llsprojekt fr�n planeringsskedet till genomf�rande och uppf�ljning.'),
			('Byggnadsingenj�r Produktion', 2, 2, 5, 9, 3, 'Som byggnadsingenj�r kan du arbeta med nyproduktion inom bygg. Att arbeta som byggnadsingenj�r �r lite som att l�gga ett omfattande och komplext pussel, d�r sm� detaljer skapar en betydligt st�rre helhet.'),
			('Byggnadsingenj�r ROT', 2, 2, 5, 9, 3, '�r du intresserad av att renovera och bygga om �ldre hus och byggnader? ROT st�r f�r Renovering, Ombyggnad och Tillbyggnad. �ldre byggnader kr�ver kunskaper om byggnadsv�rd och underh�ll, t�lamod, ett metodiskt arbetss�tt, god planering och f�rm�ga att praktisk till�mpa det man l�rt sig.'),
			('Elkraftingenj�r', 2, 3, 5, 4, 3, 'Efter avslutad utbildning har du f�rst�else f�r energiformer som vattenkraft, k�rnkraft, v�graft, vindkraft och solenergi. Du f�rst�r elf�rs�rjningsystemets uppbyggnad, planering och genomf�ring av projekt inom elkraftsomr�det samt beslutsfattning om h�llbara och kostnadseffektiva energil�sningar.'),
			('Elingenj�r konstruktion', 2, 3, 5, 6, 3, 'Som Elingenj�r konstruktion �r det du som g�r ritningarna f�r all elektronik som ska dras och monteras i en byggnad � som belysning, datan�t och elinstallationer. Det kan g�lla bostadshus, kontor, industrimilj�er eller andra ny-, till- och ombyggnationer som beh�ver avancerad teknik.'),
			('Social Media Manager', 2, 4, 4, 4, 3, 'Som Social Media Manager f�rmedlar du ett tydligt syfte f�r ett f�retags kommunikation ut�t, det kan till exempel handla om att �ka antalet s�lda produkter, skapa varum�rkesk�nnedom eller attrahera nya medarbetare.'),
			('UX-designer', 2, 5, 5, 4, 3, 'UX st�r f�r User eXperience och handlar om interaktionen mellan en anv�ndare och en produkt eller tj�nst. Det kan g�lla digitala appar f�r mobiltelefoner och webbtj�nster, men �ven fysiska produkter. En UX�Designers roll �r att f�rst� sig p� anv�ndaren genom olika v�letablerade metoder.'),
			('F�rpackningsutvecklare/-designer', 2, 5, 5, 4, 3, 'I utbildningen F�rpackningsdesign l�r du dig hur hela f�rpackningsprocessen fungerar och vad som avg�r hur en f�rpackning utformas. Du f�r kunskaper om olika material och deras egenskaper, om konstruktion, grafisk form, produktionsteknik, tryckprocesser, ekonomi, marknadsf�ring, projektledning mm.'),
			('V�lf�rdstekniksamordnare', 2, 6, 3, 1, 3, 'V�lf�rdsteknik �r digital teknik som syftar till att �ka sj�lvst�ndigheten hos personer med funktionsneds�ttning. Det kan vara smarta l�kemedelsdoserare, intelligenta duschar, GPS-klockar och �trobotar. Tekniken �r l�tt att k�pa in, men den m�ste ocks� anv�ndas p� ett effektivt s�tt.'),
			('Tandsk�terska', 2, 6, 3, 2, 1, 'Har du dr�mt om att jobba inom v�rd och h�lsa? Funderar du p� att byta karri�r och vill satsa p� ett stimulerande jobb? Vill du ha varierande och intressanta arbetsuppgifter? Det finns behov av fler tandsk�terskor i stora delar av landet.'),
			('L�rarassistent', 2, 7, 4, 2, 3, 'I rollen som l�rarassistent bist�r du l�rarna i deras pedagogiska och sociala arbete. Utbildningen ger f�rdigheter att b�de hantera olika administrativa system, samverka i och utanf�r klassrummet samt kommunicera med b�de personal, v�rdnadshavare, myndigheter och barn.')
COMMIT
GO

-- 4.8
BEGIN TRANSACTION
INSERT INTO [dbo].[Utbildning.Plats.L�nk]
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
-- 5.1 Procedur som h�mtar samtliga kurser och utbildningar
CREATE PROC Utbildningar (@Name varchar(50) = '%')
AS
BEGIN
	SELECT @Name = @Name + '%'
	SELECT U.EduName AS 'Utbildning', UT.EduType AS 'Typ', UK.EduClass 'Inriktning', UP.EduLoc AS 'Plats', UL.EduLen AS 'L�ngd', UPR.PraLen AS 'Praktik', US.StartDate AS 'Start', U.EduDes AS 'Beskrivning'
	FROM [dbo].[Utbildning] AS U
	INNER JOIN [dbo].[Utbildning.Typ] AS UT
	ON U.TypeID = UT.TypeID
	INNER JOIN [dbo].[Utbildning.Klass] AS UK
	ON U.ClassID = UK.ClassID
	INNER JOIN [dbo].[Utbildning.Plats.L�nk] UPL
	ON U.EduID = UPL.EduID
	INNER JOIN [dbo].[Utbildning.Plats] UP
	ON UP.LocID = UPL.LocID 
	INNER JOIN [dbo].[Utbildning.L�ngd] AS UL
	ON U.LenID = UL.LenID
	INNER JOIN [dbo].[Utbildning.Praktik] AS UPR
	ON U.PraID = UPR.PraID
	INNER JOIN [dbo].[Utbildning.Start] AS US
	ON U.StartID = US.StartID
	WHERE U.EduName LIKE @Name
	GROUP BY U.EduName, UP.EduLoc, UT.EduType, UK.EduClass, UL.EduLen, UPR.PraLen, US.StartDate, U.EduDes
END
GO


-- 5.1 Procedur som h�mtar kurser och utbildningar sorterade efter ort
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
	INNER JOIN [dbo].[Utbildning.Plats.L�nk] UPL
	ON U.EduID = UPL.EduID
	INNER JOIN [dbo].[Utbildning.Plats] UP
	ON UP.LocID = UPL.LocID
	WHERE UP.EduLoc LIKE @Ort1 OR UP.EduLoc LIKE @Ort2 OR UP.EduLoc LIKE @Ort3
	GROUP BY UP.EduLoc, U.EduName, UT.EduType
END
GO

-- 5.2 Procedur som h�mtar kurser och utbildningar sorterade efter inriktning
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

-- 5.3 Procedur som h�mtar kurser och utbildningar med beskrivning
CREATE PROCEDURE Detalj (@Desc varchar(50) = '%')
AS
BEGIN
	SELECT @Desc = '%' + @Desc + '%'
	SELECT EduName AS 'Utbildning', EduDes AS 'Beskrivning'
	FROM [dbo].[Utbildning]
	WHERE EduDes LIKE @Desc
END
GO

-- 5.4 Procedur som h�mtar ID och Namn f�r kurser och utbildningar
CREATE PROCEDURE ID
AS
BEGIN
	SELECT EduName AS 'Utbildning', EduID AS 'ID'
	FROM [dbo].[Utbildning]
END
GO

-- 5.5 Procedur som uppdaterar beskrivning f�r kurser och utbildningar
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
	DELETE FROM [dbo].[Utbildning.Plats.L�nk] WHERE EduID = @ID
	DELETE FROM [dbo].[Utbildning] WHERE EduID = @ID
END
GO


-- 5.7 Procedur som l�gger till en kurs eller utbildning
CREATE PROCEDURE L�ggaTillU(@Name varchar(50),@Type varchar(20),@Class varchar(20),@EduLen varchar(10),@PraLen varchar(15),@Date date,@Desc varchar(300))
AS
BEGIN
	INSERT INTO [dbo].[Utbildning]
				(EduName, TypeID, ClassID, LenID, PraID, StartID, EduDes)
			VALUES 
				(@Name, 
				(SELECT TypeID FROM [dbo].[Utbildning.Typ] WHERE EduType = @Type), 
				(SELECT ClassID FROM [dbo].[Utbildning.Klass] WHERE EduClass = @Class), 
				(SELECT LenID FROM [dbo].[Utbildning.L�ngd] WHERE EduLen = @EduLen), 
				(SELECT PraID FROM [dbo].[Utbildning.Praktik] WHERE PraLen = @PraLen), 
				(SELECT StartID FROM [dbo].[Utbildning.Start] WHERE StartDate = @Date), 
				@Desc)
END
GO
CREATE PROCEDURE L�ggaTillP(@Name varchar(50), @Ort varchar(20))
AS
BEGIN
	INSERT INTO [dbo].[Utbildning.Plats.L�nk]
				(EduID, LocID)
			VALUES
				((SELECT EduID FROM [dbo].[Utbildning] WHERE EduName = @Name), 
				(SELECT LocID FROM [dbo].[Utbildning.Plats] WHERE EduLoc = @Ort))
END
GO



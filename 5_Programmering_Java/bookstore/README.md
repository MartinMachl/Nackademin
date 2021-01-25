# Programming in Java examination

## Author: Martin Machl [martin.machl@yh.nackademin.se]

### Date of completion: 2021-01-24

--------------------------------------------------------

## Setup

1. Install requirements

### Install requirements

```cmd
mvn install
```

* This program is constructed to run on against a MSSQL Database on local server.
* The program files are in directory src\main\java\se\booksrus
* The program is run through App.java
* Tests are found in directory src\test\java\se\booksrus

--------------------------------------------------------

### Program explanation

This program was made as a course examination for programming in Java,\
using a database to store information.
The rules for the program build (in swedish).

*I denna uppgift ska du skriva ett program som hanterar köp av böcker.*

***Bokhandeln - Krav G***

* *Du har enhetstester för de viktigaste metoderna.*
* *Du kan lista tillgängliga böcker (minst 10 st)*
* *Du kan söka bok på titel*
* *Du kan söka bok på ISBN-nummer*
* *Du kan söka bok på författare*
* *Du kan lägga till bok i varukorg*
* *Du kan se totalsumma för varukorg*
* *Du kan slutföra beställningen*

***Bokhandeln - Krav VG***

* *Du har heltäckande enhetstester och har uttänkt testdata.*
* *Du kan se lagerstatus böcker*
* *Du kan reservera en bok som är slut i lager*
* *Du kan önska en ny bok som inte finns i butiken*
* *Du använder en databas eller fil för att spara böcker och köp*

### References used when making this program

* [Oracle Docs Java](https://docs.oracle.com/javase/tutorial/java/nutsandbolts/index.html)
* [Stackoverflow](https://stackoverflow.com/)
* Code examples from past lectures

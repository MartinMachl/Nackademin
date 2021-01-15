# Programming in Python examination

## Author: Martin Machl [martin.machl@yh.nackademin.se]

### Date of completion: 2020-11-03

--------------------------------------------------------

## Setup

1. Create a virtual environment
2. Install requirements

### Virtual environment (venv)

see <https://docs.python.org/3/library/venv.html>

Linux / OSX

```sh
python -m venv .venv  # could also be python3
source .venv/bin/activate
```

Windows - cmd.exe

```bat
python -m venv .venv
.venv\Scripts\activate.bat
```

Windows - PowerShell

```PowerShell
# On Microsoft Windows, it may be required to enable the Activate.ps1 script by setting the execution policy for the user. You can do this by issuing the following PowerShell command:
# Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser

py -m venv .venv
.\.venv\Scripts\Activate.ps1

```

#### Install requirements.txt

```bat
pip install -r requirements.txt
```

* This program is constructed to run on local computer and not over a network.
* The program files are in the App directory
* They are ment to be run in order:
  * smart_home_server.py
  * smart_home_sensors.py
  * smart_home_client.py
* To run all three programs they require one command prompt each
* __init__.py is empty and is only for tests

--------------------------------------------------------

## Program explanation

This program was made as a course examination for programming in Python,\
using sockets, threading and unittests.
The rules for the program build (in swedish):\
<i>

### Det smarta hemmet

I denna uppgift ska du bygga en smart hem lösning. Dina mätvärden kan vara påhittade.

#### Krav

* Du har klienter som skickar mätdata t.ex. temperatur eller luftfuktighet till din server
* Du har en användarklient som kan fråga servern om de senaste mätvärdena
* Du skriver något enhetstest

</i>

### References used when making this program

* [Stackoverflow](https://stackoverflow.com/)
* [Geeks for Geeks Tkinter guide](https://www.geeksforgeeks.org/python-after-method-in-tkinter/)
* [Python Docs Sockets guide](https://docs.python.org/3/howto/sockets.html)
* [Sockets tutorials by sentdex](https://www.youtube.com/c/sentdex)
* [Threading tutorials by Tech With Tim](https://www.youtube.com/c/TechWithTim)
* [Tkinter tutorial by freeCodeCamp.org](https://www.youtube.com/channel/UC8butISFwT-Wl7EV0hUK0BQ)
* [Unittest tutorial by Corey Shafer](https://www.youtube.com/channel/UCCezIgC97PvUuR4_gbFUs5g)

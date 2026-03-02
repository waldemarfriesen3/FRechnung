@echo off
title FRechnung starten
color 0A

echo.
echo  FRechnung - Lokale Web-Version
echo  ================================
echo.

python --version >nul 2>&1
if %errorlevel% neq 0 goto kein_python
echo  [OK] Python gefunden
echo.
goto pakete_pruefen

:kein_python
echo  Python nicht gefunden.
echo  Python wird jetzt im Microsoft Store geoffnet.
echo  Bitte installieren und danach diese Datei
echo  erneut doppelklicken.
echo.
start ms-windows-store://pdp/?productid=9NRWMJLIVE98
pause
exit /b

:pakete_pruefen
echo  Pruefe Pakete...
python -m pip show flask >nul 2>&1
if %errorlevel% neq 0 goto installieren
python -m pip show fpdf2 >nul 2>&1
if %errorlevel% neq 0 goto installieren
python -m pip show pypdf >nul 2>&1
if %errorlevel% neq 0 goto installieren
python -m pip show Pillow >nul 2>&1
if %errorlevel% neq 0 goto installieren
goto starten

:installieren
echo  Installiere Pakete (einmalig, ca. 30 Sekunden)...
python -m pip install flask flask-cors fpdf2 pypdf Pillow --quiet
if %errorlevel% neq 0 goto fehler
echo  [OK] Pakete installiert

:starten
echo  [OK] Pakete bereit
echo.
echo  Starte FRechnung...
echo.
echo  Adresse: http://localhost:5000
echo  Browser oeffnet sich automatisch.
echo  Dieses Fenster NICHT schliessen!
echo.

start /b cmd /c "timeout /t 2 /nobreak >nul && start http://localhost:5000"

cd /d "%~dp0"
set PORT=5000
set FLASK_LOCAL=1
python server.py
echo.
echo  FRechnung wurde beendet.
pause
exit /b

:fehler
echo.
echo  Fehler beim Installieren der Pakete.
echo  Bitte Internetverbindung pruefen.
pause
exit /b

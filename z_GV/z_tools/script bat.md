@echo off 
mkdir GV_fonti 2>nul 
echo Scaricando pagine GV... 
curl -o "GV_fonti\Razze_Classi.html" "http://www.grajaversion.org/Home/RaceClasses" 
curl -o "GV_fonti\Talenti.html" "http://www.grajaversion.org/Features" 
curl -o "GV_fonti\Benefici.html" "http://www.grajaversion.org/Features/Benefits"
curl -o "GV_fonti\Stli.html" "http://www.grajaversion.org/Powers/Styles" 
curl -o "GV_fonti\Incantesimi.html" "http://www.grajaversion.org/Powers/Spells" 
curl -o "GV_fonti\Preghiere.html" "http://www.grajaversion.org/Powers/Prayers" 
curl -o "GV_fonti\Discipline.html" "http://www.grajaversion.org/Powers/Disciplines" 

echo ✅ Download completato! 
pause
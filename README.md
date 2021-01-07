# make-vorlesung
Dockerfile und Co zum Erzeugen eines Docker images zum Übersetzen von Vorlesungsskripten



Erstellen eines neuen Docker images mit:

> docker build -t nmarkgraf/make-vorlesungen:<tag> .

wobei <tag> nur eine neuen Tag ersetzt werden muss. Z.B.: v0.3

Speichern einer neuen Fassung im Hub:

> 


Starten eines Docker images mittels:

> docker run -v /Volumes/norman/Docker/results:/home/Vorlesungen/results -it nmarkgraf/make-vorlesungen:<tag>

Um ein bestimmtes Repository zu benutzen:

> docker run -v /Volumes/norman/Docker/results:/home/Vorlesungen/results -it nmarkgraf/make-vorlesungen:v0.3 --repourl=https://github.com/luebby/Vorlesungen --username=USERNAME --password=PASSWORD


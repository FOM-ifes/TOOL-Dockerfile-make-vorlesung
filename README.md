# Dockerfile make-vorlesung

Dockerfile und Co zum Erzeugen eines Docker images zum Übersetzen von Vorlesungsskripten


# Wie erstellt man ein neues Docker images?

Erstellen eines neuen Docker images mit:

> docker build -t nmarkgraf/make-vorlesungen:<tag> .

wobei <tag> nur eine neuen Tag ersetzt werden muss. Z.B.: v0.4


# Wie läd man ein Docker images vom Docker hub?

Mit dem Befehl

> docker load nmarkgraf/make-vorlasung:v0.4

wird die Version mit dem tag *v0.4* vom Docker hub geladen.

Über https://registry.hub.docker.com/repository/docker/nmarkgraf/make-vorlesungen kann man sich ansehen,
weche tags gerade auf dem Hub gespeichert sind.

# Wie startet man ein neues Docker images?

Starten eines Docker images mittels:

> docker run -v /Volumes/norman/Docker/results:/home/Vorlesungen/results -it nmarkgraf/make-vorlesungen:<tag>

Um ein bestimmtes Repository zu benutzen:

> docker run -v /Volumes/norman/Docker/results:/home/Vorlesungen/results -it nmarkgraf/make-vorlesungen:v0.4 --repourl=https://github.com/luebby/Vorlesungen --username=USERNAME --password=PASSWORD

Damit wird ein Repository geclont und die Dateien "RunMeFirst.R" und "makerender.R" aus dem Repository ausgeführt.
Anschliessend werden alle PDF Dateien aus dem Hauptverzeichnis (des Repositories) unter "/Volmes/norman/Docker/results" (also dem lokalen Verzeichnis) gespeichert.

Ebenso wird im Unterverzeichnis "log" alle erzeugten LOG Dateien gespeichert.

# Wie können Entwickler neue images auf den Docker hun speichern?

Neue Versionen können (von Berechtigten!) mittels

> docker push nmarkgraf/make-vorlesungen:v0.4 

erstellt werden!
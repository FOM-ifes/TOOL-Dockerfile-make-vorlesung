# Dockerfile make-vorlesung

Dockerfile & Co. zum Erzeugen eines *Docker image* mit dem Vorlesungsskripte 
aus einem lokalen git/GitHub - Repository erzeugt werden kann.

- Maintainer: [NMarkgraf](https:/github.com/NMarkgraf) 

- Email: [nmarkgraf@hotmail.com](mailto:nmarkgraf@hotmail.com?subject=GitHub-Dockerfile-make-vorlesung)


## Wie erstellt man ein neues *Docker image*?

Erstellen eines neuen *Docker image* mit:
```
> docker build -t nmarkgraf/make-vorlesungen .
> docker scan --accept-license -f Dockerfile nmarkgraf/make-vorlesungen 
> docker tag nmarkgraf/make-vorlesungen nmarkgraf/make-vorlesungen:<tag>
```

wobei <tag> nur eine neuen Tag ersetzt werden muss. Z.B.: v1.1


## Wie läd mensch einen *Docker image* vom *Docker hub*?

Mit dem Befehl

```
> docker pull nmarkgraf/make-vorlesungen:latest
```

wird die aktuelle Version geladen.

Allgemein kann man eine bestimmte Version mit dem tag *<tag>* durch den Befehl:

```
> docker pull nmarkgraf/make-vorlesungen:<tag>
```

laden. Will mann zum Beispiel die Version *v1.0* laden, so geht das mit:
```
> docker pull nmarkgraf/make-vorlesungen:v1.0
```


Über https://registry.hub.docker.com/repository/docker/nmarkgraf/make-vorlesungen 
kann angesehen werden,
weche tags, und damit welche Versionen, gerade auf dem Hub gespeichert sind und 
somit von den Nutzer:innen geladen werden können.


## Wie startet man ein neues Docker image?

### Vorbereitungen

Sie brauchen ein lokales, leeres Verzeichnis, welches Sie mit der 
Docker-Umgebung teilen, um darin die ihr lokale Version des GitHub-Repository 
zu speichern.
In diesem Verzeichnis werden auch die übersetzten PDF Dokumente erstellt.
Dieses Verzeichnis heißt für das Docker Images: "/home/Vorlesungen/repo"

Sie können das Verzeichnis frei Wählen, es muss nur beschreibbar sein.

Zum Beispiel "/tmp/Vorlesungsskripte"

Legen Sie dazu das Verzeichnis an mittels:

```
> mkdir /tmp/Vorlesungsskripte
```

Legen Sie in dieses Verzeichnis z.B. den Inhalt des ZIP-Archives des Vorlesungsrepositories ab oder nutzen sie den Befehl:

```
> git clone https://github.com/luebby/Vorlesungen.git --branch master /tmp/Vorlesungsskripte
```
  
Wobei Sie mir `--branch master` den aktuellen Branch auswählen (können).
  
Ihr lokales Reopository Verzeichnis "/tmp/Vorlesungsskripte" muss für das *Docker image*: "/home/Vorlesungen/repo" heissen.

Dazu müssen Sie beim Aufruf des *Docker image* die Option "-v" nutzen. 
D.h. also die Option "-v /tmp/Vorlesungsskripte:/home/Vorlesungen/repo" angeben.


### Starten es *Docker images*

Starten eines *Docker images* mittels:

```
> docker run -v /tmp/Vorlesungsskripte:/home/Vorlesungen/repo -it nmarkgraf/make-vorlesungen:<tag>
```

Mittels 
```
> docker run -v /tmp/Vorlesungsskripte:/home/Vorlesungen/repo -it nmarkgraf/make-vorlesungen:latest
```

erhält mensch eine kleinen Hilfetext.

Um ein bestimmtes Modul, wie z.B. "Wissenschaftliche-Methodik" oder "Datenerhebung-Statistik", zu erzeugen können sie die Option "--modul" wie folgt nutzen:

```
> docker run -v /tmp/Vorlesungsskripte:/home/Vorlesungen/repo -it nmarkgraf/make-vorlesungen:latest --modul=Wissenschaftliche-Methodik 
```


### Was genau passiert im Hintergrund?

Mit "--modul=<Modulbezeichnung>" wird dann das Skript "<Modulbezeichung>.Rmd"
übersetzt. 
Wollen Sie ein anderes Modul übersetzen, so muss eine entsprechende
Datei in ihrem lokalen Repository Verzeichnis hinterlegt sein.

Bsp: Übersetzen des Skriptes "Datenerhebung-Statistik" benötigt die Datei
"Datenerhebung-Statistik.Rmd" und kann mit dem folgenden Befehl übersetzt 
werden:

```
> docker run -v /tmp/Vorlesungsskripte:/home/Vorlesungen/repo -it nmarkgraf/make-vorlesungen:latest --modul=Datenerhebung-Statistik 
```

Zum Übersetzen wird in dem lokalen Repository Verzeichnis das Skript
"makerender.R <Modulbezeichnung>" ausgeführt. 
Welches dann das entsprechende Skript übersetzt.

Nach erfolgreichem Übersetzen werden alle Dateien <Modulbezeichnung>*.pdf 
sowohl im Docker, als auch in ihrem lokalen Repository-Verzeichnis erstellt.


### Wo sind dann die Ergebnisse?

Sie finden also die Dokumente z.B. mittels:

```
> ls -al /tmp/Vorlesungsskripte
```

Ggf. müssen sie den Pfad zu ihrem lokalen Repository Verzeichnis entsprechend 
anpassen.


## Wie können Entwickler neue images auf dem *Docker hub* speichern?

Neue Versionen können (von Berechtigten!) mittels

```
> docker push nmarkgraf/make-vorlesungen
```

erstellt werden! 

Der gesamte Erstellungszyklus lautet also:


```
> docker build -t nmarkgraf/make-vorlesungen .
> docker tag nmarkgraf/make-vorlesungen nmarkgraf/make-vorlesungen:v1.0
> docker push nmarkgraf/make-vorlesungen
```


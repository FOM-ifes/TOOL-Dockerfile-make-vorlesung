# Dockerfile make-vorlesung

Dockerfile & Co. zum Erzeugen eines *Docker images* mit dem mensch Vorlesungsskripte aus einem git/GitHub - Repository erzeugen kann.

Maintainer: [NMarkgraf](https:/github.com/NMarkgraf)

Email: [nmarkgraf@hotmail.com](mailto:nmarkgraf@hotmail.com?subject=make-vorlesung)


## Wie erstellt man ein neues Docker images?

Erstellen eines neuen Docker images mit:

```
> docker build -t nmarkgraf/make-vorlesungen .
> docker tag nmarkgraf/make-vorlesungen nmarkgraf/make-vorlesungen:<tag> .
```


wobei <tag> nur eine neuen Tag ersetzt werden muss. Z.B.: v0.6


## Wie läd man ein Docker images vom Docker hub?

Mit dem Befehl

```
> docker pull nmarkgraf/make-vorlesungen:latest
```

wird die aktuelle Version geladen.

Allgemein kann man die Version mit dem tag *<tag>* durch den Befehl:

```
> docker pull nmarkgraf/make-vorlesungen:<tag>
```

laden. Will mann zum Beispiel die Version *v0.6* laden, so geht das mit:
```
> docker pull nmarkgraf/make-vorlesungen:v0.6
```


Über https://registry.hub.docker.com/repository/docker/nmarkgraf/make-vorlesungen kann man sich ansehen,
weche tags gerade auf dem Hub gespeichert sind und damit von den Nutzer*innen geladen werden können.


## Wie startet man ein neues Docker images?

### Vorbereitungen

Sie brauchen ein lokales, leeres Verzeichnis, welches Sie mit der Docker-Umgebung teilen, um darin die
übersetzten PDF Dokumente zu erhalten.
Dieses Verzeichnis heißt für das Docker Images: "/home/Vorlesungen/results"

Sie können das Verzeichnis frei Wählen, es muss nur beschreibbar sein.

Zum Beispiel "/tmp/Vorlesungsskripte"

Legen Sie dazu das Verzeichnis an mittels:

```
mkdir /tmp/Vorlesungsskripte
```

Ihr lokales Verzeichnis "/tmp/Vorlesungsskripte" soll also für das Docker Images: "/home/Vorlesungen/results" heissen.

Dazu müssen Sie beim Aufruf des Docker Images die Option "-v" nutzen. D.h. also die Option "-v /tmp/Vorlesungsskripte:/home/Vorlesungen/results" angeben.

### Starten es Docker images

Starten eines Docker images mittels:

```
> docker run -v /tmp/Vorlesungsskripte:/home/Vorlesungen/results -it nmarkgraf/make-vorlesungen:<tag>
```

Mittels 
```
> docker run -v /tmp/Vorlesungsskripte:/home/Vorlesungen/results -it nmarkgraf/make-vorlesungen:latest
```

erhält mensch eine kleinen Hilfetext.

### Repository auswählen

Um ein bestimmtes Repository zu benutzen, muss man die URL angeben. Dies passiert mit der Option "--repourl".
Wollen Sie z.B. das Repository **luebby/Vorlesungen** von GitHub nutzen,so müssen sie die Option:
"--repourl=https://github.com/luebby/Vorlesungen.git" angeben.

Das GitHub-Repository **NMarkgraf/MathGrundDer-W-Info** mit der Option: 
"--repourl=https://github.com/NMarkgraf/MathGrundDer-W-Info.git"


### Authentifizieren bei GitHub für private Repositories

Bei privaten Repositories müssen Sie sich erst authentifizieren.

#### Sie haben eine 2-Faktoren-Authentifikation bei GitHub aktiviert?

Sollten Sie die 2-Faktoren-Authentifikation von GitHub nutzen, so müssen Sie mit SSH Schlüsseln arbeiten. (Siehe weiter unten!)
Bitte sprechen Sie mich an!


#### Sie haben **keine** 2-Faktoren-Authentifikation bei GitHub aktiviert?

Sollten Sie sich nur mittels Nutzername und Passwort einloggen können, so können Sie mittels "--username=<USERNAME>" und "--password=<PASSWORD>"
die Zugangsdaten angeben. 

**Wichtig:** Das funktioniert nur, wenn man **keine 2-Faktoren-Authentifizierung aktiv**iert hat!

```
> docker run -v /tmp/Vorlesungsskripte:/home/Vorlesungen/results -it nmarkgraf/make-vorlesungen:latest --repourl=https://github.com/luebby/Vorlesungen.git  --username=USERNAME --password=PASSWORD
```

Um ein bestimmtes Modul, wie z.B. "Wissenschaftliche-Methodik" oder "Datenerhebung-Statistik", zu erzeugen können sie die Option "--modul" wie folgt nutzen:

```
> docker run -v /tmp/Vorlesungsskripte:/home/Vorlesungen/results -it nmarkgraf/make-vorlesungen:latest --repourl=https://github.com/luebby/Vorlesungsfolien.git--username=USERNAME --password=PASSWORD --modul=Wissenschaftliche-Methodik 
```


### Was genau passiert im Hintergrund?

Mit "--modul=<Modulbezeichnung>" wird dann das Skript "<Modulbezeichung>.Rmd" übersetzt.

Dazu wird das angegebene Repository innerhalb des Docker Images mit git geclont und die Dateien "RunMeFirst.R" (sofern vorhanden) und "makerender.R <Modulbezeichnung>" aus dem Repository ausgeführt.

Nach erfolgreichem Übersetzen werden alle Dateien <Modulbezeichnung>*.pdf aus dem Hauptverzeichnis (des Docker Images Pfad: /home/Vorlesungen/results) in das lokale Verzeichnis (in unserem Beispiel "/tmp/Vorlesungsskripte") kopiert. 


### Wo sind dann die Ergebnisse?

Sie finden also die Dokumente z.B. mittels:

```
ls -al /tmp/Vorlesungsskripte
```



## Wie können Entwickler neue images auf den *Docker hub* speichern?

Neue Versionen können (von Berechtigten!) mittels

```
> docker push nmarkgraf/make-vorlesungen
```

erstellt werden! 

Der gesamte Erstellungszyklus lautet also:


```
> docker build -t nmarkgraf/make-vorlesungen .
> docker tag nmarkgraf/make-vorlesungen nmarkgraf/make-vorlesungen:v0.6
> docker push nmarkgraf/make-vorlesungen
```


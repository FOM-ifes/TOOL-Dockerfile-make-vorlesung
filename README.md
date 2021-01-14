# Dockerfile make-vorlesung

Dockerfile und Co zum Erzeugen eines Docker images zum Übersetzen von Vorlesungsskripten


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
make /tmp/Vorlesungsskripte
```

Ihr lokales Verzeichnis "/tmp/Vorlesungsskripte" soll also für das Docker Images: "/home/Vorlesungen/results" heissen.

Dazu müssen Sie beim Aufruf des Docker Images die Option "-v" nutzen. D.h. also die Option "-v /tmp/Vorlesungsskripte:/home/Vorlesungen/results" angeben.

Starten eines Docker images mittels:

```
> docker run -v /tmp/Vorlesungsskripte:/home/Vorlesungen/results \ 
              -it nmarkgraf/make-vorlesungen:<tag>
```

Mittels 
```
> docker run -v /tmp/Vorlesungsskripte:/home/Vorlesungen/results \ 
              -it nmarkgraf/make-vorlesungen:latest
```

erhält mensch eine kleinen Hilfetext.

Um ein bestimmtes Repository zu benutzen, muss man die URL angeben. Dies passiert mit der Option "--repourl".
Wollen Sie z.B. das Repository **luebby/Vorlesungen** von GitHub nutzen,so müssen sie die Option:
"--repourl=https://github.com/luebby/Vorlesungen.git" angeben.

Das GitHub-Repository **NMarkgraf/MathGrundDer-W-Info** mit der Option: 
"--repourl=https://github.com/NMarkgraf/MathGrundDer-W-Info.git"

Bei privaten Repositories müssen Sie sich erst authentifizieren.

Sollten Sie die 2-Faktoren-Authentifikation von GitHub nutzen, so müssen Sie mit SSH Schlüsseln arbeiten. (Siehe weiter unten!)

Sollten Sie sich nur mittels Nutzername und Passwort einloggen können, so können Sie mittels "--username=<USERNAME>" und "--password=<PASSWORD>"
die Zugangsdaten angeben. 

**Wichtig:** Das funktioniert nur, wenn man **keine 2-Faktoren-Authentifizierung aktiv**iert hat!

```
> docker run -v /tmp/Vorlesungsskripte:/home/Vorlesungen/results \
             -it nmarkgraf/make-vorlesungen:latest \
             --repourl=https://github.com/luebby/Vorlesungen.git \
             --username=USERNAME \
             --password=PASSWORD
```

Um ein bestimmtes Modul, wie z.B. "Wissenschaftliche-Methodik" oder "Datenerhebung-Statistik", zu erzeugen können sie die Option "--modul" wie folgt nutzen:

```
> docker run -v /tmp/Vorlesungsskripte:/home/Vorlesungen/results \
             -it nmarkgraf/make-vorlesungen:latest \
             --repourl=https://github.com/luebby/Vorlesungsfolien.git \
             --username=USERNAME \
             --password=PASSWORD \
             --modul=Wissenschaftliche-Methodik 
```

Mit "--modul=<Modulbezeichnung>" wird dann das Skript "<Modulbezeichung>.Rmd" übersetzt.

Dazu wird das angegebene Repository geclont und die Dateien "RunMeFirst.R" und "makerender.R" aus dem Repository ausgeführt.

Anschliessend werden alle PDF Dateien aus dem Hauptverzeichnis (des Repositories) unter "/tmp/Vorlesungsskripte:/home/Vorlesungen/results" (also dem lokalen Verzeichnis) gespeichert. 

Sie finden also die Dokumente z.B. mittels:

```
ls -al /tmp/Vorlesungsskripte
```

**Hinweis:**
Statt **USERNAME** und **PASSWORD** müssen (ggf. bei privaten Repositories) 
die Login-Daten für GutHub eingesetzt werden!

Zum Schluss werden Unterverzeichnis "results/log" alle erzeugten Log-Dateien 
gespeichert.


## Wie können Entwickler neue images auf den Docker hun speichern?

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


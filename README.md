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

Starten eines Docker images mittels:

```
> docker run -v /Volumes/norman/Docker/results:/home/Vorlesungen/results \ 
              -it nmarkgraf/make-vorlesungen:<tag>
```

Um ein bestimmtes Repository zu benutzen:

```
> docker run -v /Volumes/norman/Docker/results:/home/Vorlesungen/results \
             -it nmarkgraf/make-vorlesungen:latest \
             --repourl=https://github.com/luebby/Vorlesungen \
             --username=USERNAME \
             --password=PASSWORD
```


Um ein bestimmtes Modul zu erzeugen können sie die Option "--modul" wie folgt nutzen:

```
> docker run -v /Volumes/norman/Docker/results:/home/Vorlesungen/results \
             -it nmarkgraf/make-vorlesungen:latest \
             --repourl=https://github.com/luebby/Vorlesungsfolien.git \
             --modul=Wissenschaftliche-Methodik 
```


Damit wird ein Repository geclont und die Dateien "RunMeFirst.R" und "makerender.R" aus dem Repository ausgeführt.
Anschliessend werden alle PDF Dateien aus dem Hauptverzeichnis (des Repositories) unter "/Volmes/norman/Docker/results" (also dem lokalen Verzeichnis) gespeichert.
Statt **USERNAME** und **PASSWORD** müssen (ggf. bei privaten Repositories) 
die Login-Daten für GutHub eingesetzt werden.

Ebenso wird im Unterverzeichnis "log" alle erzeugten LOG Dateien gespeichert.

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

## Aktuelle Version:

- latest: digest: sha256:c3b10966899c75cdeb5e86d6f64a79e0f70b19a5285d479d5adbf2d51cb72d77 size: 3469

- v0.5: digest: sha256:c3b10966899c75cdeb5e86d6f64a79e0f70b19a5285d479d5adbf2d51cb72d77 size: 3469



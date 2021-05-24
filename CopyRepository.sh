#!/bin/bash

RepositoryOriginal=/Volumes/norman/Projekte/GitHub/Vorlesungen

ReprositoryLocal=/tmp/Vorlesungsskripte

cp -R ${RepositoryOriginal} ${ReprositoryLocal}
chmod -R 777 ${ReprositoryLocal}
rm -f ${ReprositoryLocal}/*.pdf


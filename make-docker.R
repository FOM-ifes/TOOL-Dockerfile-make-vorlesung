#!/usr/bin/env Rscript
# R Skript

# Paket zum Umgang mit GitHub Repositoies
library(git2r)

# Paket zum Parsen von Parametern
library(optparse)

option_list = list(
    make_option(c("-u", "--username"),
                type = "character",
                default = NULL,
                help = "Benutzername GitHub",
                metavar = "character"),
    make_option(c("-p", "--password"),
                type = "character",
                default = NULL,
                help = "Passwort für den GitHub Account",
                metavar = "character"),
    make_option(c("-r", "--repourl"),
                type = "character",
                default = "https://github.com/NMarkgraf/MathGrundDer-W-Info",
                help = "URL zum Repository [default= %default]",
                metavar = "character"),
    make_option(c("-n", "--name"),
                type = "character",
                default = "Vorlesungen",
                help = "Name des Repository [default= %default]",
                metavar = "character")
);

opt_parser <- OptionParser(option_list=option_list);
opt <- parse_args(opt_parser);

# default:
username <- NULL
password <- NULL
if (!is.null(opt$username)) {
  username <- opt$username
}
if (!is.null(opt$username)) {
  password <- opt$password
}

cred <- NULL

# Setzen der Zugangsdaten (falls nötig/möglich)
if (!is.null(username)) {
  if (!is.null(password)) {
    cred <- cred_user_pass(username = username, password = password)
  } else {
    cred <- cred_user_pass(username = username)
  }
} else {
  cred <- NULL
}

repo_name <- opt$name
repo_url <- opt$repourl

# Lade das Repository "Vorlesungen" von GitHub

## Create a temporary directory to hold the repository
# path <- file.path(tempfile(pattern="git2r-"), repo_name)

# Verzeichnis anlegen in welches das Ropsiory geclont wird:
repo_path <- file.path("/home/Vorlesungen", repo_name)
dir.create(repo_path, recursive = TRUE)


print(cred)

## Clone the git2r repository
repo <- clone(url = repo_url,
              local_path = repo_path, 
              credentials = cred)

# In das geklonte Verzeichnis wechseln
setwd(repo_path)

# Zuerst das "RunMeFirst.R" starten, damit alle weiteren Pakete
# installiert werden
source("RunMeFirst.R")

# Den eigentlichen render-Prozess starten:
source("makerender.R")

# Ergebnisse in "results" kopieren

dir_list <- list.files(".", ".pdf$")

results_path <- "/home/Vorlesungen/results"

for (pdf in dir_list) {
  file.copy(from = pdf,
            to = results_path,
            overwrite = TRUE,
            recursive = FALSE,
            copy.mode = TRUE,
            copy.date = TRUE)
}

# Alle Log-dateien ebenfalls kopieren

results_log_path <- file.path(results_path, "log")
dir.create(results_log_path, recursive = TRUE)
dir_list <- list.files(".", ".log$", recursive = TRUE)

for (log in dir_list) {
  file.copy(from = log,
            to = results_log_path,
            overwrite = TRUE,
            recursive = FALSE,
            copy.mode = TRUE,
            copy.date = TRUE)
}
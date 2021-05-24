#!/usr/bin/env Rscript
# =============================================================================
# R Skript - (C) by N. Markgraf in 2021         Version: 1.0 vom 24. Mai 2021
# -----------------------------------------------------------------------------
DEBUG <- FALSE
#DEBUG <- TRUE

# -----------------------------------------------------------------------------
# Paket zum Parsen von Parametern
library(optparse)

option_list = list(
    make_option(
      c("-m", "--modul"),
      type = "character",
      default = "Wissenschaftliche-Methodik",
      help = "Name des zu erstellenden Modul Skriptes [default= %default]",
      metavar = "character")
)

opt_parser <- OptionParser(option_list = option_list);
opt <- parse_args(opt_parser)

modul_name <- paste0(opt$modul)
print(paste("Setze Modulename auf", modul_name))


# -----------------------------------------------------------------------------
# In das locale Repository Verzeichnis wechseln
repo_path <- file.path("/home/Vorlesungen/repo")
setwd(repo_path)

# -----------------------------------------------------------------------------
# Zuerst das "RunMeFirst.R" starten, damit alle weiteren Pakete
# installiert werden
print("Prüfe ob RunMeFirst.R gestartet werden kann!")
if (file.exists("RunMeFirst.R")) {
  print("Starte RunMeFirst.R:")
  #-- Leider überschreibt "source(..)" alle lokalen Variabeln.
  # source("RunMeFirst.R", local=TRUE)
  #-- daher:
  ee <- new.env()
  sys.source('RunMeFirst.R', ee)
}

# -----------------------------------------------------------------------------
print("Pandoc-Filter mit korrekten Zugriffsrechten ausstatten!")
f <- list.files(
  "pandoc-filter/*.py",
  all.files = TRUE,
  full.names = TRUE,
  recursive = TRUE)
Sys.chmod(f, (file.info(f)$mode | "777"))

# -----------------------------------------------------------------------------
# Den eigentlichen render-Prozess starten:
print("Prüfe 'makerender.R' Optionen!")
if (exists("modul_name")) {
  if (!is.null(modul_name)) {
    if (DEBUG) {
      print(paste("makerender.R Optione:", modul_name))
    }
    commandArgs <- function(...) list(modul_name)
  }
} else {
  print("Oops: modul_name fehlt!")
}

# -----------------------------------------------------------------------------
print("Starte makerender.R:")

#ee <- new.env()
#sys.source('makerender.R', ee)
source("makerender.R")

# =============================================================================

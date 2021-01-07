FROM rocker/r-ver:4.0.3

ENV S6_VERSION=v2.1.0.2
ENV RSTUDIO_VERSION=latest
ENV PATH=/usr/lib/rstudio-server/bin:$PATH

# RUN /rocker_scripts/install_rstudio.sh
RUN /rocker_scripts/install_pandoc.sh
RUN /rocker_scripts/install_tidyverse.sh
ENV CTAN_REPO=http://mirror.ctan.org/systems/texlive/tlnet
ENV PATH=/usr/local/texlive/bin/x86_64-linux:$PATH
RUN /rocker_scripts/install_verse.sh

RUN apt-get update && \
    apt-get -y install python3-pip tcl tk expect \
    && pip3 install panflute
RUN apt-get clean
RUN install2.r --error \
    mosaic \
    tidyverse \
    rmarkdown \
    knitr \
    tinytex \
    git2r \
    reticulate \
    plot3D \
    rgl \
    futile.logger \
    formatR \
    futile.options \
    wordcloud \
    lambda.r \
    latex2exp \
    optparse \
    getopt 

RUN mkdir /home/Vorlesungen
RUN mkdir /home/Vorlesungen/results
WORKDIR /home/Vorlesungen

COPY make-docker.R /home/Vorlesungen

ENTRYPOINT ["Rscript", "make-docker.R"]

CMD ["--help"]

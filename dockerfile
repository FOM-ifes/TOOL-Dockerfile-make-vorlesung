FROM rocker/r-ver:4.0.3

ENV S6_VERSION=v2.1.0.2
ENV RSTUDIO_VERSION=latest
ENV PATH=/usr/lib/rstudio-server/bin:$PATH

# RUN /rocker_scripts/install_rstudio.sh
RUN /rocker_scripts/install_python.sh
RUN /rocker_scripts/install_pandoc.sh
RUN /rocker_scripts/install_tidyverse.sh
ENV CTAN_REPO=http://mirror.ctan.org/systems/texlive/tlnet
ENV PATH=/usr/local/texlive/bin/x86_64-linux:$PATH
RUN /rocker_scripts/install_verse.sh

# Installiere notwendige (La-)TeX-Pakete
RUN tlmgr install amscls amsmath amsmath auxhook beamer bigintcalc bitset \
                  etexcmds etoolbox fp geometry gettitlestring hycolor \
                  hyperref iftex intcalc kvdefinekeys kvsetkeys letltxmacro \
                  ltxcmds ms pdfescape pdftexcmds pgf refcount rerunfilecheck \
                  stringenc translator uniquecounter xcolor zapfding eurosym \
                  ragged2e pgfplots xstring fancyvrb framed booktabs caption \
                  verbatimbox readarray listofitems colortbl adjustbox \
                  collectbox csquotes babel-german epstopdf-pkg grfext \
                  fpl mathpazo palatino dvips.x86_64-linux dvips eulervm \
                  symbol psnfss kvoptions infwarerr microtype systeme \
                  hyphen-german was ulem

# Installiere git tcl/tk und ImageMagick
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
                    git tcl tk expect imagemagick \
    && pip3 install panflute
RUN apt-get clean

# Installiere notwendige R Pakete
RUN install2.r --skipinstalled --error \
    futile.logger futile.options \
    git2r \
    optparse getopt \
    mosaic tidyverse \
    rmarkdown knitr tinytex gert credentials \
    plot3D rgl formatR wordcloud lambda.r latex2exp \
    dagitty ggraph tidygraph ggdag \
    fracdiff lmtest timeDate tseries urca zoo RcppArmadillo forecast \
    scatterplot3d vcd seriation plotly visNetwork arulesViz \
    gplots ROCR xts \
    hunspell tokenizers janeaustenr tidytext \
    mnormt psych combinat questionr klaR proto showtext sysfonts emojifont \
    mvtnorm lsr lsa kableExtra ineq ggfortify corrplot AlgDesign nFactors \
    okcupiddata randomForest rpart.plot ggthemes

# Aufräumen
RUN rm -rf /tmp/downloaded_packages

RUN mkdir /home/Vorlesungen
RUN mkdir /home/Vorlesungen/results
WORKDIR /home/Vorlesungen
# Anpassungen der ImageMagick policy, damit nach pdf konvertiert werden kann!
COPY policy.xml /etc/ImageMagick-6/policy.xml
COPY make-docker.R /home/Vorlesungen

# Debug Einstieg
ENTRYPOINT ["/bin/sh"]

# Normales, automatisierter Einstieg
ENTRYPOINT ["Rscript", "make-docker.R"]
CMD ["--help"]

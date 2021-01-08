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
RUN tlmgr install amscls amsmath amsmath auxhook beamer bigintcalc bitset \
                  etexcmds etoolbox fp geometry gettitlestring hycolor \
                  hyperref iftex intcalc kvdefinekeys kvsetkeys letltxmacro \
                  ltxcmds ms pdfescape pdftexcmds pgf refcount rerunfilecheck \
                  stringenc translator uniquecounter xcolor zapfding eurosym \
                  ragged2e pgfplots xstring fancyvrb framed booktabs caption \
                  verbatimbox readarray listofitems colortbl adjustbox \
                  collectbox csquotes babel-german epstopdf-pkg grfext \
                  fpl mathpazo palatino dvips.x86_64-linux dvips eulervm \
                  symbol psnfss kvoptions infwarerr
RUN apt-get update && \
    apt-get -y install git python3-pip tcl tk expect imagemagick \
    && pip3 install panflute
RUN apt-get clean
RUN install2.r --error \
    futile.logger futile.options \
    reticulate \
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

RUN mkdir /home/Vorlesungen
RUN mkdir /home/Vorlesungen/results
WORKDIR /home/Vorlesungen

COPY make-docker.R /home/Vorlesungen

ENTRYPOINT ["Rscript", "make-docker.R"]

CMD ["--help"]

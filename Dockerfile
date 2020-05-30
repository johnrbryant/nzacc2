
FROM rocker/tidyverse

ADD Makefile home/rstudio/Makefile

ADD data home/rstudio/data

ADD src home/rstudio/src

RUN mkdir home/rstudio/out

RUN R -e 'devtools::install_github("statisticsnz/dembase")'

RUN cd home/rstudio; make


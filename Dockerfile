
FROM rocker/verse

COPY data home/rstudio/data
COPY src home/rstudio/src
COPY Makefile home/rstudio/Makefile
COPY nzacc2.Rmd home/rstudio/nzacc2.Rmd

RUN mkdir home/rstudio/out
RUN R -q -e 'devtools::install_github("statisticsnz/dembase")'

RUN cd home/rstudio; make


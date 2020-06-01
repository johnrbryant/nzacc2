
FROM rocker/verse

ADD data home/rstudio/data
ADD src home/rstudio/src
ADD Makefile home/rstudio/Makefile
ADD nzacc2.Rmd home/rstudio/nzacc2.Rmd

RUN mkdir home/rstudio/out
RUN R -e 'devtools::install_github("statisticsnz/dembase")'

RUN cd home/rstudio; make


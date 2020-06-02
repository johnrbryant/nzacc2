

.PHONY: all
all: nzacc2.pdf


out/plot_theme.rds: src/plot_theme.R
	Rscript $<


## Prepare data

out/census.rds: src/census.R \
                data/Age_by_sex/TABLECODE8001_Data_e35fb0f7-8ed5-4d62-86c4-269454dd04f4.csv
	Rscript $<

out/idi.rds: src/idi.R \
             data/exp-pop-estimates-2007-16-csv.csv
	Rscript $<

out/reg_births.rds : src/reg_births.R \
                     data/VSB355801_20181209_055056_66.csv
	Rscript $<

out/reg_deaths.rds : src/reg_deaths.R \
                     data/VSD349201_20181209_054420_13.csv
	Rscript $<


## Graphs of data

out/fig_census.pdf: src/fig_census.R \
                    out/census.rds \
                    out/plot_theme.rds
	Rscript $<

out/fig_reg_births.pdf: src/fig_reg_births.R \
                        out/reg_births.rds \
                        out/plot_theme.rds
	Rscript $<

out/fig_reg_deaths.pdf: src/fig_reg_deaths.R \
                        out/reg_deaths.rds \
                        out/plot_theme.rds
	Rscript $<



## Report


nzacc2.pdf: nzacc2.Rmd \
            out/fig_census.pdf \
            out/fig_reg_births.pdf \
            out/fig_reg_deaths.pdf
	Rscript -e "rmarkdown::render('$<')"


## Clean up

.PHONY: clean
clean:
	rm -rf out
	mkdir -p out


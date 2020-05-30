

.PHONY: all
all: out/fig_census_idi.pdf


out/plot_theme.rds: src/plot_theme.R
	Rscript $<


## Prepare data

out/census.rds: src/census.R \
                data/Age_by_sex/TABLECODE8001_Data_e35fb0f7-8ed5-4d62-86c4-269454dd04f4.csv
	Rscript $<

out/idi.rds: src/idi.R \
             data/exp-pop-estimates-2007-16-csv.csv
	Rscript $<


## Graphs of data

out/fig_census_idi.pdf: src/fig_census_idi.R \
                        out/census.rds \
                        out/idi.rds \
                        out/plot_theme.rds
	Rscript $<


## Clean up

.PHONY: clean
clean:
	rm -rf out
	mkdir -p out


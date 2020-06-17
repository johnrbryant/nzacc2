

.PHONY: all
all: nzacc2.pdf


## Shared parameters

out/plot_theme.rds: src/plot_theme.R
	Rscript $<

out/palette.rds: src/palette.R
	Rscript $<


## Graphs of data

out/fig_census.pdf: src/fig_census.R \
                    calc/out/census.rds \
                    out/plot_theme.rds \
                    out/palette.rds
	Rscript $<

out/fig_reg_births_age.pdf: src/fig_reg_births_age.R \
                            calc/out/reg_births_age.rds \
                            out/plot_theme.rds \
                            out/palette.rds
	Rscript $<

out/fig_reg_births_sex.pdf: src/fig_reg_births_sex.R \
                            calc/out/reg_births_sex.rds \
                            out/plot_theme.rds \
                            out/palette.rds
	Rscript $<

out/fig_reg_deaths.pdf: src/fig_reg_deaths.R \
                        calc/out/reg_deaths.rds \
                        out/plot_theme.rds \
                        out/palette.rds
	Rscript $<

out/fig_migration_arrivals.pdf: src/fig_migration.R \
                                calc/out/migration.rds \
                                out/plot_theme.rds \
                                out/palette.rds
	Rscript $< --direction=arrivals

out/fig_migration_departures.pdf: src/fig_migration.R \
                                  calc/out/migration.rds \
                                  out/plot_theme.rds \
                                  out/palette.rds
	Rscript $< --direction=departures




## Report


nzacc2.pdf: nzacc2.Rmd \
            out/fig_census.pdf \
            out/fig_reg_births_age.pdf \
            out/fig_reg_births_sex.pdf \
            out/fig_reg_deaths.pdf \
            out/fig_migration_arrivals.pdf \
            out/fig_migration_departures.pdf
	Rscript -e "rmarkdown::render('$<')"


## Clean up

.PHONY: clean
clean:
	rm nzacc2.pdf
	rm -rf out
	mkdir -p out


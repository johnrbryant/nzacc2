

.PHONY: all
all: nzacc2.pdf \
     out/fig_est_popn_small_male.pdf \
     out/fig_est_width_age_sex.pdf \
     out/fig_est_census_cover_small.pdf \
     out/fig_est_mort.pdf \
     out/fig_est_lifeexp_small.pdf

## Shared parameters

out/plot_theme.rds: src/plot_theme.R
	Rscript $<

out/palette.rds: src/palette.R
	Rscript $<



## Values from data

out/vals_data_census.rds: src/vals_data_census.R \
                          calc/out/census.rds
	Rscript $<

out/vals_data_regbirths_age.rds: src/vals_data_regbirths_age.R \
                                 calc/out/reg_births_age.rds
	Rscript $<

out/vals_data_regbirths_sex.rds: src/vals_data_regbirths_sex.R \
                                 calc/out/reg_births_sex.rds
	Rscript $<

out/vals_data_regdeaths.rds: src/vals_data_regdeaths.R \
                             calc/out/reg_deaths.rds
	Rscript $<

out/vals_data_migration.rds: src/vals_data_migration.R \
                             calc/out/migration.rds
	Rscript $<

out/vals_direct_mort.rds: src/vals_direct_mort.R \
                          calc/out/datasets.rds
	Rscript $<



## Graphs of data

out/fig_data_census.pdf: src/fig_data_census.R \
                         out/vals_data_census.rds \
                         out/plot_theme.rds \
                         out/palette.rds
	Rscript $<

out/fig_data_regbirths_age.pdf: src/fig_data_regbirths_age.R \
                                out/vals_data_regbirths_age.rds \
                                out/plot_theme.rds \
                                out/palette.rds
	Rscript $<

out/fig_data_regbirths_sex.pdf: src/fig_data_regbirths_sex.R \
                                out/vals_data_regbirths_sex.rds \
                                out/plot_theme.rds \
                                out/palette.rds
	Rscript $<

out/fig_data_regdeaths.pdf: src/fig_data_regdeaths.R \
                            out/vals_data_regdeaths.rds \
                            out/plot_theme.rds \
                            out/palette.rds
	Rscript $<

out/fig_data_migration_arrivals.pdf: src/fig_data_migration.R \
                                     out/vals_data_migration.rds \
                                     out/plot_theme.rds \
                                     out/palette.rds
	Rscript $< --direction=arrivals

out/fig_data_migration_departures.pdf: src/fig_data_migration.R \
                                       out/vals_data_migration.rds \
                                       out/plot_theme.rds \
                                       out/palette.rds
	Rscript $< --direction=departures


## Values from model

out/vals_est_popn.rds: src/vals_est_popn.R \
                       calc/out/model_base.est
	Rscript $<

out/vals_est_width_age.rds: src/vals_est_width_age.R \
                            calc/out/model_base.est
	Rscript $<

out/vals_est_width_age_sex.rds: src/vals_est_width_age_sex.R \
                                calc/out/model_base.est
	Rscript $<

out/vals_est_width_time.rds: src/vals_est_width_time.R \
                             calc/out/model_base.est
	Rscript $<

out/vals_est_lifeexp.rds: src/vals_est_lifeexp.R \
                          calc/out/model_base.est
	Rscript $<

out/vals_est_mort.rds: src/vals_est_mort.R \
                          calc/out/model_base.est
	Rscript $<

out/vals_est_tfr.rds: src/vals_est_tfr.R \
                      calc/out/model_base.est
	Rscript $<

out/vals_est_census_cover.rds: src/vals_est_census_cover.R \
                               calc/out/model_base.est
	Rscript $<


## Graphs of estimates

out/fig_est_popn_female.pdf: src/fig_est_popn.R \
                             out/vals_est_popn.rds \
                             out/vals_data_census.rds \
                             out/plot_theme.rds \
                             out/palette.rds
	Rscript $< --sex=female

out/fig_est_popn_male.pdf: src/fig_est_popn.R \
                           out/vals_est_popn.rds \
                           out/vals_data_census.rds \
                           out/plot_theme.rds \
                           out/palette.rds
	Rscript $< --sex=male

out/fig_est_popn_small_female.pdf: src/fig_est_popn_small.R \
                             out/vals_est_popn.rds \
                             out/vals_data_census.rds \
                             out/plot_theme.rds \
                             out/palette.rds
	Rscript $< --sex=female

out/fig_est_popn_small_male.pdf: src/fig_est_popn_small.R \
                           out/vals_est_popn.rds \
                           out/vals_data_census.rds \
                           out/plot_theme.rds \
                           out/palette.rds
	Rscript $< --sex=male

out/fig_est_width_time.pdf: src/fig_est_width_time.R \
                            out/vals_est_width_time.rds \
                            out/plot_theme.rds \
                            out/palette.rds
	Rscript $<

out/fig_est_width_age.pdf: src/fig_est_width_age.R \
                           out/vals_est_width_age.rds \
                           out/plot_theme.rds \
                           out/palette.rds
	Rscript $<

out/fig_est_width_age_sex.pdf: src/fig_est_width_age_sex.R \
                           out/vals_est_width_age_sex.rds
	Rscript $<

out/fig_est_mort.pdf: src/fig_est_mort.R \
                         out/vals_est_mort.rds \
                         out/vals_direct_mort.rds \
                         out/palette.rds
	Rscript $<

out/fig_est_lifeexp.pdf: src/fig_est_lifeexp.R \
                         out/vals_est_lifeexp.rds \
                         out/plot_theme.rds \
                         out/palette.rds
	Rscript $<

out/fig_est_lifeexp_small.pdf: src/fig_est_lifeexp_small.R \
                         out/vals_est_lifeexp.rds \
                         out/palette.rds
	Rscript $<

out/fig_est_tfr.pdf: src/fig_est_tfr.R \
                     out/vals_est_tfr.rds \
                     out/plot_theme.rds \
                     out/palette.rds
	Rscript $<

out/fig_est_census_cover.pdf: src/fig_est_census_cover.R \
                              out/vals_est_census_cover.rds \
                              out/plot_theme.rds \
                              out/palette.rds
	Rscript $<

out/fig_est_census_cover_small.pdf: src/fig_est_census_cover_small.R \
                              out/vals_est_census_cover.rds \
                              out/palette.rds
	Rscript $<


## Report


nzacc2.pdf: nzacc2.Rmd \
            out/fig_data_census.pdf \
            out/fig_data_regbirths_age.pdf \
            out/fig_data_regbirths_sex.pdf \
            out/fig_data_regdeaths.pdf \
            out/fig_data_migration_arrivals.pdf \
            out/fig_data_migration_departures.pdf \
            out/fig_est_popn_female.pdf \
            out/fig_est_popn_male.pdf \
            out/fig_est_width_time.pdf \
            out/fig_est_width_age.pdf \
            out/fig_est_lifeexp.pdf \
            out/fig_est_tfr.pdf \
            out/fig_est_census_cover.pdf
	Rscript -e "rmarkdown::render('$<')"


## Clean up

.PHONY: clean
clean:
	rm nzacc2.pdf
	rm -rf out
	mkdir -p out


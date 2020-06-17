
MULT = 1
N_CHAIN = 4

.PHONY: all
all: out/model_base.est

.PHONY: inputs
inputs: out/datasets.rds \
        out/data_models.rds \
        out/system_models.rds \
        out/account.rds


## Prepare data

out/census.rds: src/census.R \
                data/Age_by_sex/TABLECODE8001_Data_e35fb0f7-8ed5-4d62-86c4-269454dd04f4.csv
	Rscript $<

out/net_undercount.rds: src/net_undercount.R
	Rscript $<

out/idi.rds: src/idi.R \
             data/exp-pop-estimates-2007-16-csv.csv
	Rscript $<

out/reg_births_age.rds : src/reg_births_age.R \
                         data/VSB355801_20181209_055056_66.csv
	Rscript $<

out/reg_births_sex.rds : src/reg_births_sex.R \
                         data/VSB357002_20200608_085016_54.csv
	Rscript $<

out/reg_deaths.rds : src/reg_deaths.R \
                     data/VSD349201_20181209_054420_13.csv
	Rscript $<

out/migration.rds : src/migration.R \
                    data/ITM552105_20200603_110236_41.csv
	Rscript $<


## Construct model

out/datasets.rds: src/datasets.R \
                  out/census.rds \
                  out/reg_births_age.rds \
                  out/reg_births_sex.rds \
                  out/reg_deaths.rds \
                  out/migration.rds
	Rscript $<

out/data_models.rds: src/data_models.R \
                     out/census.rds \
                     out/net_undercount.rds
	Rscript $<

out/system_models.rds: src/system_models.R
	Rscript $<

out/account.rds: src/account.R \
                 out/census.rds \
                 out/reg_births_age.rds \
                 out/reg_deaths.rds \
                 out/migration.rds
	Rscript $<

out/model_base.est: src/model_base.R \
                    out/account.rds \
                    out/system_models.rds \
                    out/datasets.rds \
                    out/data_models.rds
	Rscript $< --mult=$(MULT) \
                   --n_chain=$(N_CHAIN)


## Clean up

.PHONY: clean
clean:
	rm -rf out
	mkdir -p out


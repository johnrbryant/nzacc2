

.PHONY: all
all: out/census.rds


## Prepare data

out/census.rds : src/census.R \
                 data/Age_by_sex/TABLECODE8001_Data_e35fb0f7-8ed5-4d62-86c4-269454dd04f4.csv
	Rscript $<


## Clean up

.PHONY: clean
clean:
	rm -rf out
	mkdir -p out


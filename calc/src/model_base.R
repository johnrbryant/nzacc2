
library(demest)
library(dplyr)
library(docopt)
'
Usage:
model_base.R [options]
Options:
--mult [default: 0.001]
--n_chain [default: 4]
' -> doc
opts <- docopt(doc)
mult <- opts$mult %>% as.numeric()
n_chain <- opts$n_chain %>% as.integer()

min_burnin <- 10000
target_iter <- 1000
n_burnin <- mult * min_burnin
n_sim <- mult * min_burnin
n_thin <- max((n_sim * n_chain) / target_iter, 1)

set.seed(0)

account <- readRDS("out/account.rds")
system_models <- readRDS("out/system_models.rds")
datasets <- readRDS("out/datasets.rds")
data_models <- readRDS("out/data_models.rds")

filename <- "out/model_base.est"

Sys.time()
estimateAccount(account = account,
                systemModels = system_models,
                datasets = datasets,
                dataModels = data_models,
                probSmallUpdate = 0.25,
                filename = filename,
                nBurnin = n_burnin,
                nSim = n_sim,
                nThin = n_thin,
                nChain = n_chain)
Sys.time()
options(width = 120)
fetchSummary(filename, nSample = 100)
                
                
                

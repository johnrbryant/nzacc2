
library(demest)

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
                nBurnin = 2000,
                nSim = 2000,
                nThin = 10,
                nChain = 5)
Sys.time()
options(width = 120)
fetchSummary(filename, nSample = 100)
                
                
                

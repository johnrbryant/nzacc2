
library(demest)
library(dplyr)


population  <- Model(population ~ Poisson(mean ~ age * sex + age * time,
                                          useExpose = FALSE),
                     age ~ DLM(damp = NULL,
                               trend = NULL),
                     age:sex ~ DLM(damp = NULL,
                                   trend = NULL),
                     time ~ DLM(trend = NULL,
                                damp = NULL),
                     age:time ~ DLM(damp = NULL,
                                    trend = NULL),
                     jump = 0.011)

births <- Model(births ~ Poisson(mean ~ age * time + sex),
                age ~ DLM(trend = NULL,
                          damp = NULL),
                time ~ DLM(trend = NULL,
                           damp = NULL),
                age:time ~ DLM(trend = NULL,
                               damp = NULL),
                jump = 0.11)

deaths <- Model(deaths ~ Poisson(mean ~ age * sex + age * time),
                age ~ DLM(damp = NULL,
                          covariates = Covariates(infant = TRUE)),
                age:sex ~ DLM(trend = NULL,
                              damp = NULL),
                age:time ~ DLM(trend = NULL,
                               damp = NULL),
                time ~ DLM(damp = NULL))

immigration  <- Model(immigration ~ Poisson(mean ~ (age + sex + time)^2),
                      age ~ DLM(trend = NULL,
                                damp = NULL),
                      time ~ DLM(trend = NULL,
                                 damp = NULL),
                      age:sex ~ DLM(trend = NULL,
                                    damp = NULL),
                      sex:time ~ DLM(trend = NULL,
                                    damp = NULL),
                      age:time ~ DLM(trend = NULL,
                                     damp = NULL),
                      jump = 0.09)

emigration  <- Model(emigration ~ Poisson(mean ~ (age + sex + time)^2),
                     age ~ DLM(trend = NULL,
                               damp = NULL),
                     time ~ DLM(trend = NULL,
                                damp = NULL),
                     age:sex ~ DLM(trend = NULL,
                                   damp = NULL),
                     sex:time ~ DLM(trend = NULL,
                                    damp = NULL),
                     age:time ~ DLM(trend = NULL,
                                    damp = NULL),
                     jump = 0.04)

system_models <- list(population = population,
                      births = births,
                      deaths = deaths,
                      immigration = immigration,
                      emigration = emigration)

saveRDS(system_models,
        file = "out/system_models.rds")

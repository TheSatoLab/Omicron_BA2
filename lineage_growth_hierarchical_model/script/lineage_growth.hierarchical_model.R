#!/usr/bin/env R

library(tidyverse)
library(cmdstanr)

#model
stan_f.name <- 'script/multinomial_hierarchical.stan'
multi_nomial_model <- cmdstan_model(stan_f.name)

generation_time <- 2.1

data.stan <- readRDS('input/stan.input.list.rds')
country.df <- read.table('input/country_Id.txt',header=T,sep="\t")

group.df <- data.frame(group_Id = 1:4, group = colnames(data.stan$Y))


fit.stan <- multi_nomial_model$sample(
    data=data.stan,
    iter_sampling=2000,
    iter_warmup=1000,
    seed=1234,
    parallel_chains = 4,
    chains=4)

#growth rate mean
stat.info.mean <- fit.stan$summary("growth_rate_mean") %>% as.data.frame()
stat.info.mean <- stat.info.mean %>% mutate(group_Id = str_match(variable,'growth_rate_mean\\[([0-9]+)\\]')[,2] %>% as.numeric() + 1)
stat.info.mean.merged <- merge(stat.info.mean,group.df,by="group_Id") %>% select(-group_Id,-variable)

#growth_rate each country
stat.info.each <- fit.stan$summary("growth_rate") %>% as.data.frame()
stat.info.each <- stat.info.each %>% mutate(country_Id = str_match(variable,'growth_rate\\[([0-9]+),[0-9]+\\]')[,2] %>% as.numeric(), group_Id = str_match(variable,'growth_rate\\[[0-9]+,([0-9]+)\\]')[,2] %>% as.numeric() + 1)
stat.info.each.merged <- stat.info.each %>% inner_join(group.df,by="group_Id") %>% inner_join(country.df,by="country_Id") %>% select(-group_Id,-country_Id,-variable)

out.name <- 'output/growth_rate.mean.txt'
write.table(stat.info.mean.merged,out.name,col.names=T,row.names=F,sep="\t",quote=F)

out.name <- 'output/growth_rate.each_country.txt'
write.table(stat.info.each.merged,out.name,col.names=T,row.names=F,sep="\t",quote=F)



# A hierarchical Bayesian statistical model to represent the epidemic dynamics of SARS-CoV-2 lineages

## Summary
We constructed a hierarchical Bayesian statistical model to represent the relative lineage growth dynamics with a multinomial logistic regression. This model is basically the same to the one used in [out previous study](https://www.nature.com/articles/s41586-022-04462-1 "Omicron paper"). However, in the present study, we incorporated a hierarchical structure into the slope parameter over time, which enable us to estimate the global average of the relative effective reproduction number of each viral lineage as well as that in each country. Arrays in the model index over one or more indices: viral lineages l; countries c; and days t. The model is:

![\bm{\beta_{lc}}\simStudent\_t(6,\bm{\beta_l},\bm{\sigma_{l}})](https://latex.codecogs.com/gif.latex?\bm{\beta_{lc}}\simStudent\_t(6,\bm{\beta_l},\bm{\sigma_{l}}))  
![\bm{\mu_{lct}}=\bm{\alpha_{lc}}+\bm{\beta_{lc}}t](https://latex.codecogs.com/gif.latex?\bm{\mu_{lct}}=\bm{\alpha_{lc}}+\bm{\beta_{lc}}t)  
![\bm{\theta_{.ct}}=softmax(\bm{\mu_{.ct}})](https://latex.codecogs.com/gif.latex?\bm{\theta_{.ct}}=softmax(\bm{\mu_{.ct}}))  
![\bm{y_{lct}}\simMultinomial(\sum_{l}\bm{y_{lct}},\bm{\theta_{.ct}})](https://latex.codecogs.com/gif.latex?\bm{y_{lct}}\simMultinomial(\sum_{l}\bm{y_{lct}},\bm{\theta_{.ct}}))  

![softmax(\bm{x}) = \frac{exp(\bm{x})}{\sum_{i} exp(\bm{x_i})}](https://latex.codecogs.com/gif.latex?softmax(\bm{x}) = \frac{exp(\bm{x})}{\sum_{i} exp(\bm{x_i})})  


![\bm{r_{lc}} = exp(\gamma \bm{\beta_{lc}})](https://latex.codecogs.com/gif.latex?\bm{r_{lc}} = exp(\gamma \bm{\beta_{lc}}))  


![\bm{r_{l}} = exp(\gamma \bm{\beta_{l}})](https://latex.codecogs.com/gif.latex?\bm{r_{l}} = exp(\gamma \bm{\beta_{l}}))  












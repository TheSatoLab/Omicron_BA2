# A hierarchical Bayesian statistical model to represent the epidemic dynamics of SARS-CoV-2 lineages

## Summary
We constructed a Bayesian hierarchical statistical model to represent the relative lineage growth dynamics with a multinomial logistic regression. This model is basically the same to the one used in [out previous study](https://www.nature.com/articles/s41586-022-04462-1 "Omicron paper"). However, in the present study, we incorporated a hierarchical structure into the slope parameter over time, which enable us to estimate the global average of the relative effective reproduction number of each viral lineage as well as that in each country. Arrays in the model index over one or more indices: viral lineages l; countries c; and days t.  
The model is:

![\begin{align*}
\beta_{lc}\sim\ Student\_t(6,\beta_l,\sigma_{l})
\end{align*}
](https://render.githubusercontent.com/render/math?math=%5Cdisplaystyle+%5Cbegin%7Balign%2A%7D%0A%5Cbeta_%7Blc%7D%5Csim%5C+Student%5C_t%286%2C%5Cbeta_l%2C%5Csigma_%7Bl%7D%29%0A%5Cend%7Balign%2A%7D%0A)  

![\begin{align*}
\mu_{lct}=\alpha_{lc}+\beta_{lc}t
\end{align*}
](https://render.githubusercontent.com/render/math?math=%5Cdisplaystyle+%5Cbegin%7Balign%2A%7D%0A%5Cmu_%7Blct%7D%3D%5Calpha_%7Blc%7D%2B%5Cbeta_%7Blc%7Dt%0A%5Cend%7Balign%2A%7D%0A)

![\begin{align*}
\theta_{.ct}=softmax(\mu_{.ct})
\end{align*}
](https://render.githubusercontent.com/render/math?math=%5Cdisplaystyle+%5Cbegin%7Balign%2A%7D%0A%5Ctheta_%7B.ct%7D%3Dsoftmax%28%5Cmu_%7B.ct%7D%29%0A%5Cend%7Balign%2A%7D%0A)

![\begin{align*}
y_{lct}\sim Multinomial(\sum_{l}y_{lct},\theta_{.ct})
\end{align*}
](https://render.githubusercontent.com/render/math?math=%5Cdisplaystyle+%5Cbegin%7Balign%2A%7D%0Ay_%7Blct%7D%5Csim+Multinomial%28%5Csum_%7Bl%7Dy_%7Blct%7D%2C%5Ctheta_%7B.ct%7D%29%0A%5Cend%7Balign%2A%7D%0A)

The explanatory variable is time t, and the outcome variable is y<sub>lct</sub>, which represents the count of viral lineage l in country c at time t. The slope parameter of lineage l in country c, beta<sub>lc</sub>, is generated from a student’s t distribution with the hyper parameters of the mean beta<sub>l</sub> and the standard deviation \sigma<sub>l</sub>. As the distribution generating \beta<sub>lc</sub>, we used a student’s t distribution with six degrees of freedom instead of a normal distribution to reduce the effects of outlier values of beta<sub>lc</sub>. In the model, the linear estimator \mu<sub>lct</sub>, consisting of the intercept \alpha<sub>lc</sub> and the slope \beta<sub>lc</sub>, is converted to the simplex \theta<sub>.ct</sub>, which represents the probability of occurrence of each viral lineage at time t in country c, by the softmax link function defined as:

![\begin{align*}
softmax(x)=\frac{exp(x)}{\sum_{i}exp(x_i)}
\end{align*}
](https://render.githubusercontent.com/render/math?math=%5Cdisplaystyle+%5Cbegin%7Balign%2A%7D%0Asoftmax%28x%29%3D%5Cfrac%7Bexp%28x%29%7D%7B%5Csum_%7Bi%7Dexp%28x_i%29%7D%0A%5Cend%7Balign%2A%7D%0A)

y<sub>lct</sub> is generated from \theta<sub>lct</sub> and the total count of all lineages at l in country c according to a multinomial distribution.
	The relative effective reproduction number of each viral lineage in each county (r<sub>lc</sub>) was calculated according to the slope parameter \beta<sub>lc</sub> as:

![\begin{align*}
r_{lc}=exp(\gamma\beta_{lc})
\end{align*}
](https://render.githubusercontent.com/render/math?math=%5Cdisplaystyle+%5Cbegin%7Balign%2A%7D%0Ar_%7Blc%7D%3Dexp%28%5Cgamma%5Cbeta_%7Blc%7D%29%0A%5Cend%7Balign%2A%7D%0A)


where \gamma is the average viral generation time (2.1 day) (http://sonorouschocolate.com/covid19/index.php?title=Estimating_Generation_Time_Of_Omicron). Similarly, the global average of the relative effective reproduction number of each viral lineage was calculated according to the slope hyper parameter \beta<sub>l</sub> as:

![\begin{align*}
r_{l}=exp(\gamma\beta_{l})
\end{align*}
](https://render.githubusercontent.com/render/math?math=%5Cdisplaystyle+%5Cbegin%7Balign%2A%7D%0Ar_%7Bl%7D%3Dexp%28%5Cgamma%5Cbeta_%7Bl%7D%29%0A%5Cend%7Balign%2A%7D%0A)














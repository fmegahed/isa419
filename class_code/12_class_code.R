

# * UFO Sightings ---------------------------------------------------------
pacman::p_load(tidyverse)

df = read_csv('data/zeroAccessUFO.csv') # using the readr read_csv function

glimpse(df) # prints the num rows, cols, col types and first few obs (dplyr pkg loaded w tidyverse)


# * Making the Data Technically Correct -----------------------------------
# numeric variables are indeed numeric since they are counts and population-level data
# for the purpose of predictive modeling, we should (in R) convert chr variables to factor

df$subregion = as.factor(df$subregion) # one variable at a time conversion

df = df %>% 
  mutate(across( where(is.character), .fns = as.factor ) ) # convert remaining chr cols to fact

glimpse(df) # expecting first two cols to be factor instead of chr



# * Plot the Data ---------------------------------------------------------

df %>% 
  # empty canvas with correct x-axis and y-axis limits
  ggplot(mapping = aes(x = ufo2010, y = infections)) +
  # add a layer for points
  geom_point() +
  # add the regression line
  stat_smooth(method = 'lm') # lm is for linear model (e.g., linear regression)


# * Linear Regression in R ------------------------------------------------

fitted_model = lm(formula = infections ~ ufo2010, # infections as a function of ufo2010 (y ~ x)
                  data = df) # the name of the object where you stored the data

summary(fitted_model)

# From the model output, the r2 is 0.7479 
# (which means that 75% variability in y [infections] is explained by x [ufo2010])

cor(x = df$ufo2010, y = df$infections)
0.8648362^2

# Why are the models' results not surprising?


fitted_model2 = lm(formula = infections ~ pop, # infections as a function of pop (y ~ x)
                  data = df) # the name of the object where you stored the data
summary(fitted_model2)

# Why you cannot tell your CISO that the DDoS attacks are happening due to Aliens?
### correlation does not mean causation
### you can get good predictive models that are completely useless (inactionable)

fitted_model3 = lm(formula = infections ~ pop + ufo2010, # infections as a function of pop (y ~ x)
                   data = df) # the name of the object where you stored the data
summary(fitted_model3)



# * For Regression Problems (Metrics) -------------------------------------

# The basis for evaluation is going to be based on "error" [residual]
# error = actual - fitted/predicted_value 

# our actuals are in the df
# same as df$infections
actuals = fitted_model2$model$infections # stored inside model under response var name 
fitted_values = fitted_model2$fitted.values # predictions made by the model
errors = actuals - fitted_values # errors/residuals

fitted_model2$residuals

# popular error metrics
# mean error: measures the bias in your model (we want this to be close to 0)
me = mean(errors) # close to 0 -> not biased
# mean absolute error
mae = mean( abs(errors) ) # 21.8 (on avg my prediction 21.8 away from the actual)
# rmse
rmse = sqrt( mean(errors^2) )
# mape
mape =  100*mean( abs(errors/actuals) ) # works great for non-zero actuals

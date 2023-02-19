library(tidyverse)
library(lubridate)
install.packages('geosphere')
library(geosphere)
install.packages('geodist')
library(geodist)
install.packages('corrplot')
library(caret)
library(neuralnet)

kc_data = read.csv('C:/Users/shah9/OneDrive/Desktop/IMT 572A/kc_house_data.csv')
view(kc_data)


kc_data$date = str_replace(kc_data$date, 'T000000', '')

kc_data$date = as.Date(kc_data$date, format = '%Y%m%d')

kc_data = kc_data %>% filter(bedrooms <= 11)

view(kc_data)

mean(kc_data$price)


kc_zip = kc_data %>% filter(zipcode == 98034)
mean(kc_zip$price)
sd(kc_zip$price)



kc_data$yr_sold = year(kc_data$date)
kc_data$age = kc_data$yr_sold - kc_data$yr_built
kc_data$renovated = ifelse(((kc_data$yr_sold - kc_data$yr_renovated) <= 10) | (kc_data$age <= 5), 1, 0)


kc_dist_df = data.frame(lat = 47.6062, long = -122.3321)

for(i in 1:nrow(kc_data)){
  vec <- c(47.6062, -122.3321)
  kc_dist_df[i,] <- vec
}
kc_dist_df  

latitude = kc_data$lat
longitude = kc_data$long

kc_data_dist_df = data.frame(latitude, longitude)

kc_data$dist = geodist(kc_dist_df, kc_data_dist_df, paired = TRUE, 
                       sequential = FALSE, pad = FALSE, measure = "haversine")
view(kc_data)   
----------------
  
scatter.smooth(x=kc_data$condition, y = kc_data$price) 

scatter.smooth(x=kc_data$sqft_living, y = kc_data$price) 

scatter.smooth(x=kc_data$grade, y = kc_data$price) 

scatter.smooth(x=kc_data$bathrooms, y = kc_data$price) 

scatter.smooth(x=kc_data$dist, y = kc_data$price) 

scatter.smooth(x=kc_data$view, y = kc_data$price) 
  

kc_corr = kc_data %>% select(price,bedrooms, bathrooms, sqft_living, sqft_lot, floors, waterfront, view, grade, 
                             sqft_above,sqft_living15, sqft_lot15, age, renovated, dist)

corr = cor(kc_corr)

library(corrplot)

corrplot(corr, type = "lower", order = "hclust", 
         tl.col = "black", tl.srt = 45)

kc_data_model = lm(price ~ sqft_living + grade + bathrooms + dist + view - 1, kc_data)
summary(kc_data_model)
--------------------
  
  
  
  
  
waterfront_model = glm(kc_data$waterfront ~ kc_data$view, family = 'binomial')
summary(waterfront_model)

kc_data$waterfront_predict = predict(waterfront_model)
boxplot(kc_data$waterfront_predict ~ kc_data$waterfront)

threshold_wf = -5
kc_data$wf = ifelse(kc_data$waterfront_predict <= threshold_wf, 0, 1)

confusionMatrix(as.factor(kc_data$waterfront),
                as.factor(kc_data$wf))


-------------------------
  
library(cluster)
kc_cluster_data = kc_data %>% select(bedrooms,bathrooms,sqft_living,floors,waterfront,price)  

set.seed(1234)

distance = dist(kc_cluster_data[,1:6])
cl = hclust(distance)
plot(cl)

kc_cluster_data$cluster = kmeans(kc_cluster_data, 3)$cluster
clusplot(kc_cluster_data, kc_cluster_data$cluster)



view(kc_cluster_data)
kmeans_clust = kc_cluster_data
summary(kc_cluster_data %>% filter(cluster == 1))
summary(kc_cluster_data %>% filter(cluster == 2))
summary(kc_cluster_data %>% filter(cluster == 3))

















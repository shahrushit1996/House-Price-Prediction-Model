The King County House Dataset offers a plethora of information about the price, size, location, condition, and other characteristics of houses in Washington's King County. Using the dataset, we have used R to create a multivariate linear regression model to forecast property prices.
Following is a comprehensive list of the modules that we utilized in this analysis. 

Dataset Description: 
Rows: 21613
Columns: 21
Quick summary of each variable:
id - Unique ID for each home sold
date - Date of the home sale
price - Price of each home sold
bedrooms - Number of bedrooms
bathrooms - Number of bathrooms, where .5 accounts for a room with a toilet but no shower
sqft_living - Square footage of the apartments interior living space
sqft_lot - Square footage of the land space
floors - Number of floors in the house
waterfront - A dummy variable for whether the apartment was overlooking the waterfront or not
view - An index from 0 to 4 of how good the view of the property was
condition - An index from 1 to 5 on the condition of the apartment,
grade - An index from 1 to 13, where 1-3 falls short of building construction and design, 7 has an
average level of construction and design, and 11-13 have a high quality level of construction and
design.
sqft_above - The square footage of the interior housing space that is above ground level
sqft_basement - The square footage of the interior housing space that is below ground level
yr_built - The year the house was initially built
yr_renovated - The year of the house’s last renovation
zip code - What zip code area the house is in
lat - Latitude
long - Longitude
sqft_living15 - The square footage of interior housing living space for the nearest 15 neighbors
sqft_lot15 - The square footage of the land lots of the nearest 15 neighbors

Data Cleaning:
1. The date column in the original dataset was in the format ‘yyyymmddT000000’. Transformed it to the format 'yyyy-mm-dd'
2. Found a house with 33 bedrooms. Filtered it out.

Data Preparation:
The columns yr_built, yr_renovated, lat, long and zip code even though important did not have any quantitative data which could be utilized for the analysis. In order to use them in an efficient manner we created the following new columns:
yr_sold - This column was created to calculate the age of the houses sold and was derived from the ‘date’ column.
age - We created this column to calculate the age of the house. This was derived from the difference between the ‘yr_sold’ column and ‘yr_built’ column.
renovated - This column was created to help identify if a recently renovated house had an effect on the price. To further simplify, if the house was renovated in the past 10 years or built in the last 5 years we assigned a value 1 and for all other conditions we assigned a value of 0.
dist - Using a map visualization, we realized that from a point (downtown Seattle), the prices might vary for the houses at different locations. So we calculated the distance of the houses from that one point to take into consideration its effect on the pricing.

Regression Model:
1. We used a correaltion matrix to understand if there was any correlation between the independent variables. Variables related to the house area had high correlation. Of these variables sqft_living had the highest correlation with the depedent variable.
2. We used scatter plots to check for individual relationships between the indepent and dependent variables. Based on the results we selected the following variables as input to our price prediction model - sqft_living, bathrooms, dist, grade, view.

The model had a R-square of 0.8914 with a p-value < 0.005

Clustering:
We used an unsupervised clustering model to cluster the houses based on their prices and discovered 3 major clusters:
Cluster 1 (Basic Houses) groups basic houses with small bedrooms and sufficient bathrooms but
less space comparatively.
Cluster 2 (Mid-range Houses) groups slightly better houses with almost the same number of bedrooms
and bathrooms but with larger space as compared to cluster 1.
Cluster 3 (Luxury Houses) groups luxurious houses with the largest area along with the possibility
of having a waterfront which ultimately results in a good view.

A details analysis can be found in the Project Summary Report along with the Final Code.

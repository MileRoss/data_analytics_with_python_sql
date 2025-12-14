![logo_ironhack_blue 7](https://user-images.githubusercontent.com/23629340/40541063-a07a0a8a-601a-11e8-91b5-2f13e4e6b441.png)

# Mini-project - SQL: From Data to Insight | In vino veritas

<br>

## Introduction

Welcome to the "In vino veritas" data analysis mini project.
<br>
In this project, we share with you information about wine, one of the most popular alcoholic beverages in the world.
If you've ever wondered what countries make the best wines, or tried to find a balance between the price and quality of wines, 
this analysis will help you with that. 
<br>
The explicit motive behind this analysis is a client request.
<br>
The indirect motives:
1. to help people in their purchase decision,
2. to promote small producers,
3. promote tourism,
4. practice and demonstrate our SQL skills.
<br>

## Team members
- Alev Yildirim
- Gijs Verbree
- Milenko Rosić

## Installation & setup
- Fork this repo
- Clone it to your machine

### Required environment
- Jupyter Notebook
- Python 3.11.5 or higher
- Pandas
- Seaborn
- Matplotlib
- MySQLWorkbench

## About the dataset
The dataset used in this analysis is [Wine Rating & Price](https://www.kaggle.com/datasets/budnyak/wine-rating-and-price).
<br>
Data contains 4 .csv files for each winestyle:
1. red, 
2. white, 
3. rose, and 
4. sparkling.
<br>
Also there is a file with wine varieties for further analysis, which we did not use in this project.
<br>

### Data Description
The files have 8 columns with self-explanatory names:
1. name (of wine)
2. country (that the wine comes from)
3. region (in the country that the wine comes from)
4. winery (the company that produced the wine)
5. rating (on floating scale from 1 to 5)
6. no_ratings (number of eople who rated the wine)
7. price (of the wine)
8. year (the vintage).
<br>

## About the project
A wine importer wants to import wine for high-end Michellin restaurants and wants an analysis on price-rating ratio on all 4 four types of wine.

The countries of interest for the importer are : Italy, France, Spain and Portugal.
<br>
The business question the importer wanted to investigate included which countries and which regions from these countries have the best quality wine with highest ratings? 
<br>
Does user ratings have correlation with the wine prices? 
<br>
The second subject of interest for the importer is to investigate countries and regions for the best quality wine - with highest ratings and cheapest price. 
<br>
Their country of interest remained the same: Italy, France, Spain and Portugal.
<br>

### Business questions
- What is the correlation between rating and price per each country?
- Which country and winery region tend to have the highest ratings with highest prices?
- Which country has the highest ratings with cheaper prices among the countries of interest?  
- Which countries have the best ratings for each type of wine?

### Hypothesis
Wine ratings tend to increase with the price.
<br>
For this assumption, the analysis of the datasets included a research on correlation of price and ratings per the countries of interest.   
<br>

## Understanding the data

The original dataset was loaded into a Jupyter Notebook for analysis in Python.
<br>
We used Pandas built-in functions such as describe, head, info, unique, to familiarize ourselves with the data.
<br>
The original dataset consist of nearly 9000 different wines for the red type.
<br>

### Formatting
We used Pandas built-in functions to format the data, to reach clarity and needs of our analysis.
<br>

### EDA methods
We utilized Python libraries Seaborn and Matplotlib to explore and visually present present the statistical findings.
<br>

#### Statistical Analysis:
The analysis was initially done in SQL(MySQLWorkbench), then in Python(Jupyter Notebook).
<br>

#### Computation:
In SQL, we ran queries to learn:
- what countries and regions produce most wines and which wines,
- highest average ratings per country, region, wine type,
- lowest average prices,
- ratio between rating and price, and
- lowest average prices from the highest average rated countries.
<br>

#### Visualisation:
- Created visualizations such as plots (bar, pie, line, scatter) to illustrate the distributions.

### Under the hood
- Data structures used: lists, dictionaries, sets
- Flow control: if-else statements
- Functions: mostly Pandas built-in functions and methods
- 

## Conclusion
France is the highest rated country with highest prices for high-end buyers for especially red wine. 
<br>
Portugal is the highest rated country with more affordable wine selection for red, white, sparkling and rose wine.   
<br>
There are countries with high potential with affordable prices (the most optimum price-quality ratio, the quality being rated by the users).
<br>
Our null hypothesis was that an escalation in oceanic activities, such as surfing and swimming, will correlate with an increase in 🦈 attacks along coastal regions of the USA.
<br>
We fail to reject the null hypothesis.
<br>
There are indeed relatively expensive wines with ratings higher than average.
<br>
However, there are also relatively inexpensive wines with relatively higher ratings.

### Issues and challenges
The one challenge that consumed a considerable amount of time was inability to load the dataset into MySQLWorkbench.
<br>
The special characters in the names of wines were causing this problem.
<br>
The problem was resolved thanks to the Stack Overflow community advice, by re-encoding the .csv files to ASCII.
<br>

### Acknowledgements
- Anton Budnyak, the author of the dataset
- Don Nacho
- Simi
- Pedro (though we're still not sure if that's a real person or AI)

### P.S. : No wine bottle was consumed in creating this analysis.

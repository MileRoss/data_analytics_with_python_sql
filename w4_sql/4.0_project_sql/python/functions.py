import pandas as pd
import numpy as np

def check_null_inf(df):
    print("Null value counts:")
    print(df.isnull().sum())
    
    print("\nInfinite value counts:")
    for column in df.columns:
        if np.issubdtype(df[column].dtype, np.number):
            print(f"In '{column}' column:", np.isinf(df[column]).sum())


def avg_and_ratio(df, countries_of_interest):
    filtered_df = df[df['country'].isin(countries_of_interest)]
    avg_price_rating_per_region = filtered_df.groupby(['country', 'region']).agg({'price':'mean', 'rating':'mean'}).reset_index()
    avg_price_rating_per_region['rating/price_ratio'] = avg_price_rating_per_region['rating'] / avg_price_rating_per_region['price']
    avg_price_rating_per_region.rename(columns={'price':'avg_price', 'rating':'avg_rating', 'country':'country'}, inplace=True)
    
    return avg_price_rating_per_region


def top_regions_rating(df):
    grouped_region_rating_spark = df.groupby('country')
    top_regions_per_country_spark = []

    for country, group in grouped_region_rating_spark:
        sorted_group = group.sort_values(by='avg_rating', ascending=False)
        top_regions = sorted_group.head(5)
        top_regions_per_country_spark.append(top_regions)

    top_regions_df = pd.concat(top_regions_per_country_spark, ignore_index=True)
    return top_regions_df

def top_regions_ratio(df):
    grouped_region_ratio_spark = df.groupby('country')
    top_regions_ratio_country_spark = []

    for country, group in grouped_region_ratio_spark:
        sorted_group = group.sort_values(by='rating/price_ratio', ascending=False)
        top_regions = sorted_group.head(5)
        top_regions_ratio_country_spark.append(top_regions)

    top_regions_ratio_df = pd.concat(top_regions_ratio_country_spark, ignore_index=True)
    return top_regions_ratio_df

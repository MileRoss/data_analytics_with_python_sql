#!/usr/bin/env python
# coding: utf-8

# In[ ]:

import pandas as pd

def clean_and_format_data(df):

# Convert column names to lowercase and replace spaces with underscores
    df.columns = df.columns.str.lower().str.replace(' ', '_')

# Replace values in specified columns
    replace = {
        'gender': {'Femal': 'F', 'Male': 'M', 'female': 'F'},
        'state': {'AZ': 'Arizona', 'WA': 'Washington', 'Cali': 'California'},
        'education': {'Bachelors': 'Bachelor'},
        'vehicle_class': {'Sports Car': 'Luxury', 'Luxury SUV': 'Luxury', 'Luxury Car': 'Luxury'}
    }
    df = df.replace(replace)

# Convert 'customer_lifetime_value' to numeric, removing '%' and coercing errors
    df['customer_lifetime_value'] = pd.to_numeric(df['customer_lifetime_value'].str.replace('%', ''), errors='coerce')

# Extract the second part of 'number_of_open_complaints' and convert to int
    df['number_of_open_complaints'] = df['number_of_open_complaints'].apply(lambda x: int(x.split('/')[1].strip()) if isinstance(x, str) else x)

# Drop rows with any NaN values
    df = df.dropna()

# Convert selected columns to int
    numeric_columns = ['customer_lifetime_value', 'income', 'monthly_premium_auto', 'number_of_open_complaints', 'total_claim_amount']
    df[numeric_columns] = df[numeric_columns].astype(int)

# Check for duplicated rows
    duplicates_count = df.duplicated().sum()

    return df, duplicates_count


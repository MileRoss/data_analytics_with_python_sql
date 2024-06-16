import pandas as pd

def clean_and_format_data_function(df):
       
    shape_before_cleaning = df.shape
    duplicates_before_cleaning = df.duplicated().sum()

    df.columns = df.columns.str.lower().str.replace(' ', '_')
    df = df.rename(columns={'st': 'state'})
    print("\nCheck for renamed columns:", end='\n'); print(df.columns, end='\n\n')

    df = df.replace({
        'gender': {'Femal': 'F', 'Male': 'M', 'female': 'F'},
        'state': {'AZ': 'Arizona', 'WA': 'Washington', 'Cali': 'California'},
        'education': {'Bachelors': 'Bachelor'},
        'vehicle_class': {'Sports Car': 'Luxury', 'Luxury SUV': 'Luxury', 'Luxury Car': 'Luxury'}
    })
    print("Check for replaced values:"); display(df.head()); print("\n")

    df['customer_lifetime_value'] = df['customer_lifetime_value'].str.replace('%', '')
    df['customer_lifetime_value'] = pd.to_numeric(df['customer_lifetime_value'])
    print("check if % gone:"); display(df.head()); print("\n")
    print("check if c_l_v = numerical:"); display(df.dtypes); print("\n")

    df['number_of_open_complaints'] = df['number_of_open_complaints'].apply(lambda x: int(x.split('/')[1].strip()) if isinstance(x, str) else x)
    df['number_of_open_complaints'] = pd.to_numeric(df['number_of_open_complaints'])
    print("check if / gone:"); display(df.head()); print("\n")
    print("check if n_o_o_c numerical:"); display(df.dtypes); print("\n")

    print("the number of na before cleaning:\n", df.isna().sum(), "\n")
    df = df.dropna()
    print("the number of na after cleaning:\n", df.isna().sum(), "\n")

    numeric_columns = ['customer_lifetime_value', 'income', 'monthly_premium_auto', 'number_of_open_complaints', 'total_claim_amount']
    df[numeric_columns] = df[numeric_columns].astype(int)
    print("check if floats are int:\n"); display(df.dtypes); print("\n")

    print("cleaned df shape:", df.shape, "\n")

    print("The shape before cleaning and formatting:\n")
    shape_before_cleaning
    print("The shape after cleaning and formatting:\n")
    df.shape
    print("The sum of duplicate rows before cleaning and formatting:", duplicates_before_cleaning)
    print("The sum of duplicate rows after cleaning and formatting:", df.duplicated().sum())
    
    return df
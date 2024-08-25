import pandas as pd

# Step 1:
def cleaning_column_names(url):
    df = pd.read_csv(url)
    df.columns = df.columns.str.lower().str.replace(" ", "_")
    df.rename(columns={"st": "state"}, inplace=True)
    return df

# Step 2:
def cleaning_invalid_values(df):
    df["gender"] = df["gender"].astype(str).apply(lambda x: "M" if x[0].lower() == "m" else "F")
    df["state"] = df["state"].astype(str).replace({"az": "arizona", "wa": "washington"})
    df["education"] = df["education"].replace({"Bachelors": "Bachelor"})
    df["customer_lifetime_value"] = df["customer_lifetime_value"].str.replace("%", "")
    df["vehicle_class"] = df["vehicle_class"].apply(lambda x: "Luxury" if x in ["Sports Car", "Luxury SUV", "Luxury Car"] else x)
    return df

# Step 3:
def formatting_datatypes(df):
    df["customer_lifetime_value"] = pd.to_numeric(df["customer_lifetime_value"], errors="coerce")
    df['number_of_open_complaints'] = df['number_of_open_complaints'].str.split('/').str[1]
    df["number_of_open_complaints"] = pd.to_numeric(df['number_of_open_complaints'], errors="coerce")
    return df

# Step 4:
def manage_null_values(df):
    print("Sum of null values before cleaning:", df.isna().sum().sum())
    df.dropna(inplace=True)
    print("Sum of null values after cleaning:", df.isna().sum().sum())
    return df

# Step 5:
def manage_duplicated_values(df):
    print("Sum of duplicated values before dropping:", df.duplicated().sum())
    df.drop_duplicates(inplace=True)
    print("Sum of duplicated values after dropping:", df.duplicated().sum())
    return df

# Step 6:
def main_function(url):
    df = cleaning_column_names(url)
    df = cleaning_invalid_values(df)
    df = formatting_datatypes(df)
    df = manage_null_values(df)
    df = manage_duplicated_values(df)
    display(df.head())
    return df
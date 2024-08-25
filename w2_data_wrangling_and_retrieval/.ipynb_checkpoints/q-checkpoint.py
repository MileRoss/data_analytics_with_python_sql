import pandas as pd
import numpy as np

# Step 1, Cleaning column names:

def cleaning_column_names(url):
    df = pd.read_csv(url)
    df = df.rename(columns={ col: col.replace(" ","_").lower() for col in df.columns })
    df.rename(columns={"st": "state"}, inplace=True)
    return df
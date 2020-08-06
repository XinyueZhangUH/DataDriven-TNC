import pandas as pd
from os import listdir
import os


folderPath = 'data/ChengduNov2016/chengdu/'
files = listdir(folderPath)
files.sort()
newfolderPath = folderPath+'sample/'

if os.path.isdir(newfolderPath):
    print
else:
    try:
        os.makedirs(newfolderPath)
    except OSError:
        print("Creation of the directory failed")
    else:
        print("Successfully created the directory")

ts = 1477958400
index = 0
for file in files:
    ts1 = ts + index * 86400
    ts2 = ts1 + 3600
    filePath = folderPath + file
    df = pd.read_csv(filePath, header = None, usecols=[2,3,4], names=['timestamp','Longitude', 'Latitude'])
    df_time = df.loc[df['timestamp'].between(ts1, ts2)]
    sample_df = df_time.sample(n=1000)
    save_df = sample_df[['Longitude', 'Latitude']]
    newfilePath = newfolderPath + file
    save_df.to_csv(newfilePath,index=False)
    index = index + 1
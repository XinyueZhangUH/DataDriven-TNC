from scipy.special import lambertw
import numpy as np
import math
import matplotlib.pyplot as plt
import pandas as pd
from os import listdir
import os
from scipy.stats import gamma
from scipy.io import savemat


def geo(x, y, eps):
    # uniformly draw theta,p
    noise_theta = np.random.uniform(0, 2*np.pi)
    p = np.random.uniform(0,1)
    scale = eps*110
    w = lambertw((p-1)/np.exp(1), k=-1)
    noise_r = abs(-1/scale*(w+1))
    if noise_r >= 100/110:
        noise_r = 100/110
    # noise_r = gamma.rvs(2, loc=0, scale=0.005/eps)

    noise_x = noise_r * math.cos(noise_theta)
    noise_y = noise_r * math.sin(noise_theta)
    fake_x = abs(x + noise_x)
    fake_y = abs(y + noise_y)
    return fake_x, fake_y


def calculate_demand(folderPaths, eps):
    # lo_max_array = np.zeros(60)
    # lo_max = df.max()[0]
    demands1 = np.zeros(60)
    demands2 = np.zeros(60)
    demands1_fake = np.zeros(60)
    demands2_fake = np.zeros(60)
    index = 0
    for folderPath in folderPaths:
        files = listdir(folderPath)
        for file in files:
            filePath = folderPath + file
            df = pd.read_csv(filePath)
            fake_df = df.copy(deep=True)
            fake = df.apply(lambda row: geo(row['Longitude'], row['Latitude'], eps), axis=1)
            fake_df[['Longitude', 'Latitude']] = pd.DataFrame(fake.tolist(), index=df.index)

            def selected_demand(df, lo1, lo2, la1, la2):
                selected_df = df.loc[df['Longitude'].between(lo1,lo2) & df['Latitude'].between(la1,la2)]
                d = selected_df.shape[0]
                return d
            demand = selected_demand(df, 108.955, 108.97, 34.23, 34.245)
            demands1[index] = demand
            demand = selected_demand(fake_df, 108.955, 108.97, 34.23, 34.245)
            demands1_fake[index] = demand
            demand = selected_demand(df, 108.97, 108.985, 34.23, 34.245)
            demands2[index] = demand
            demand = selected_demand(fake_df, 108.97, 108.985, 34.23, 34.245)
            demands2_fake[index] = demand
            index = index + 1
    return demands1, demands2, demands1_fake, demands2_fake


def save_mat_file(demand, filename):
    mdic = {"demand": demand}
    savemat(filename, mdic)


if __name__ == "__main__":
    folderPaths = ['data/XianOct2016/xian/sample/','data/XianNov2016/xian/sample/']
    eps = 1
    demands1, demands2, demands1_fake, demands2_fake = calculate_demand(folderPaths, eps)
    save_mat_file(demands1, "data/Xian1.mat")
    save_mat_file(demands1_fake, "data/Xian1_eps1.mat")
    save_mat_file(demands2, "data/Xian2.mat")
    save_mat_file(demands2_fake, "data/Xian2_eps1.mat")




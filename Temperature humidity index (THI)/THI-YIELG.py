import pyreadr
from lmfit import Model, Parameters
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
from scipy import stats
from concurrent.futures import ProcessPoolExecutor
import matplotlib

matplotlib.use('agg')

# Load the RDS file
births = pyreadr.read_r('C:/Users/Evan/Desktop/thi-yieldall.rds')
births_df = pd.DataFrame(list(births.values())[0])

# Extract the THI and yield data
x = births_df['THI.y']
y = births_df['yield']

# Filter the yield data
mask = y < 85
x = x[mask]
y = y[mask]

# Stack the data for KDE calculation
xy = np.vstack([x, y])

# Define the KDE calculation function
def kde_calculation(data):
    return stats.gaussian_kde(data)(data)

# Calculate KDE using parallel processing
with ProcessPoolExecutor() as executor:
    z = executor.submit(kde_calculation, xy).result()

# Sort the data
idx = z.argsort()
x, y, z = x.iloc[idx], y.iloc[idx], z[idx]

# Create the plot
fig, ax = plt.subplots(figsize=(8, 6), dpi=300)
scatter = ax.scatter(x, y, marker='o', c=z * 100, edgecolors=None, s=0.03, alpha=1)
cbar = plt.colorbar(scatter, shrink=1, orientation='vertical', extend='both', pad=0.015, aspect=30, label='frequency')

plt.legend()
save_path = "C:/Users/Evan/Desktop/THI/THI.pdf"
save_path2 = "C:/Users/Evan/Desktop/THI/THI.png"
plt.savefig(save_path, format="pdf", bbox_inches="tight")
plt.savefig(save_path2, format="png", bbox_inches="tight")

plt.show()
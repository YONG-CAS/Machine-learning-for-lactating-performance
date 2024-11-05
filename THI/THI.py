import pyreadr
from lmfit import Model, Parameters
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
from scipy import stats



births = pyreadr.read_r('C:/Users/Evan/Desktop/THI/THI1.rds')
births_df = pd.DataFrame(list(births.values())[0])




x = births_df['days']
y = births_df['yield']


mask = y < 85
x = x[mask]
y = y[mask]


xy = np.vstack([x, y])
z = stats.gaussian_kde(xy)(xy)
idx = z.argsort()
x, y, z = x.iloc[idx], y.iloc[idx], z[idx]


def custom_curve(x, a, b, c):
    return a * (x**b) * np.exp(c * x)

model = Model(custom_curve)


params = Parameters()
params.add('a', value=14.81)
params.add('b', value=0.196)
params.add('c', value=-0.0048)


result = model.fit(y, x=x, params=params)


a_fit = result.params['a'].value
b_fit = result.params['b'].value
c_fit = result.params['c'].value


y_fit = result.best_fit


print(result.fit_report())


x_pred = np.linspace(1, 305, 100)
y_pred = custom_curve(x_pred, a_fit, b_fit, c_fit)


fig, ax = plt.subplots(figsize=(8, 6), dpi=300)
scatter = ax.scatter(x, y, marker='o', c=z * 100, edgecolors=None, s=0.05,alpha=1)
cbar = plt.colorbar(scatter, shrink=1, orientation='vertical', extend='both', pad=0.015, aspect=30, label='frequency')


plt.plot(x_pred, y_pred, 'r-', label='Fit', linewidth=2)



plt.legend()

plt.show()
import pyreadr
from lmfit import Model, Parameters
import numpy as np
import pandas as pd


import matplotlib
print(matplotlib.__version__)

matplotlib.use('agg')

births = pyreadr.read_r('C:/Users/Evan/Desktop/Parity1.rds')
births_df = pd.DataFrame(list(births.values())[0])



x =births_df['days']
y =births_df['yield']


mask = y < 85
x = x[mask]
y = y[mask]


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



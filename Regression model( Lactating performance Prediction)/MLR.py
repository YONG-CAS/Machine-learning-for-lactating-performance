import joblib
import matplotlib
matplotlib.use('agg')
import matplotlib.pyplot as plt
import pandas as pd
import numpy as np
from sklearn.linear_model import LinearRegression  # Import Linear Regression
from sklearn.metrics import r2_score, mean_squared_error
from sklearn.model_selection import train_test_split
import pyreadr

# Load data using a context manager
births = pyreadr.read_r('C:/Users/Evan/Desktop/rfr.rds')
births_df = pd.DataFrame(list(births.values())[0])


# Adjusting sample size
y = births_df['yield']
X =births_df[["uid", "parity","THI", "protein","NEl.Mcal","N.D.F","A.D.F","Fat", "Disease", "days"]]

X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.3, random_state=41)

# Use Linear Regression instead of RandomForestRegressor
mlr = LinearRegression(max_iter=1000)

mlr.fit(X_train, y_train)

# Predictions and metrics
train_score = mlr.score(X_train, y_train)
y_pred = mlr.predict(X_test)
r2 = r2_score(y_test, y_pred)
mse = mean_squared_error(y_test, y_pred)
rmse = np.sqrt(mean_squared_error(y_test, y_pred))

rsr = np.sqrt(1 - r2)

# Output the model performance metrics
print('Train Accuracy: {:.2f}'.format(train_score))
print('Prediction Accuracy: {:.2f}'.format(r2))
print('MSE: {:.2f}'.format(mse))
print('RMSE: {:.2f}'.format(rmse))
print('RSR: {:.2f}'.format(rsr))

# There is no feature importance in MLR, so we skip that part.

# Save the performance metrics plot
save_path = 'C:/Users/Evan/Desktop/'
plt.savefig(f'{save_path}performance_metrics.png', format='png', bbox_inches='tight')
plt.savefig(f'{save_path}performance_metrics.pdf', format='pdf', bbox_inches='tight')
# Close and clear memory
plt.close()
plt.clf()
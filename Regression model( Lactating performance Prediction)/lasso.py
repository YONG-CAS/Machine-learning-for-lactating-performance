import matplotlib
matplotlib.use('TkAgg')
import matplotlib.pyplot as plt
import pandas as pd
import numpy as np
from sklearn.model_selection import train_test_split, GridSearchCV
from sklearn.linear_model import Lasso
from sklearn.metrics import r2_score, mean_squared_error, mean_absolute_error
import pyreadr

# Load data using a context manager
births = pyreadr.read_r('C:/Users/Evan/Desktop/rfr.rds')
births_df = pd.DataFrame(list(births.values())[0])

# Adjusting sample size
y = births_df['yield']
X = births_df[["uid", "parity", "THI", "protein", "NEl.Mcal", "N.D.F", "A.D.F", "Fat", "Disease", "days"]]

X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.3, random_state=41)

# Define the model
lasso_model = Lasso()

# Define the parameter grid for alpha
param_grid = {'alpha': np.logspace(-4, 4, 20)}

# Set up the grid search
grid_search = GridSearchCV(lasso_model, param_grid, scoring='r2', cv=5, n_jobs=-1)

# Fit the model
grid_search.fit(X_train, y_train)

# Get the best model
best_lasso_model = grid_search.best_estimator_

# Model evaluation
train_score = best_lasso_model.score(X_train, y_train)
y_pred = best_lasso_model.predict(X_test)
r2 = r2_score(y_test, y_pred)
mse = mean_squared_error(y_test, y_pred)
rmse = np.sqrt(mean_squared_error(y_test, y_pred))
mae = mean_absolute_error(y_test, y_pred)
rsr = np.sqrt(1 - r2)

print('Best Alpha: {:.4f}'.format(grid_search.best_params_['alpha']))
print('Train Accuracy: {:.2f}'.format(train_score))
print('Prediction Accuracy: {:.2f}'.format(r2))
print('MSE: {:.2f}'.format(mse))
print('RMSE: {:.2f}'.format(rmse))
print('RSR: {:.2f}'.format(rsr))
print('MAE: {:.2f}'.format(mae))

save_path = 'C:/Users/Evan/Desktop/lasso/'

plt.figure()
plt.plot(np.arange(500), y_test[:500], "go-", label="True value", markersize=1, linewidth=0.1)
plt.plot(np.arange(500), y_pred[:500], "ro-", label="Predict value", markersize=1, linewidth=0.1)
plt.title("True value and Predicted value")
plt.legend()
plt.savefig(f'{save_path}1.pdf', format='pdf', bbox_inches='tight')
plt.close()
plt.clf()
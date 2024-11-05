import matplotlib
matplotlib.use('TkAgg')
import matplotlib.pyplot as plt
import pandas as pd
import numpy as np
from sklearn.model_selection import train_test_split, GridSearchCV
from sklearn.ensemble import GradientBoostingRegressor
from sklearn.metrics import r2_score, mean_squared_error, mean_absolute_error
import pyreadr

# Load data using a context manager
births = pyreadr.read_r('C:/Users/Evan/Desktop/rfr.rds')
births_df = pd.DataFrame(list(births.values())[0])

# Adjusting sample size
y = births_df['yield']
X = births_df[["uid", "parity", "THI", "protein", "NEl.Mcal", "N.D.F", "A.D.F", "Fat", "Disease", "days"]]

X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.3, random_state=41)

# Set up the parameter grid for grid search
param_grid = {
    'n_estimators': [100, 200, 300],
    'learning_rate': np.linspace(0.01, 0.2, 20),
    'max_depth': [3, 5, 7],
    'subsample': np.linspace(0.5, 1.0, 6),
    'alpha': [0.1, 0.5, 0.9]
}

# Use Gradient Boosting Regression with GridSearchCV
gb_model = GradientBoostingRegressor(random_state=42)
grid_search = GridSearchCV(estimator=gb_model, param_grid=param_grid, cv=5, scoring='r2', n_jobs=-1)
grid_search.fit(X_train, y_train)

# Best parameters and model
best_params = grid_search.best_params_
best_model = grid_search.best_estimator_

# Model evaluation
train_score = best_model.score(X_train, y_train)
y_pred = best_model.predict(X_test)
r2 = r2_score(y_test, y_pred)
mse = mean_squared_error(y_test, y_pred)
rmse = np.sqrt(mse)
mae = mean_absolute_error(y_test, y_pred)
rsr = np.sqrt(1 - r2)

print('Best Parameters:', best_params)
print('Train Accuracy: {:.2f}'.format(train_score))
print('Prediction Accuracy: {:.2f}'.format(r2))
print('MSE: {:.2f}'.format(mse))
print('RMSE: {:.2f}'.format(rmse))
print('RSR: {:.2f}'.format(rsr))
print('MAE: {:.2f}'.format(mae))

save_path = 'C:/Users/Evan/Desktop/GBR/'

plt.figure()
plt.plot(np.arange(500), y_test[:500], "go-", label="True value", markersize=1, linewidth=0.1)
plt.plot(np.arange(500), y_pred[:500], "ro-", label="Predict value", markersize=1, linewidth=0.1)
plt.title("True value And Predict value")
plt.legend()
plt.savefig(f'{save_path}1.pdf', format='pdf', bbox_inches='tight')
plt.close()
plt.clf()
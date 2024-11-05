import pandas as pd
import pyreadr
from sklearn.neighbors import KNeighborsClassifier
from sklearn.linear_model import LogisticRegression
from sklearn.tree import DecisionTreeClassifier
from sklearn.ensemble import RandomForestClassifier
from sklearn.naive_bayes import GaussianNB
from sklearn.neural_network import MLPClassifier
from sklearn.metrics import roc_curve, auc, accuracy_score, precision_score, recall_score
from imblearn.over_sampling import SMOTE
from sklearn.model_selection import train_test_split, GridSearchCV
from scipy.stats import chi2_contingency
import matplotlib.pyplot as plt
import numpy as np
from sklearn.neighbors import NearestNeighbors

# Load data
births = pyreadr.read_r('C:/Users/Evan/Desktop/predicted.rds')
births_df = pd.DataFrame(list(births.values())[0])

# Define features and target variable
X = births_df[['predicted_yield', 'yield']].apply(pd.to_numeric, errors='coerce')
y = births_df['state'].map({'health': 0, 'disease': 1})


# SMOTE function
def SMOTE(X, y, N, k=5):
    X_majority = X[y == 0]
    X_minority = X[y == 1]
    X_minority = np.array(X_minority)

    if X_minority.ndim == 1:
        X_minority = X_minority.reshape(-1, 1)

    N_per_sample = N // len(X_minority)
    k = min(k, len(X_minority) - 1)

    synthetic_samples = []
    synthetic_labels = []

    knn = NearestNeighbors(n_neighbors=k)
    knn.fit(X_minority)

    for minority_sample in X_minority:
        minority_sample = np.array(minority_sample)
        _, indices = knn.kneighbors(minority_sample.reshape(1, -1), n_neighbors=k)

        for _ in range(N_per_sample):
            neighbor_index = np.random.choice(indices[0])
            neighbor = X_minority[neighbor_index]
            difference = neighbor - minority_sample
            alpha = np.random.random()
            synthetic_sample = minority_sample + alpha * difference
            synthetic_samples.append(synthetic_sample)
            synthetic_labels.append(1)

    X_synthetic = np.array(synthetic_samples)
    y_synthetic = np.array(synthetic_labels)

    X_balanced = np.concatenate((X_majority, X_synthetic), axis=0)
    y_balanced = np.concatenate((np.zeros(len(X_majority)), y_synthetic), axis=0)

    return X_balanced, y_balanced


X_balanced, y_balanced = SMOTE(X, y, N=3000000)
X_train, X_test, y_train, y_test = train_test_split(X_balanced, y_balanced, test_size=0.3, random_state=42)

# Define parameter grids for each model
param_grids = {
    'KNeighborsClassifier': {
        'n_neighbors': [3, 5, 7, 9, 11],
        'weights': ['uniform', 'distance']
    },
    'LogisticRegression': {
        'C': [0.001, 0.01, 0.1, 1, 10, 100],
        'solver': ['liblinear', 'saga'],
        'penalty': ['l1', 'l2']
    },
    'DecisionTreeClassifier': {
        'max_depth': [None, 5, 10, 15, 20],
        'min_samples_split': [2, 5, 10],
        'min_samples_leaf': [1, 2, 5]
    },
    'RandomForestClassifier': {
        'n_estimators': [50, 100, 200],
        'max_depth': [None, 5, 10, 15],
        'min_samples_split': [2, 5, 10]
    },
    'MLPClassifier': {
        'hidden_layer_sizes': [(50,), (100,), (50, 50)],
        'activation': ['relu', 'tanh'],
        'solver': ['adam', 'sgd'],
        'alpha': [0.0001, 0.001, 0.01]
    }
}

# Initialize drawing
plt.figure()


# Function to evaluate the model with Grid Search
def evaluate_model_with_grid_search(model_name, param_grid, X_train, X_test, y_train, y_test):
    model = eval(model_name)()  # Create an instance of the model
    grid_search = GridSearchCV(model, param_grid, cv=5, scoring='roc_auc', n_jobs=-1)
    grid_search.fit(X_train, y_train)

    best_model = grid_search.best_estimator_
    y_pred = best_model.predict(X_test)
    y_scores = best_model.predict_proba(X_test)[:, 1]

    fpr, tpr, _ = roc_curve(y_test, y_scores)
    roc_auc = auc(fpr, tpr)

    accuracy = accuracy_score(y_test, y_pred)
    precision = precision_score(y_test, y_pred)
    recall = recall_score(y_test, y_pred)

    # Calculate sensitivity and specificity
    sensitivity = recall
    tn = np.sum((y_test == 0) & (y_pred == 0))
    fp = np.sum((y_test == 0) & (y_pred == 1))
    specificity = tn / (tn + fp) if (tn + fp) > 0 else 0
    fpr_value = fp / (fp + tn)  # Negative positive class rate

    print(
        f"{best_model.__class__.__name__} - Best Params: {grid_search.best_params_}, "
        f"Accuracy: {accuracy:.2f}, Precision: {precision:.2f}, "
        f"Recall rate: {sensitivity:.2f}, specificity: {specificity:.2f}, "
        f"negative and positive class rate: {fpr_value:.2f}"
    )

    return fpr, tpr, roc_auc


# Evaluate each model with grid search
for model_name, param_grid in param_grids.items():
    fpr, tpr, roc_auc = evaluate_model_with_grid_search(model_name, param_grid, X_train, X_test, y_train, y_test)
    plt.plot(fpr, tpr, label=f'{model_name} ROC curve (area = {roc_auc:.2f})')

# Draw the final graph of the ROC curve
plt.plot([0, 1], [0, 1], color='red', linestyle='--')
plt.xlim([0.0, 1.0])
plt.ylim([0.0, 1.05])
plt.xlabel('False Positive Rate')
plt.ylabel('True Positive Rate')
plt.title('Receiver Operating Characteristic')
plt.legend(loc='lower right')
plt.grid()
plt.show()
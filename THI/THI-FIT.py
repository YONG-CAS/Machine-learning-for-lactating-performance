import matplotlib.pyplot as plt
import numpy as np
def custom_curve(x, a, b, c):
    return a * (x**b) * np.exp(c * x)



x_pred = np.linspace(5, 305, 200)
y_pred1 = custom_curve(x_pred,  20.8012139 ,    0.23621235 ,  -0.00371672)
y_pred2 = custom_curve(x_pred, 19.3301798, 0.25872466, -0.00376679 )
y_pred3= custom_curve(x_pred,18.3908772 ,0.27606318 ,   -0.00368844)
y_pred4= custom_curve(x_pred,  19.3399925 ,   0.25752259 , -0.00348909 )
y_pred5= custom_curve(x_pred,  21.2176766 , 0.27294771, -0.00474314)
plt.plot(x_pred, y_pred1, 'purple', label='Fit1', linewidth=2)
plt.plot(x_pred, y_pred2, 'k-', label='Fit2', linewidth=2)
plt.plot(x_pred, y_pred3, 'r-', label='Fit3', linewidth=2)
plt.plot(x_pred, y_pred4, 'b-', label='Fit4', linewidth=2)


density_data =y_pred3
sorted_indices = np.argsort(density_data)[::-1]
top_40_percent = int(len(sorted_indices) * 0.4)
indices_of_interest = sorted_indices[:top_40_percent]
x_values_of_interest = x_pred[indices_of_interest]
plt.axvline(x=x_values_of_interest.min(), color='red', linestyle='--')
plt.axvline(x=x_values_of_interest.max(), color='red', linestyle='--')
x_range_of_interest = (x_values_of_interest.min(), x_values_of_interest.max())
print("X-axis range of the 40% highest density range:", x_range_of_interest)

plt.legend()

plt.show()
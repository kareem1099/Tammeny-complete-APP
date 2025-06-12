import pandas as pd
import numpy as np
import tensorflow as tf
from tensorflow.keras import layers, models
from sklearn.model_selection import train_test_split
from sklearn.preprocessing import StandardScaler
from sklearn.metrics import mean_absolute_error, r2_score
import json  

df = pd.read_csv("D:/final_user_based_dataset_scores_100_extended.csv")

feature_cols = [
    'ratio_Heart', 'ratio_Brain', 'ratio_Lung', 'ratio_Knee', 'ratio_Neutral',
    'available_Heart', 'available_Brain', 'available_Lung', 'available_Knee', 'available_Neutral'
]
target_cols = ['score_Heart', 'score_Brain', 'score_Lung', 'score_Knee', 'score_Neutral']

X = df[feature_cols].copy()
y = df[target_cols].copy()

X_train, X_val, y_train, y_val = train_test_split(X, y, test_size=0.25, random_state=42)

scaler = StandardScaler()
X_train_scaled = scaler.fit_transform(X_train)
X_val_scaled = scaler.transform(X_val)

scaler_data = {
    "mean": scaler.mean_.tolist(),
    "std": scaler.scale_.tolist()
}
with open("scaler_values_for_flutter.json", "w") as f:
    json.dump(scaler_data, f, indent=4)

model = models.Sequential([
    layers.Input(shape=(10,)),
    layers.Dense(64, activation='relu'),
    layers.Dense(64, activation='relu'),
    layers.Dense(5)
])

model.compile(optimizer='adam', loss='mae', metrics=['mae'])

model.fit(X_train_scaled, y_train, epochs=300, batch_size=32,
          validation_data=(X_val_scaled, y_val), verbose=1)

y_pred = model.predict(X_val_scaled)

print("MAE:", mean_absolute_error(y_val, y_pred))
print("R²:", r2_score(y_val, y_pred))

for i, col in enumerate(target_cols):
    mae = mean_absolute_error(y_val.iloc[:, i], y_pred[:, i])
    r2 = r2_score(y_val.iloc[:, i], y_pred[:, i])
    print(f"- {col}: MAE={mae:.2f}, R²={r2:.4f}")

model.save("disease_recommendation_model.h5")

converter = tf.lite.TFLiteConverter.from_keras_model(model)
tflite_model = converter.convert()

with open("disease_recommendation_model5.tflite", "wb") as f:
    f.write(tflite_model)


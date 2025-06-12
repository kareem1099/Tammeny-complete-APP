from fastapi import FastAPI, File, UploadFile, Form
from fastapi.responses import JSONResponse
import uvicorn
from PIL import Image
import numpy as np
import torch
from torchvision import models
from io import BytesIO
from tensorflow.keras.models import load_model
from tensorflow.keras.preprocessing import image
from transformers import AutoTokenizer, AutoModelForSequenceClassification, TFAutoModelForSeq2SeqLM
import joblib
import shutil
import cv2
import os

app = FastAPI()

# -------------------- Load XLM-R Text Classification Model --------------------
text_model_path = r"D:\xlmr_final_model"
text_tokenizer = AutoTokenizer.from_pretrained(text_model_path)
text_model = AutoModelForSequenceClassification.from_pretrained(text_model_path)
text_model.eval()
label_encoder = joblib.load(r"D:\label_encoder.joblib")

@app.post("/predict_Text")
async def predict_text(text: str = Form(...)):
    try:
        inputs = text_tokenizer(text, return_tensors="pt", truncation=True, padding=True, max_length=128)
        with torch.no_grad():
            outputs = text_model(**inputs)
            logits = outputs.logits
            predicted_class_id = torch.argmax(logits, dim=1).item()
            predicted_label = label_encoder.inverse_transform([predicted_class_id])[0]

        return predicted_label
    except Exception as e:
        return JSONResponse(str(e))

# -------------------- Lung Cancer Model --------------------
lung_model = load_model('D:\\Models\\Models\\Lung cancer detection\\model.h5.keras')
lung_class_names = ['Normal', 'Malignant', 'Benign']

def preprocess_lung_image(img):
    img = img.resize((128, 128))
    img = image.img_to_array(img)
    img = img / 255.0
    img = np.expand_dims(img, axis=0)
    return img

@app.post("/predict_Lung Cancer")
async def predict_lung(file: UploadFile = File(...)):
    try:
        contents = await file.read()
        img = Image.open(BytesIO(contents)).convert('RGB')
        processed_img = preprocess_lung_image(img)
        predictions = lung_model.predict(processed_img)
        predicted_index = np.argmax(predictions[0])
        predicted_class = lung_class_names[predicted_index]
        return {
            "result": predicted_class,
        }
    except Exception as e:
        return JSONResponse({"error": str(e)})

# -------------------- Knee Osteoarthritis Model --------------------
knee_model = models.resnet50(weights=None)
knee_model.fc = torch.nn.Linear(knee_model.fc.in_features, 2)
checkpoint = torch.load("D:\\best_knee_model_resnet5.pth", map_location=torch.device("cpu"))
knee_model.load_state_dict(checkpoint)
knee_model.eval()

def preprocess_knee_image(image: Image.Image):
    image = image.resize((224, 224))
    image_array = np.array(image) / 255.0
    if image_array.ndim == 2:
        image_array = np.stack([image_array] * 3, axis=-1)
    image_array = np.transpose(image_array, (2, 0, 1))
    mean = np.array([0.485, 0.456, 0.406])
    std = np.array([0.229, 0.224, 0.225])
    image_array = (image_array - mean[:, None, None]) / std[:, None, None]
    image_tensor = torch.tensor(image_array, dtype=torch.float32).unsqueeze(0)
    return image_tensor

@app.post("/predict_Knee Osteoarthritis (OA)")
async def predict_knee(file: UploadFile = File(...)):
    try:
        image_bytes = await file.read()
        image = Image.open(BytesIO(image_bytes)).convert("RGB")
        processed_image = preprocess_knee_image(image)
        with torch.no_grad():
            prediction = knee_model(processed_image)
        predicted_class = torch.argmax(prediction, dim=1).item()
        result = "Healthy knee" if predicted_class == 0 else "There is knee Osteoarthritis"
        return {
            "result": result,
        }
    except Exception as e:
        return JSONResponse({"error": str(e)})

# -------------------- Heart Segmentation Model --------------------
heart_model = load_model("D:\\BIG DATA\\Models\\CT-Heart-segmentation-using-U-NET\\CT-Heart\\unet_finetuned.h5")

def preprocess_heart_image(image_bytes):
    image = Image.open(BytesIO(image_bytes)).convert("RGB")
    image = image.resize((256, 256))
    image = np.array(image) / 255.0
    image = np.expand_dims(image, axis=0)
    return image

@app.post("/predict_Heart Disease Analysis")
async def predict_heart(file: UploadFile = File(...)):
    try:
        image_bytes = await file.read()
        processed_image = preprocess_heart_image(image_bytes)
        prediction = heart_model.predict(processed_image)[0, :, :, 0]
        threshold = 0.5
        mask = (prediction > threshold).astype(np.uint8)
        has_heart_issue = bool(np.sum(mask) > 0)
        result = "Heart issue detected" if has_heart_issue else "Normal appearance"
        return {
            "result": result,
        }
    except Exception as e:
        return JSONResponse({"error": str(e)})

# -------------------- Brain Tumor Classification Model --------------------
brain_model = load_model("C:/Users/Kareem/Desktop/TammenyMainApi/models/model_image_(Brain).h5")
brain_classes = ['brain_menin', 'brain_glioma', 'brain_pituitary', 'no_tumor']

def preprocess_brain_image(file_path: str):
    img = cv2.imread(file_path)
    img = cv2.resize(img, (128, 128))
    img = img / 255.0
    img = np.expand_dims(img, axis=0)
    return img

@app.post("/predict_Brain Cancer")
async def predict_brain(file: UploadFile = File(...)):
    try:
        temp_path = "temp_brain.jpg"
        with open(temp_path, "wb") as buffer:
            shutil.copyfileobj(file.file, buffer)

        processed_img = preprocess_brain_image(temp_path)
        predictions = brain_model.predict(processed_img)
        predicted_index = np.argmax(predictions[0])
        predicted_class = brain_classes[predicted_index]

        os.remove(temp_path)

        return {
            "result": predicted_class,
        }
    except Exception as e:
        return JSONResponse({"error": str(e)})

# -------------------- Chatbot Medical Assistant --------------------
chatbot_model_path = r"D:/bestmodelchat/bestmodelchat/Flan_T5"
chatbot_tokenizer = AutoTokenizer.from_pretrained(chatbot_model_path)
chatbot_model = TFAutoModelForSeq2SeqLM.from_pretrained(chatbot_model_path)

@app.post("/chatbot")
async def chatbot(text: str = Form(...)):
    try:
        if not text.strip():
            return {"response": "Please enter a valid medical question or symptom."}

        prompt = f"You are a helpful medical assistant. Analyze the user's input and provide an accurate, medically relevant response:\n\n{text}"
        inputs = chatbot_tokenizer(prompt, return_tensors="tf", padding=True, truncation=True, max_length=512)
        output_ids = chatbot_model.generate(**inputs, max_length=128, num_beams=4, early_stopping=True)
        response = chatbot_tokenizer.decode(output_ids[0], skip_special_tokens=True)
        return {"response": response}
    except Exception as e:
        return JSONResponse({"error": str(e)})

# -------------------- Run Server --------------------
if __name__ == "__main__":
    uvicorn.run(app, host="0.0.0.0", port=8000)

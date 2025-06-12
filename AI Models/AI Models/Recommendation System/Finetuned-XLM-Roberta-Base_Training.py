from transformers import AutoTokenizer, AutoModelForSequenceClassification, Trainer, TrainingArguments, EarlyStoppingCallback, AutoConfig
from datasets import Dataset
from sklearn.model_selection import train_test_split
from sklearn.preprocessing import LabelEncoder
from sklearn.metrics import accuracy_score, f1_score
import pandas as pd
import numpy as np
import torch
import os
import joblib
import random

seed = 42
random.seed(seed)
np.random.seed(seed)
torch.manual_seed(seed)
if torch.cuda.is_available():
    torch.cuda.manual_seed_all(seed)

df = pd.read_excel(r"C:/Users/Kareem/Desktop/postsclassifier/TOP_ELPOP.xlsx", names=["Source", "Post", "Tag"], skiprows=1)
df = df[df['Source'] != 'Tag'].dropna()

label_encoder = LabelEncoder()
df['label'] = label_encoder.fit_transform(df['Tag'])
joblib.dump(label_encoder, r"D:\label_encoder.joblib")

train_texts, test_texts, train_labels, test_labels = train_test_split(df['Post'], df['label'], test_size=0.1, stratify=df['label'], random_state=seed)
train_texts, val_texts, train_labels, val_labels = train_test_split(train_texts, train_labels, test_size=0.1, stratify=train_labels, random_state=seed)

model_name = "xlm-roberta-base"
tokenizer = AutoTokenizer.from_pretrained(model_name)

config = AutoConfig.from_pretrained(model_name)
config.num_labels = len(label_encoder.classes_)  
config.hidden_dropout_prob = 0.3
config.attention_probs_dropout_prob = 0.3

model = AutoModelForSequenceClassification.from_pretrained(model_name, config=config)

for name, param in model.named_parameters():
    if not (("layer.10" in name) or ("layer.11" in name) or ("classifier" in name)):
        param.requires_grad = False

def tokenize_function(examples):
    return tokenizer(examples["text"], truncation=True, padding="max_length", max_length=128)

train_dataset = Dataset.from_dict({"text": train_texts.tolist(), "label": train_labels.tolist()}).map(tokenize_function, batched=True)
val_dataset = Dataset.from_dict({"text": val_texts.tolist(), "label": val_labels.tolist()}).map(tokenize_function, batched=True)
test_dataset = Dataset.from_dict({"text": test_texts.tolist(), "label": test_labels.tolist()}).map(tokenize_function, batched=True)

train_dataset = train_dataset.remove_columns(["text"])
val_dataset = val_dataset.remove_columns(["text"])
test_dataset = test_dataset.remove_columns(["text"])

def compute_metrics(eval_pred):
    logits, labels = eval_pred
    preds = np.argmax(logits, axis=-1)
    return {
        "accuracy": accuracy_score(labels, preds),
        "f1": f1_score(labels, preds, average="weighted"),
    }

training_args = TrainingArguments(
    output_dir=r"D:\xlmr_final_modelhhh\xlmr_logs",
    eval_strategy="epoch",
    save_strategy="epoch",
    learning_rate=5e-5,             
    per_device_train_batch_size=8, 
    per_device_eval_batch_size=16,
    num_train_epochs=15,            
    weight_decay=0.1,
    warmup_ratio=0.1,
    lr_scheduler_type="cosine",
    load_best_model_at_end=True,
    metric_for_best_model="f1",
    logging_dir=r"D:\xlmr_final_modelhhh\xlmr_logs\logs",
    logging_strategy="steps",
    logging_steps=10,
    save_total_limit=2,
    fp16=torch.cuda.is_available(),
    max_grad_norm=1.0,
    report_to=[]
)

trainer = Trainer(
    model=model,
    args=training_args,
    train_dataset=train_dataset,
    eval_dataset=val_dataset,
    tokenizer=tokenizer,
    compute_metrics=compute_metrics,
    callbacks=[EarlyStoppingCallback(early_stopping_patience=2)]
)


trainer.train()

model_path = r"D:\xlmr_final_model"
os.makedirs(model_path, exist_ok=True)
model.save_pretrained(model_path)
tokenizer.save_pretrained(model_path)

print("Final evaluation on test set:")
results = trainer.evaluate(test_dataset)
print(results)

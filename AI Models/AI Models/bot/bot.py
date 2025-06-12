
import tensorflow as tf
from transformers import TFAutoModelForSeq2SeqLM, AutoTokenizer

# Set your model path or model name from HuggingFace
MODEL_NAME =r"C:\Users\CS\Downloads\bestmodelchat\Flan_T5"
MAX_INPUT_LENGTH = 512
MAX_TARGET_LENGTH = 128

# Load model and tokenizer
print("Loading model and tokenizer...")
tokenizer = AutoTokenizer.from_pretrained(MODEL_NAME)
model = TFAutoModelForSeq2SeqLM.from_pretrained(MODEL_NAME)

# Simple chatbot function
def try_bot(model, tokenizer):
    print("🤖 Medical Chatbot - Type 'quit' to exit")
    
    while True:
        user_input = input("Enter your symptoms or question:  ").strip()
        
        if user_input.lower() in ['quit', 'exit']:
            print("Please consult a doctor for a professional diagnosis.")
            print("Goodbye!")
            break

        if not user_input:
            print("Please enter a valid input.")
            continue

        # Construct prompt
        prompt = f"You are a helpful medical assistant. Analyze the user's input and provide an accurate, medically relevant response:\n\n{user_input}"
        
        # Tokenize and encode
        inputs = tokenizer(prompt, return_tensors="tf", padding=True, max_length=MAX_INPUT_LENGTH, truncation=True)
        
        # Generate response
        output_ids = model.generate(
            **inputs,
            max_length=MAX_TARGET_LENGTH,
            num_beams=4,
            early_stopping=True
        )
        
        response = tokenizer.decode(output_ids[0], skip_special_tokens=True)
        print(f"🤖 {response}")

# Run chatbot
if __name__ == "__main__":
    try_bot(model, tokenizer)


from transformers import AutoModelForCausalLM, AutoTokenizer

# Load model and tokenizer
model_name = "TinyLlama/TinyLlama-1.1B-Chat-v1.0"
tokenizer = AutoTokenizer.from_pretrained(model_name)
model = AutoModelForCausalLM.from_pretrained(model_name, device_map="cpu")

print("Model loaded successfully on CPU!")

# Run inference test
prompt = "Write a professional resume summary for a software developer."
inputs = tokenizer(prompt, return_tensors="pt")

# Generate text
output = model.generate(**inputs, max_length=100)  # Increase max_length if needed
response = tokenizer.decode(output[0], skip_special_tokens=True)

print("\nGenerated Output:")
print(response)

import sentencepiece as spm

# Load the trained tokenizer
sp = spm.SentencePieceProcessor(model_file="resume_tokenizer.model")

# Read input text from resume_data.txt
with open("resume_data.txt", "r", encoding="utf-8") as file:
    sample_text = file.read().strip()

# Tokenize the text
tokens = sp.encode(sample_text, out_type=str)

# Convert tokenized output back to readable format
structured_output = " ".join(tokens).replace("▁", " ")  # Replace subword markers with spaces

# Print results
print("\n📌 Original Text:\n", sample_text)
print("\n🔹 Tokenized Output:\n", tokens)
print("\n📄 Reconstructed Text:\n", structured_output)

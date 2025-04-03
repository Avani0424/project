import json
import sentencepiece as spm

# Load the trained tokenizer
sp = spm.SentencePieceProcessor(model_file="resume_tokenizer.model")

# Load resume dataset
with open("resume_dataset.json", "r", encoding="utf-8") as f:
    data = json.load(f)

# Tokenize each resume entry
for entry in data:
    text = " ".join(
    " ".join(item) if isinstance(item, list) else str(item) for item in entry.values()
)

    tokens = sp.encode(text, out_type=str)
    entry["tokens"] = tokens

# Save the tokenized data
with open("tokenized_dataset.json", "w", encoding="utf-8") as f:
    json.dump(data, f, indent=4)

print("Data preprocessing complete! Tokenized dataset saved as 'tokenized_dataset.json'")

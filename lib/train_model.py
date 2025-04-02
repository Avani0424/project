import torch
from transformers import Trainer, TrainingArguments, AutoModelForSequenceClassification
from datasets import load_dataset

# Load the tokenized dataset
dataset = load_dataset("json", data_files="tokenized_dataset.json")

# Load a pre-trained model (you can change this)
model = AutoModelForSequenceClassification.from_pretrained("bert-base-uncased", num_labels=2)

# Define training arguments
training_args = TrainingArguments(
    output_dir="./results",
    num_train_epochs=3,
    per_device_train_batch_size=4,
    per_device_eval_batch_size=4,
    warmup_steps=500,
    weight_decay=0.01,
    logging_dir="./logs",
)

trainer = Trainer(
    model=model,
    args=training_args,
    train_dataset=dataset["train"],
    eval_dataset=dataset["train"],  # Using train as eval (for now)
)

# Train the model
trainer.train()

# Save the trained model
model.save_pretrained("./resume_model")
print("Model training complete! Saved as 'resume_model'.")

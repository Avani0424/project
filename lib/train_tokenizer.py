import sentencepiece as spm

# Train the tokenizer
spm.SentencePieceTrainer.train(
    input="resume_data.txt",  # Input file
    model_prefix="resume_tokenizer",  # Prefix for output model files
    vocab_size=500,  # Adjust vocabulary size as needed
    model_type="bpe",  # Choose from 'unigram', 'bpe', 'char', 'word'
    max_sentence_length=2048,  # Max sentence length to train on
    pad_id=0, pad_piece="<pad>",  # Padding token
    unk_id=1, unk_piece="<unk>",  # Unknown token
    bos_id=2, bos_piece="<s>",  # Beginning of sentence token
    eos_id=3, eos_piece="</s>"  # End of sentence token
)

print("Tokenizer training complete!")

from llama_index.core import (
    StorageContext,
    load_index_from_storage,
)

PERSIST_DIR = "./storage"
# load the existing index
storage_context = StorageContext.from_defaults(persist_dir=PERSIST_DIR)
index = load_index_from_storage(storage_context)

# Get input from the user
user_input = input("Please enter your question: ")
user_input = f"Write a SQL query to do this: {user_input}"
# Print the input back to the user
print("You question:", user_input)

# ask OPEN AI API
query_engine = index.as_query_engine()
response = query_engine.query(user_input)

print(f"Response: {response}")


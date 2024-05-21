from llama_index.core import (
    StorageContext,
    load_index_from_storage,
)

def get_index():
    PERSIST_DIR = "./storage"
    storage_context = StorageContext.from_defaults(persist_dir=PERSIST_DIR)
    return load_index_from_storage(storage_context)

def get_response(index, user_input):
    query_engine = index.as_query_engine()
    return query_engine.query(user_input)

if __name__ == '__main__':
    user_input = input("Please enter your question: ")
    user_input = f"Write a SQL query to do this: {user_input}"
    print("You question:", user_input)
    print(f"Response is {get_response(get_index(), user_input)}")

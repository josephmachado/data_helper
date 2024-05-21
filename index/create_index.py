from llama_index.core import VectorStoreIndex, SimpleDirectoryReader

def index_data():
    documents = SimpleDirectoryReader("data").load_data()
    index = VectorStoreIndex.from_documents(documents)
    index.storage_context.persist()

if __name__ == '__main__':
    index_data()
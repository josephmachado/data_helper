from llama_index.core import (SimpleDirectoryReader, StorageContext,
                              VectorStoreIndex, load_index_from_storage)


def create_index(data_folder: str = "data"):
    """
    Function to read the input from the ./data folder
    and create vector indexes from it
    """
    documents = SimpleDirectoryReader(data_folder).load_data()
    index = VectorStoreIndex.from_documents(documents)
    index.storage_context.persist()


def get_index(persist_dir: str = "./storage"):
    """
    Function to read the index stored at the ./storage folder location
    """
    storage_context = StorageContext.from_defaults(persist_dir=persist_dir)
    return load_index_from_storage(storage_context)

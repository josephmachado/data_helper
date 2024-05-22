from llama_index.core import get_response_synthesizer
from llama_index.core.postprocessor import SimilarityPostprocessor
from llama_index.core.response_synthesizers import ResponseMode


def get_response(index, query_str):
    """
    Function to get response given a user input.
    This function uses sensible defaults
    """
    query_engine = index.as_query_engine()
    return query_engine.query(query_str)


def retrieve_nodes(index, query_str):
    """
    Function to retrieve nodes that are similar to the query_str
    Note that the query_str has to be converted to its corresponding
    embedding with the LLM API (Open AI API in our case)
    """
    retriever = index.as_retriever()
    return retriever.retrieve(query_str)


def post_process_nodes(nodes):
    """
    Function to process the nodes we get from the retriever
    We can use one of the postprocessors here (or write our own)
    https://docs.llamaindex.ai/en/stable/module_guides/querying/node_postprocessors/node_postprocessors/#node-postprocessor-modules
    """
    processor = SimilarityPostprocessor(similarity_cutoff=0.70)
    filtered_nodes = processor.postprocess_nodes(nodes)
    return filtered_nodes


def get_response_from_synthesizer(response_mode, filtered_nodes, query_str):
    """
    Function to get response using custom response synthesizer
    """
    response_synthesizer = get_response_synthesizer(
        response_mode=response_mode
    )
    response = response_synthesizer.synthesize(query_str, filtered_nodes)
    return response


def print_response(index, query_str, use_custom_pipeline):
    if use_custom_pipeline:
        filtered_nodes = post_process_nodes(retrieve_nodes(index, query_str))
        print(
            get_response_from_synthesizer(
                ResponseMode.COMPACT_ACCUMULATE, filtered_nodes, query_str
            )
        )
    else:
        print(get_response(index, query_str))

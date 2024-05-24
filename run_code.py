import argparse
from enum import Enum

from index.index_manager import create_index, get_index
from query.query_manager import print_response


class OperationType(Enum):
    INDEX = "index"
    INDEX_AND_QUERY = "index_and_query"
    QUERY = "query"


def run_pipeline():
    parser = argparse.ArgumentParser(
        description="Run indexing and querying with Llama Index."
    )
    parser.add_argument(
        "operation",
        type=str,
        choices=[e.name for e in OperationType],
        help="Operation to perform: INDEX, INDEX_AND_QUERY, QUERY",
    )
    parser.add_argument(
        "--query-type",
        type=str,
        choices=["custom", "generic"],
        default="generic",
        help="Type of query pipeline to use: custom or generic",
    )
    parser.add_argument("--query", type=str, help="Query string for querying", default="")

    args = parser.parse_args()
    operation = OperationType[args.operation.upper()]
    use_custom_pipeline = args.query_type.lower() == "custom"

    query_str = f"Create a SQL query (DuckDB) that {args.query}"
    if operation == OperationType.INDEX:
        create_index()
    elif operation == OperationType.QUERY:
        index = get_index()
        print_response(index, query_str, use_custom_pipeline)
    elif operation == OperationType.INDEX_AND_QUERY:
        create_index()
        index = get_index()
        print_response(index, query_str, use_custom_pipeline)


if __name__ == "__main__":
    run_pipeline()

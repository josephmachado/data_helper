Code for blog at: [Democratize Data Access with RAGS](https://www.startdataengineering.com/post/data-democratize-llm/)

## Set up

We will use [LlamaIndex](https://docs.llamaindex.ai/en/stable/) to build our RAG pipeline. The concepts used to RAG pipelines in general.

**GitHub Repo**: [Data Helper](https://github.com/josephmachado/data_helper/tree/main)

### Pre-requisite

1. [Python 3.10+](https://www.python.org/downloads/)
2. [git](https://git-scm.com/)
3. [Open AI API Key](https://platform.openai.com/api-keys)
4. [Poetry](https://python-poetry.org/docs/#installing-with-the-official-installer)

### Demo

We will clone the repo setup poetry shell as shown below:

```bash
git clone https://github.com/josephmachado/data_helper.git
cd data_helper
poetry install
poetry shell # activate the virtual env

# To run the code, please set your OPEN AI API key as shown below
export OPENAI_API_KEY=your-key-here
python run_code.py INDEX # Create an index with data from ./data folder
python run_code.py QUERY --query "show me for each buyers what date they made their first purchase"
# The above command uses the already existing index to make a request to LLM API to get results
# The code will return a SQL query with DuckDB format

python run_code.py QUERY --query "for every seller, show me a monthly report of the number of unique products that they sold, avg cost per product, max/min value of product purchased that month"
# The code will return a SQL query with DuckDB format
```

## Next Steps

1. Evaluate results and tune the pipeline
2. Add observation system
3. Monitor API costs
4. Add additional documentation as input
5. Explore other use cases such as RAGs for onboarding, DE training tool, etc

## Further reading

1. [Production RAG tips](https://www.youtube.com/watch?v=Zj5RCweUHIk)
2. [Advanced RAG tuning](https://docs.llamaindex.ai/en/stable/optimizing/production_rag/)
3. [What is a datawarehouse](https://www.startdataengineering.com/post/what-is-a-data-warehouse/)
4. [Conceptual data model](https://www.startdataengineering.com/post/n-steps-avoid-messy-dw/#21-understand-the-business)

## References

1. [LlamaIndex docs](https://docs.llamaindex.ai/en/stable/)

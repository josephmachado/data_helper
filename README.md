Code for blog at: WIP

## Setup

### Prerequisite

1. [Python 3.10+](https://www.python.org/downloads/)
2. [git](https://git-scm.com/)
3. [Open AI API Key](https://platform.openai.com/api-keys)
4. [Poetry](https://python-poetry.org/docs/#installing-with-the-official-installer)

We will run our code in a python virtual environment as shown below:

```bash
poetry install
poetry shell # activate the virtual env
```

## Run code

To run the code, please set your OPEN AI API key as shown below

```bash
export OPENAI_API_KEY=your-key-here
python run_code.py INDEX # Create an index with data from ./data folder
python run_code.py QUERY "show me for each buyers what date they made their first purchase"
# The above command uses the already existing index to make a request to LLM API to get results

python run_code.py QUERY "for every seller, show me a monthly report of the number of unique products that they sold, avg cost per product, max/min value of product purchased that month"
```

## Next steps

1. Experiment with splitting document into individual DDL nodes
2. Add metadata with table and metric aliases
3. Use Vector store with persistence
4. Expand to add business domain knowledge, data generation process, metric definitions.

TL;DR: Ways to get more relevant and specific information to the LLM API
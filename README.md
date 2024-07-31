# E-commerce Data Analysis Project

## Overview
This project involves analyzing e-commerce data to gain insights into monthly sales, product sales, average order value, reviews, on time rates , and sellers. The datasets were provided by Olist and have been anonymized. The project includes data cleaning, transformation, exploratory data analysis (EDA), and visualization using SQL, Python, Tableau, and Looker.

## Table of Contents
1. [Overview](#overview)
2. [Datasets](#datasets)
3. [Setup](#setup)
4. [Workflow](#workflow)
5. [Usage](#usage)
6. [Documentation](#documentation)
7. [Contact](#contact)

## Datasets
The following datasets were used in this project:
- `olist_order_items_dataset.csv`
- `olist_order_reviews_dataset.csv`
- `olist_orders_dataset.csv`
- `olist_products_dataset.csv`
- `olist_sellers_dataset.csv`
- `olist_customers_dataset.csv`

## Setup
### Prerequisites
- Python 3.x
- MySQL
- Looker Studio
- Tableau Desktop
- Python Modules: `pandas`, `numpy`, `os`, `dotenv`, `mysql-connector`, `seaborn`, `matplotlib.pyplot`

### Installation
1. Clone the repository:
    ```bash
    git clone https://github.com/joelam21/Olist_Business_Analysis.git
    cd Olist_Business_Analysis
    ```

2. Create and activate a virtual environment:
    ```bash
    python3 -m venv .venv
    source .venv/bin/activate
    ```

3. Install the required Python packages:
    ```bash
    pip install -r requirements.txt
    ```

4. Set up the MySQL database and import the CSV files into the database using the following Jupyter Notebooks.
- `load_categories.ipynb`
- `load_category_translation.ipynb`
- `load_order_items_data.ipynb`
- `load_order_reviews_data.ipynb`
- `load_products_data.ipynb`
- `load_sellers_data.ipynb`

## Workflow
1. **Data Gathering:**
    - Collected CSV files containing order items, reviews, orders, products, sellers, and customers data.
    - Created categories.csv file to categorize the subcategories provided by Olist into broader categories

2. **Data Loading:**
    - Loaded the datasets into a MySQL database using Python.
    - Created Jupyter notebooks to cleanse the data and load it into SQL.

3. **Data Transformation:**
    - Created a broader category table from the existing subcategories.
    - Joined the data in SQL and created two final datasets:
        - `order_items_products.csv`
        - `order_sales_review_cats.csv`

4. **Exploratory Data Analysis (EDA):**
    - Performed EDA in Python on the final datasets to uncover insights.

5. **Visualization:**
    - Used the final datasets to produce stories in both Tableau and Looker. (Note: Creating stories in both Tableau and Looker is optional, intended to demonstrate familiarity with both tools.)
    - Created PDF reports of these stories and saved them in the Documentation folder.

## Usage
### Running the Analysis
1. Load the datasets into the MySQL database using the provided Jupyter notebooks.
2. Perform data cleaning and transformation using SQL and Python.
3. Conduct EDA using Jupyter Notebook.
4. Generate visualizations and reports in Tableau and Looker.

## Documentation
- The final PDF reports generated from Tableau and Looker are available in the `Documentation` folder.
- [Tableau PDF Version of Report](Documentation/Olist_Report_Tableau.pdf)
- [Looker PDF Version of Report](Documentation/Olist_Report_Looker.pdf)
- [Tableau Web Version of Report](https://public.tableau.com/app/profile/joe.lam1433/viz/olist_report_tableau/OlistBusinessAnalysis)
- [Looker Web Version of Report](https://lookerstudio.google.com/reporting/58be1018-9d17-46b0-8762-5b88be02163f/page/p_lf4qzlm8id/edit)
## Contact
For any questions or feedback, please contact:
- Email: joelam21@gmail.com
- GitHub: (https://github.com/joelam21)
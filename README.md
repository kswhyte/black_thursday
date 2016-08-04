# Black Thursday
*Kinan Whyte and Calaway*
***
## Description
**Black Thursday** consists of a Data Access Layer containing databases loaded from CSV files, an Integration Layer creating dynamic relationships between the data sets, and a Business Intelligence Layer analyzing different aspects of the data and sales analytics.
***

## Installation
Certain Ruby Gems are required in order to run this application. To install them, run the following command from the terminal in the project root working directory:
```
bundle
```
***

## Usage
Black Thursday has been created to handle the following data types:
* Merchants
* Items
* Customers
* Invoices
* Invoice Items
* Transactions
* Customers

The databases can be loaded via CSV input. Examples of acceptable CSV file formats are included in the data directory. CSV files can be loaded into the Sales Engine with the terminal instruction:

```ruby
sales_engine = SalesEngine.from_csv({
  :items         => "path_to_items.csv",
  :merchants     => "path_to_merchants.csv",
  :invoices      => "path_to_invoices.csv",
  :invoice_items => "path_to_invoice_items.csv",
  :transactions  => "path_to_transactions.csv",
  :customers     => "path_to_customers.csv"
})
```

To utilize the Business Intelligence layer the Sales Analyst must me initialized. It takes a Sales Engine as an argument and can be created with the command:

```ruby
sales_analyst = SalesAnalyst.new(sales_engine)
```
***
## Functions

Below is a list of functions that are available to run within Black Thursday after the data has been loaded in from the CSV files.

#### Merchant:
* id
* name
* items
* invoices
* customers

#### Merchant Repository:
* all
* find_by_id
* find_by_name
* find_all_by_name

#### Item:
* id
* name
* description
* unit_price
* created_at
* updated_at
* merchant_id
* merchant

#### Item Repository:
* all
* find_by_id
* find_by_name
* find_all_with_description
* find_all_by_price
* find_all_by_price_in_range
* find_all_by_merchant_id

#### Invoice:
* id
* customer_id
* merchant_id
* status
* created_at
* updated_at
* item
* transaction
* customer
* is_paid_in_full?
* total

#### Invoice Repository:
* all
* find_by_id
* find_all_by_customer_id
* find_all_by_merchant_id
* find_all_by_status

#### Invoice Item:
* id
* item_id
* invoice_id
* quantity
* unit_price
* created_at
* updated_at

#### Invoice Item Repository:
* all
* find_by_id
* find_all_by_item_id
* find_all_by_invoice_id

#### Transaction:
* id
* invoice_id
* credit_card_number
* credit_card_expiration_date
* result
* created_at
* updated_at
* invoice

#### Transaction Repository:
* all
* find_by_id
* find_all_by_invoice_id
* find_all_by_credit_card_number
* find_all_by_result

#### Customer:
* id
* first_name
* last_name
* created_at
* updated_at
* customers

#### Customer Repository:
* all
* find_by_id
* find_all_by_first_name
* find_all_by_last_name

#### Sales Analyst
* average_items_per_merchant
* average_items_per_merchant_standard_deviation
* merchants_with_high_item_count
* average_item_price_for_merchant
* average_average_price_per_merchant
* golden_items
* average_invoices_per_merchant
* average_invoices_per_merchant_standard_deviation
* top_merchants_by_invoice_count
* bottom_merchants_by_invoice_count
* top_days_by_invoice_count
* invoice_status
* total_revenue_by_date
* revenue_by_merchant
* merchants_ranked_by_revenue
* top_revenue_earners
* merchants_with_pending_invoices
* find_items_by_merchant
* merchants_with_only_one_item
* merchants_with_only_one_item_registered_in_month
* most_sold_item_for_merchant
* best_item_for_merchant

***
## Authors
Calaway & Kinan Whyte

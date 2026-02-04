(1)**Business Context:**
A mid sized e-commerce company in the retail industry, specifically the marketing department, wants to optimize product promotions across different regions.

Data Challenge:
The company has a large dataset of customer transactions, including product IDs, purchase dates, quantities, and regional information. They need to identify which products sell the most in each region and understand customer purchasing behavior to improve marketing strategies.

Expected Outcome:
Determine the top-performing products per region, identify frequent buyers, and create customer segments for personalized marketing campaigns to increase sales and engagement.
================================================================================================
(2)**Success Criteria (5 measurable goals):**
Identify the top 5 products per region or quarter
Metric: Product sales rank within each region or quarter.
Window Function: RANK()
Goal: Determine the 5 highest-selling products in each region or quarter to guide inventory and marketing decisions.
Calculate running monthly sales totals
Metric: Cumulative sales for each month.
Window Function: SUM() OVER(PARTITION BY month ORDER BY date ROWS UNBOUNDED PRECEDING)
Goal: Track month-to-date sales progression to monitor performance against targets.
Measure month-over-month growth
Metric: Change in sales compared to the previous month.
Window Function: LAG(sales) OVER(PARTITION BY region ORDER BY month)
Goal: Identify growth trends and detect declining performance in specific regions.
Segment customers into quartiles
Metric: Customer ranking based on total spend.
Window Function: NTILE(4) OVER(ORDER BY total_spent DESC)
Goal: Classify customers into four quartiles to target high-value segments with promotions.
Compute three-month moving averages of sales
Metric: Average sales over a rolling 3-month period.
Window Function: AVG(sales) OVER(ORDER BY month ROWS 2 PRECEDING)
Goal: Smooth out short-term fluctuations and better forecast sales trends.

(2)
Table 1: Customers
Column Name	| Data Type     |	Constraints
------------|---------------|------------------------
customer_id	|   INT	PRIMARY | KEY 
first_name	|   VARCHAR(50)	| NOT NULL
last_name   |	  VARCHAR(50) |	NOT NULL
email	      |   VARCHAR(100)|	UNIQUE, NOT NULL
region_id	  |   INT	FOREIGN | KEY → Regions(region_id)

Table 2: Products

Column        |	Data Type	   | Constraints
--------------|--------------|-------------
product_id    |	INT	PRIMARY  | KEY
product_name	| VARCHAR(100) |	NOT NULL
category	    | VARCHAR(50)	 | ______
price         |	DECIMAL(10,2)|NOT NULL

Table 3 : Orders

Column      |	Data Type	   | Constraints
------------|--------------|------------------------------------
order_id	  | INT	         | FOREIGN KEY
customer_id | INT	         | FOREIGN KEY → Customers(customer_id)
product_id	| INT	         | FOREIGN KEY → Products(product_id)
order_date	| DATE	       | NOT NULL
quantity	  | INT	         | NOT NULL
total_amount|	DECIMAL(10,2)| NOT NULL

Table 4: Regions

Column      |	Data       | Type	Constraints
------------|------------|-----------
region_id	  | INT	       | PRIMARY KEY
region_name | VARCHAR(50)| NOT NULL

**ERD DIAGRAM**
                +─────────────┐
                │   Region    │
                │─────────────│
                │ region_id PK│
                │ name        │
                └──────┬──────┘
                       │ 1
                       │
                       │ N
                +──────▼──────┐          +──────────────┐
                │  Customer   │          │   Product    │
                │─────────────│          │──────────────│
                │customer_id PK        │ product_id PK│
                │ name                │ name         │
                │ region_id FK───────▶│ price        │
                └──────┬──────┘          └──────┬───────┘
                       │ 1                             │ 1
                       │                               │
                       │ N                             │ N
                +──────▼──────┐                 +──────▼──────┐
                │    Order     │◀────────────────│             │
                │──────────────│                 │             │
                │ order_id   PK│                 │             │
                │ order_date   │                 │             │
                │ quantity     │                 │             │
                │ total_amount │                 │             │
                │──────────────│                 │             │
                │customer_id FK│─────────────────▶             │
                │ product_id FK│────────────────────────────────┘
                └──────────────┘

<img width="1366" height="736" alt="image" src="https://github.com/user-attachments/assets/ea9f3ff4-8bbd-41b2-b059-8d5aab1d4601" />



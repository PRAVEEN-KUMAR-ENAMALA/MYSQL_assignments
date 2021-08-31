use superstore;

/* 1. Write a query to display the Customer_Name and Customer Segment using alias
name “Customer Name", "Customer Segment" from table Cust_dimen. */
SELECT 
    customer_name AS 'Customer Name',
    customer_segment AS 'Customer Segment'
FROM
    cust_dimen;

/* 2. Write a query to find all the details of the customer from the table cust_dimen order by desc. */
SELECT 
    *
FROM
    cust_dimen
ORDER BY customer_name DESC;

/* 3. Write a query to get the Order ID, Order date from table orders_dimen where
‘Order Priority’ is high. */
SELECT 
    order_id, order_date
FROM
    orders_dimen
WHERE
    order_priority = 'high';
    
/*4. Find the total and the average sales (display total_sales and avg_sales) */     
SELECT 
    SUM(sales) AS total_sales, AVG(sales)
FROM
    market_fact;

/* 5. Write a query to get the maximum and minimum sales from maket_fact table */
SELECT 
    MAX(sales), MIN(sales)
FROM
    market_fact;

/* 6. Display the number of customers in each region in decreasing order of
no_of_customers. The result should contain columns Region, no_of_customers. */
SELECT 
    region, COUNT(region) AS no_of_customers
FROM
    cust_dimen
GROUP BY region
ORDER BY no_of_customers;

/* 7. Find the region having maximum customers (display the region name and max(no_of_customers) */ 
use superstore;

select  max(a.no_of_customers), max(a.region) from (SELECT 
    region, COUNT(region) AS no_of_customers
FROM
    cust_dimen
GROUP BY region
ORDER BY no_of_customers) as a ;



/* 8. Find all the customers from Atlantic region who have ever purchased ‘TABLES’
and the number of tables purchased (display the customer name, no_of_tables purchased) */
SELECT 
    e.customer_name, COUNT(prod_id) AS no_of_tabels
FROM
    cust_dimen AS e
        INNER JOIN
    market_fact AS f ON e.cust_id = f.cust_id
WHERE
    (prod_id = 'prod_11'
        AND e.region = 'atlantic')
GROUP BY e.customer_name; 

/* 9. Find all the customers from Ontario province who own Small Business. (display
the customer name, no of small business owners) */ 
SELECT 
    customer_name,
    COUNT(customer_segment) AS 'no of small business owners'
FROM
    cust_dimen
WHERE
    (province = 'ontario'
        AND customer_segment = 'small business')
GROUP BY customer_name;  

/* 10. Find the number and id of products sold in decreasing order of products sold
(display product id, no_of_products sold) */
SELECT 
    prod_id, COUNT(prod_id) AS 'no of products sold'
FROM
    market_fact
GROUP BY prod_id;

select prod_id, count(prod_id) as no_of_products_sold from market_fact group by prod_id order by no_of_products_sold desc;

/* 11. Display product Id and product sub category whose produt category belongs to
Furniture and Technlogy. The result should contain columns product id, product sub category. */
SELECT 
    prod_id, product_sub_category
FROM
    prod_dimen
WHERE
    product_category = ('furniture' AND 'technology');
    
/* 12. Display the product categories in descending order of profits (display the product
category wise profits i.e. product_category, profits)? */
SELECT 
    g.product_category, SUM(profit) AS 'profits'
FROM
    prod_dimen AS g
        INNER JOIN
    market_fact AS h ON g.prod_id = h.prod_id
GROUP BY g.product_category
ORDER BY profits DESC;

/* 13. Display the product category, product sub-category and the profit within each subcategory in three columns. */
SELECT 
    g.product_category, g.product_sub_category, SUM(profit) AS 'profits'
FROM
    prod_dimen AS g
        INNER JOIN
    market_fact AS h ON g.prod_id = h.prod_id
GROUP BY g.product_category, g.product_sub_category order by profits desc;

/* 14. Display the order date, order quantity and the sales for the order. */
SELECT 
    i.order_date, j.order_quantity, SUM(sales)
FROM
    orders_dimen AS i
        INNER JOIN
    market_fact AS j
GROUP BY i.order_date; 

/* 15. Display the names of the customers whose name contains the
 i) Second letter as ‘R’
 ii) Fourth letter as ‘D’ */
SELECT 
    customer_name
FROM
    cust_dimen
WHERE
    SUBSTRING(customer_name, 2, 1) = 'R';
SELECT 
    customer_name
FROM
    cust_dimen
WHERE
    SUBSTRING(customer_name, 4, 1) = 'D';

/* 16. Write a SQL query to to make a list with Cust_Id, Sales, Customer Name and
their region where sales are between 1000 and 5000. */
SELECT 
    l.cust_id, l.customer_name, m.sales, l.region
FROM
    cust_dimen AS l
        INNER JOIN
    market_fact AS m ON l.cust_id = m.cust_id
WHERE
    sales BETWEEN 1000 AND 5000
GROUP BY l.customer_name;

/* 17. Write a SQL query to find the 3rd highest sales */
SELECT 
    *
FROM
    market_fact
ORDER BY sales DESC
LIMIT 2 , 1;

 /* 18. Where is the least profitable product subcategory shipped the most? For the least
profitable product sub-category, display the region-wise no_of_shipments and the 
profit made in each region in decreasing order of profits (i.e. region,
no_of_shipments, profit_in_each_region) */

SELECT 
    h.ord_id, h.ship_id, g.product_sub_category, sum(profit) AS 'profits'
FROM
    prod_dimen AS g
        INNER JOIN
    market_fact AS h ON g.prod_id = h.prod_id 
    group by g.product_sub_category order by profits ;

 








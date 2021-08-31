 use superstore;
/* SUPERSTORE database has 5 tables which the data is about the sales of the superstore.
  TABLE CUST_DIMEN is about customer name and the customer is realated to which admisnstative division, regions, segment and primary key - cust_id.
  TABLE MARKET FACT is about product sales like price, quantity , discount, profit and some of the ids
  TABLE ORDERS_DIMEN is about the date when was the product was order and order prority 
  TABLE PROD_DIMEN is about the product which category and subcategory 
  TABLE SHIPPING_DIMEN is about when the product was shipped and type of ship mode*/
  
 /* PRIMARY KEYS                                               
 CUST_DIMEN - cust_id 
 MARKET_FACT - in this tabel all are forigen keys
 ORDERS_DIMEN - ord_id
 PROD_DIMEN - prod_id
 SHIPPING_DIMEN - ship_id */
 
 
 
 /* FORIGEN KEYS
 in MARKET_FACT TABEL all are forigen keys
 KEYS     &      REFERENCE from the table 
ORD_ID   FROM  ORDER_DIMEN  
PROD_ID  FROM  PROD_DIMEN    
SHIP_ID  FROM  SHIPPING_DIMEN
CUST_ID  FROM  CUST_DIMEN

AND TABLES ORDER_DIMEN & SHIPPING_DIMEN WAS RELATED WITH ORDER_ID KEY */


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
use superstore;
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


select count(region), region from cust_dimen group by region order by count(region) ;


/* 8. Find all the customers from Atlantic region who have ever purchased ‘TABLES’
and the number of tables purchased (display the customer name, no_of_tables purchased) */

SELECT 
    e.customer_name, COUNT(g.Product_Sub_Category) AS no_of_tabels
FROM
    cust_dimen AS e
        INNER JOIN
    market_fact AS f ON e.cust_id = f.cust_id
    inner join 
    prod_dimen as g on f.Prod_id = g.Prod_id
WHERE
   g.Product_Sub_Category = 'TABLES'
        AND e.region = 'atlantic'
GROUP BY e.customer_name;

/* 9. Find all the customers from Ontario province who own Small Business. (display
the customer name, no of small business owners) */ 
SELECT 
    customer_name, province, customer_segment
FROM
    cust_dimen
WHERE
    (province = 'ontario'
        AND customer_segment = 'small business');  

/* 10. Find the number and id of products sold in decreasing order of products sold
(display product id, no_of_products sold) */
SELECT 
    prod_id, COUNT(prod_id) AS 'no of products sold'
FROM
    market_fact
GROUP BY prod_id order by 'no_of_product_sold';



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
    g.product_category, SUM(h.profit) AS 'profits'
FROM
    prod_dimen AS g
        INNER JOIN
    market_fact AS h ON g.prod_id = h.prod_id
GROUP BY g.product_category
ORDER BY profits;

/* 13. Display the product category, product sub-category and the profit within each subcategory in three columns. */
SELECT 
    g.product_category, g.product_sub_category, SUM(h.profit) AS 'profits'
FROM
    prod_dimen AS g
        INNER JOIN
    market_fact AS h ON g.prod_id = h.prod_id
GROUP BY  g.product_category, g.product_sub_category order by 'profits';

/* 14. Display the order date, order quantity and the sales for the order. */
SELECT 
    i.order_date, j.order_quantity, SUM(sales)
FROM
    orders_dimen AS i
        INNER JOIN
    market_fact AS j on i.ord_id = j.ord_id
GROUP BY i.order_date order by order_date; 

/* 15. Display the names of the customers whose name contains the
 i) Second letter as ‘R’
 ii) Fourth letter as ‘D’ */
SELECT 
    customer_name
FROM
    cust_dimen
WHERE
    (SUBSTR(customer_name, 2, 1) = 'R' and substr(customer_name,4,1) = 'D');


/* 16. Write a SQL query to to make a list with Cust_Id, Sales, Customer Name and
their region where sales are between 1000 and 5000. */
SELECT 
    l.cust_id, l.customer_name, l.region, m.sales
FROM
    cust_dimen AS l
        INNER JOIN
    market_fact AS m ON l.cust_id = m.cust_id
WHERE
    sales BETWEEN 1000 AND 5000 group by customer_name;


/* 17. Write a SQL query to find the 3rd highest sales */
SELECT 
    *
FROM
    market_fact
ORDER BY sales DESC limit 2,1;

select * from market_fact order by sales desc;

 /* 18. Where is the least profitable product subcategory shipped the most? For the least
profitable product sub-category, display the region-wise no_of_shipments and the 
profit made in each region in decreasing order of profits (i.e. region,
no_of_shipments, profit_in_each_region) */
    
SELECT 
    c.region, count(b.ship_id) as 'no_of_shipments', a.product_sub_category, sum(b.profit)
FROM
    prod_dimen AS a
        INNER JOIN
    market_fact AS b ON a.prod_id = b.prod_id
        left JOIN
    cust_dimen AS c ON b.cust_id = c.cust_id group by c.region, a.product_sub_category
ORDER BY sum(b.profit);

 








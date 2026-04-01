select * from `workspace`.`default`.`bright_coffee_shop_analysis_case_study_1` limit 100;

--1 RUNNING ENTIRE TABLE.
select * 
from `workspace`.`default`.`bright_coffee_shop_analysis_case_study_1`;

--2 CHECKING DATE RANGE(FIRST AND LAST DAY).
select min(transaction_date) as First_date,
max(transaction_date) as Last_date
from `workspace`.`default`.`bright_coffee_shop_analysis_case_study_1`;

--3 DIFFERENT STORE LOCATIONS - 3 LOCATIONS
select distinct store_location
from `workspace`.`default`.`bright_coffee_shop_analysis_case_study_1`;

--4 NUMBER OF PRODUCTS SOLD FROM EACH STORE - 9 PRODUCTS.
select distinct product_category
from `workspace`.`default`.`bright_coffee_shop_analysis_case_study_1`;

--5 PRODUCT TYPES SOLD AT EACH STORE -29 PRODUCTS TYPES.
select distinct product_type
from `workspace`.`default`.`bright_coffee_shop_analysis_case_study_1`;

--6 PRODUCT DETAILS OF PRODUCTS SOLD AT EACH STORE.
select distinct product_detail
from `workspace`.`default`.`bright_coffee_shop_analysis_case_study_1`;

--7 RUNNING TABLE TO CHEK FOR NULL VALUES - NO NULL VALUES RETURNED.
select *
from `workspace`.`default`.`bright_coffee_shop_analysis_case_study_1`
where transaction_qty is null 
or transaction_date is null
or unit_price is null;

--8 MIN AND MAX UNIT PRICE
select min(unit_price) as Lowest_unit_price,
max(unit_price) as Highest_unit_price
from `workspace`.`default`.`bright_coffee_shop_analysis_case_study_1`;

--9 CHECKING DAY AND MONTH NAME
select transaction_date,
dayname(transaction_date) as Day_name,
monthname(transaction_date) as Month_name
from `workspace`.`default`.`bright_coffee_shop_analysis_case_study_1`;

--10 CALCULATING THE REVENUE.
select unit_price,
transaction_qty,
unit_price * transaction_qty as Revenue
from `workspace`.`default`.`bright_coffee_shop_analysis_case_study_1`;

--11 COMBINING FUNCTIONS FOR CLEAN AND ENHANCED DATA.
Select transaction_id,
       transaction_date,
       transaction_time,
       transaction_qty, 
       store_id,
       store_location,
       product_id,
       unit_price,
       product_category,
       product_type,
       product_detail,
--Adding columns to enhance the table for better insights 
--- New column added 1      
       Dayname(transaction_date) as Day_name,
---New column added 2       
       Monthname(transaction_date) as Month_name,
--- New column added 3 
       Dayofmonth(transaction_date) as Date_of_Month,
--- New Column added 4 (Determinig weekenday / weekend)
 Case 
     When Dayname(transaction_date) in ('Sun', 'Sat') then 'Weekend'
     Else 'Weekday' 
 End as Day_classification,   
--- New column added 5 ( Determining Time Buckets)
Case 
     When date_format(transaction_time, 'HH:mm:ss') between '05:00:00' and '08:59:59'then '01.Busy Hour'
     When date_format(transaction_time, 'HH:mm:ss') between '09:00:00' and '11:59:59'then '02.Mid morning'
     When date_format(transaction_time, 'HH:mm:ss') between '12:00:00' and '15:59:59'then '03.Afternoon'
     When date_format(transaction_time, 'HH:mm:ss') between '16:00:00' and '18:59:59'then '04. Last Rush'
     Else '05.Night'
 End as Time_classification,
 --- New Column added 6 (Spend Buckets)
 Case 
     When (transaction_qty*unit_price) <=50 then '01. Low spender'
     When (transaction_qty*unit_price) between 51 and 200 then '02. Medium spender'
      When (transaction_qty*unit_price) between 201 and 300 then '03. High spender'
     Else '04.Premium Spender'
 End as Spend_bucket,
--- New column added 7 ( Revenue)
 transaction_qty*unit_price as Revenue
from `workspace`.`default`.`bright_coffee_shop_analysis_case_study_1`;

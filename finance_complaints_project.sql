
Use tabsq_finance;

select *
from finance_product;

-- how many type of product this bank offering?
select count(distinct product)
from finance_product;

select product
from finance_product
group by product;

-- No. of complaints with a product
select product , count(product) as no_of_complaints_with_product
from finance_product
group by product
order by no_of_complaints_with_product desc;

-- how many types of issue with finance product

select issue , count(issue) as no_of_issues
from finance_product
group by issue;

-- most no of issue occured in a state

select state , count(state) as no_of_issue_in_state
from finance_product
group by state
order by no_of_issue_in_state desc

-- Number of issues each year

select DATEPART(year , date_received) as year , count(1) as no_of_issues_in_year
from finance_product
group by DATEPART(year , date_received)

-- how many consumer facing issue satisfied after bank response 
with M as (select sum(case when consumer_disputed = 1 then 1 else 0 end) as consumer_not_satisfied,
sum(case when consumer_disputed = 0 then 1 else 0 end) as consumer_satisfied
from finance_product
group by consumer_disputed
)

,N as (select sum(consumer_not_satisfied) as consumer_not_satisfied , sum(consumer_satisfied) as consumer_satisfied
from M)

select round(1.00*consumer_not_satisfied/(consumer_not_satisfied+consumer_satisfied),2) as not_satified , 
round(1 - round(1.00*consumer_not_satisfied/(consumer_not_satisfied+consumer_satisfied),2),2) as satisfied
from N;

-- how banks closed the issue for consumer

select company_response_to_consumer , count(company_response_to_consumer) as count
from finance_product
group by company_response_to_consumer

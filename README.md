# DataAnalytics-assessment

Question 1.

Firstly, I identified the high-value customers by joining users_customuser with plans_plan to track each user's savings and investment plans.
And then I proceed to count the  savings and investments separately using CASE WHEN to check is_regular_savings and is_a_fund.
I also ensure only funded plans are considered by filtering with HAVING to keep users with at least one savings plan AND one investment plan.
Furthermore I calculated the  total deposits using COALESCE(SUM(plans.amount), 0) to handle cases where a user has no deposits.
Finally, I sort results by total deposits in descending order to prioritise the highest-value customers.


Question 2 


I first analyse the transaction frequency by joining users with their savings transactions and grouping them by month.
Then, I proceed to  calculate the average monthly transactions for each customer, ensuring NULL values are handled with COALESCE.
Furthermore more I categorise customers into High, Medium, or Low frequency based on their average monthly transactions.
And proceed to count customers in each category and compute the overall average transactions per segment.
finally I sort the results logically (High → Medium → Low) using FIELD() for clear reporting.



Question 3 

Firstly, I identify inactive accounts by joining plans with their transactions and calculating the days since their last activity.
I categorize each plan as either Savings or Investment based on its type;  after doing that, I filtered for plans that are inactive for 365+ days using HAVING to focus on truly dormant accounts.
Finally, I sorted the  results by inactivity duration (longest first) to prioritise re-engagement efforts.

Question 4 

I calculate customer lifetime value (CLV) by first determining each user's tenure in months and their total transaction amounts. I then estimate CLV by annualising their average monthly spending and applying a simple multiplier, while carefully handling null values and division by zero. Finally, I present the results sorted by highest CLV to prioritise the most valuable customers.


Difficulties :

1. Understanding the dataset to know which table keys to use in my joins and how the tables are connected.

 I was able to get more context about the dataset by creating a data dictionary, therefore allowing me to have a reference point about the dataset I'm working with

2. Error and Null Handling
3. I had to think about the edge cases where the null will skew the calculation to I used (coalesce and Nullif ) where relevant to handle the null values 





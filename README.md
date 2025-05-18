# DataAnalytics-assessment

Question 1.

Firstly I identified the high-value customers by joining users_customuser with plans_plan to track each user's savings and investment plans.
And then I proceed to count the  savings and investments separately using CASE WHEN to check is_regular_savings and is_a_fund.
I also ensure only funded plans are considered by filtering with HAVING to keep users with at least one savings plan AND one investment plan.
furthermore I calculated the  total deposits using COALESCE(SUM(plans.amount), 0) to handle cases where a user has no deposits.
Finally I sort results by total deposits in descending order to prioritize the highest-value customers.


Question 2 


I first analyze transaction the frequency by joining users with their savings transactions and grouping them by month.
and then I proceed to  calculate the average transactions per month for each customer, ensuring NULL values are handled with COALESCE.
further more I categorize customers into High, Medium, or Low frequency based on their average monthly transactions.
And proceed to count customers in each category and compute the overall average transactions per segment.
finally I sort the results logically (High → Medium → Low) using FIELD() for clear reporting.



Question 3 

Firstly I identify inactive accounts by joining plans with their transactions and calculating the days since their last activity.
I categorize each plan as either Savings or Investment based on its type;  after doing that I filter for plans inactive for 365+ days using HAVING to focus on truly dormant accounts.
Finally I sorted the  results by inactivity duration (longest first) to prioritize re-engagement efforts.

Question 4 

I calculate customer lifetime value (CLV) by first determining each user's tenure in months and their total transaction amounts. I then estimate CLV by annualizing their average monthly spending and applying a simple multiplier, while carefully handling null values and division by zero. Finally, I present the results sorted by highest CLV to prioritize the most valuable customers.


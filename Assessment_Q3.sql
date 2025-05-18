
WITH account_activity AS (
 SELECT
    plans.id AS plan_id,
    plans.owner_id,
    CASE
        WHEN plans.is_regular_savings = 1 THEN 'Savings'
        WHEN plans.is_a_fund = 1 THEN 'Investment'
    END AS type,
    MAX(savings.transaction_date) AS last_transaction_date,
    DATEDIFF(CURRENT_DATE, MAX(savings.transaction_date)) AS inactivity_days -- To get the inactive days
FROM
    adashi_staging.plans_plan AS plans
LEFT JOIN
    adashi_staging.savings_savingsaccount AS savings 
    ON plans.id = savings.plan_id
GROUP BY
    plans.id  
HAVING
    inactivity_days >= 365  -- Last transaction more than 1 year ago
ORDER BY
    inactivity_days DESC
    )
    
    SELECT plan_id, owner_id, type, last_transaction_date, inactivity_days
    FROM account_activity

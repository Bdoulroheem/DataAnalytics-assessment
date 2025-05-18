WITH high_value_customer AS (
    SELECT 
        users.id AS owner_id,
        CONCAT(users.first_name, ' ', users.last_name) AS name,
        SUM(CASE WHEN plans.is_regular_savings = 1 THEN 1 ELSE 0 END) AS savings_count,
        SUM(CASE WHEN plans.is_a_fund = 1 THEN 1 ELSE 0 END) AS investment_count,
        COALESCE(SUM(plans.amount), 0) AS total_deposits
    FROM 
        adashi_staging.users_customuser AS users
    LEFT JOIN 
        adashi_staging.plans_plan AS plans 
        ON users.id = plans.owner_id
    GROUP BY 
        users.id
	HAVING 
		SUM(CASE WHEN plans.is_regular_savings = 1 THEN 1 ELSE 0 END) >= 1
	AND 
		SUM(CASE WHEN plans.is_a_fund = 1 THEN 1 ELSE 0 END) >= 1
)
SELECT 
    owner_id,
    name,
    savings_count,
    investment_count,
    total_deposits
FROM 
    high_value_customer
ORDER BY 
    total_deposits DESC;

WITH CLV AS (
    SELECT 
        users.id AS customer_id,
        CONCAT(users.first_name, ' ', users.last_name) AS name,
        TIMESTAMPDIFF(MONTH, users.date_joined, CURDATE()) AS tenure_months,
        SUM(savings.amount) AS total_transaction,  
        COALESCE(
            (SUM(savings.amount) / NULLIF(TIMESTAMPDIFF(MONTH, users.date_joined, CURDATE()), 0)) * 12 * 0.001, 
            0
        ) AS estimated_clv
    FROM 
        adashi_staging.users_customuser AS users
    LEFT JOIN 
        adashi_staging.savings_savingsaccount AS savings
        ON users.id = savings.owner_id
    GROUP BY 
        users.id  -- Primary key groups all user attributes
)
SELECT 
    customer_id,
    name,
    tenure_months,
    total_transaction,  
    ROUND(estimated_clv, 2) AS estimated_clv
FROM 
    CLV
ORDER BY 
    estimated_clv DESC
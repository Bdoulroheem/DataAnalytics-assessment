WITH frequent_transactions AS (
    SELECT
        users.id AS customer_id,
        DATE_FORMAT(savings.transaction_date, '%Y-%m-01') AS transaction_month, -- Truncate dataset to month
        COUNT(savings.id) AS transactions_count
    FROM
        adashi_staging.users_customuser AS users
    LEFT JOIN
        adashi_staging.savings_savingsaccount AS savings 
        ON users.id = savings.owner_id
    GROUP BY
        users.id, DATE_FORMAT(savings.transaction_date, '%Y-%m-01') 
),
customer_averages AS (
    SELECT
        customer_id,
        COALESCE(AVG(transactions_count), 0) AS avg_transactions_per_month -- To Handle NUll Values
    FROM
        frequent_transactions
    GROUP BY
        customer_id
)
SELECT 
    CASE 
        WHEN avg_transactions_per_month >= 10 THEN 'High Frequency'
        WHEN avg_transactions_per_month >= 3 THEN 'Medium Frequency'
        ELSE 'Low Frequency'
    END AS frequency_category,
    COUNT(customer_id) AS customer_count,
    ROUND(AVG(avg_transactions_per_month), 1) AS avg_transactions_per_month
FROM 
    customer_averages
GROUP BY 
    frequency_category
ORDER BY 
    FIELD(frequency_category, 'High Frequency', 'Medium Frequency', 'Low Frequency'); -- Sort correctly

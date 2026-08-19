USE banking_analysis;

-- Executive KPIs
SELECT COUNT(*) total_transactions,
       ROUND(SUM(amount),2) total_transaction_value,
       ROUND(AVG(amount),2) average_transaction
FROM transactions;

-- Transaction type
SELECT transaction_type, COUNT(*) transaction_count,
       ROUND(SUM(amount),2) total_value, ROUND(AVG(amount),2) avg_value
FROM transactions GROUP BY transaction_type ORDER BY total_value DESC;

-- Monthly trend
SELECT DATE_FORMAT(transaction_date,'%Y-%m') month, COUNT(*) transaction_count,
       ROUND(SUM(amount),2) total_value
FROM transactions GROUP BY month ORDER BY month;

-- City analysis
SELECT city, COUNT(*) transaction_count, ROUND(SUM(amount),2) total_value
FROM transactions GROUP BY city ORDER BY total_value DESC;

-- Fraud overview
SELECT SUM(fraud_flag) fraud_transactions,
       ROUND(SUM(fraud_flag)*100.0/COUNT(*),2) fraud_rate,
       ROUND(SUM(CASE WHEN fraud_flag=1 THEN amount ELSE 0 END),2) fraud_amount
FROM transactions;

-- Fraud by channel
SELECT channel, COUNT(*) transaction_count, SUM(fraud_flag) fraud_transactions,
       ROUND(SUM(fraud_flag)*100.0/COUNT(*),2) fraud_rate
FROM transactions GROUP BY channel ORDER BY fraud_rate DESC;

-- Top customers
SELECT customer_id, customer_segment, city, COUNT(*) transaction_count,
       ROUND(SUM(amount),2) total_value
FROM transactions
GROUP BY customer_id, customer_segment, city
ORDER BY total_value DESC LIMIT 10;

-- Window function: customer rank by city
WITH c AS (
 SELECT customer_id, city, SUM(amount) total_value
 FROM transactions GROUP BY customer_id, city
)
SELECT *, RANK() OVER(PARTITION BY city ORDER BY total_value DESC) city_rank
FROM c;

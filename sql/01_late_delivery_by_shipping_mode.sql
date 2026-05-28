-- Late Delivery Rate by Shipping Mode
-- Question: Which shipping mode has the highest late delivery rate?
-- Finding: First Class has a 95.32% late delivery rate despite being a premium tier.

SELECT
  `Shipping Mode`,
  COUNT(*) AS total_orders,
  SUM(`Late_delivery_risk`) AS late_orders,
  ROUND(AVG(`Late_delivery_risk`) * 100, 2) AS late_rate_pct
FROM supply_chain.orders
GROUP BY `Shipping Mode`
ORDER BY late_rate_pct DESC

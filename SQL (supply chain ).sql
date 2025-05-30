USE supply_chain;

SELECT * FROM supply_chain_data
LIMIT 10;


-- minimize delivery delays

  SELECT
  Warehouse_ID,
  ROUND(AVG(Lead_Time_Days), 2) AS Avg_Lead_Time,
  ROUND(AVG(Shipping_Time_Days), 2) AS Avg_Shipping_Time,
  ROUND(AVG(Order_Processing_Time), 2) AS Avg_Order_Processing_Time
FROM supply_chain_data
GROUP BY Warehouse_ID
ORDER BY Avg_Lead_Time DESC;

    
    -- enhance inventory management
    
    
    SELECT
  Warehouse_ID,
  Current_Stock,
  Warehouse_Capacity,
  ROUND(Current_Stock / NULLIF(Warehouse_Capacity, 0), 2) AS stock_utilization,
  Stockout_Risk,
  Backorder_Quantity,
  Damaged_Goods
FROM supply_chain_data
WHERE Warehouse_Capacity > 0
ORDER BY stock_utilization desc
LIMIT 10;
    

-- improve demand forecasting



SELECT
  Product_Category,
  SUM(Demand_Forecast) AS Total_Forecast,
  SUM(Monthly_Sales) AS Total_Actual_Sales,
  (SUM(Monthly_Sales) - SUM(Demand_Forecast)) AS Forecast_Error,
  ROUND((SUM(Monthly_Sales) - SUM(Demand_Forecast)) / NULLIF(SUM(Demand_Forecast), 0) * 100, 2) AS forecast_error_percentage
FROM supply_chain_data
GROUP BY Product_Category
ORDER BY Forecast_Error DESC;


-- maximize profit margin


SELECT
  Warehouse_ID,
  SUM(Monthly_Sales * 20) AS Total_Revenue,
  SUM(Operational_Cost + Storage_Cost + Transportation_Cost + Damaged_Goods * 10) AS Total_Cost,
  SUM(Monthly_Sales * 20) - SUM(Operational_Cost + Storage_Cost + Transportation_Cost + Damaged_Goods * 10) AS Estimated_Profit
FROM supply_chain_data
GROUP BY Warehouse_ID
ORDER BY Estimated_Profit DESC;



-- Summary table 

SELECT 
Warehouse_ID,
Location,
Product_Category,
Order_Processing_Time,
Product_Category,
Employee_Count,
Lead_Time_Days,
Shipping_Time_Days,
Demand_Forecast,
Monthly_Sales,



-- Profit Calculation
  SUM(Monthly_Sales * 20) AS Total_Revenue,
  SUM(Operational_Cost + Storage_Cost + Transportation_Cost + Damaged_Goods * 10) AS Total_Cost,
  SUM(Monthly_Sales * 20) - SUM(Operational_Cost + Storage_Cost + Transportation_Cost + Damaged_Goods * 10) AS Estimated_Profit,

-- Average Delivery Delay
  ROUND(AVG(Lead_Time_Days + Shipping_Time_Days + Order_Processing_Time), 2) AS Avg_Delay_Days,
  
  -- Stock Utilization
  ROUND(AVG(Current_Stock / NULLIF(Warehouse_Capacity, 0)), 2) AS Avg_Stock_Utilization,
  
  -- Forecast Error 
  SUM(Monthly_Sales - Demand_Forecast) AS Total_Forecast_Error

FROM supply_chain_data
GROUP BY Warehouse_ID, Location, Product_Category, Order_Processing_Time, Product_category, Employee_Count, Lead_Time_Days, Shipping_Time_Days, Demand_Forecast, Monthly_Sales




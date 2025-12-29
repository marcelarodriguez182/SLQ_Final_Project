
# Final Project "Food Delivery Database"

**Database: SQLite**

**Tool: DBeaver**



## Introduction

This project focuses on analyzing a food delivery platform dataset using SQLite and DBeaver to explore customer behavior, restaurant performance, and delivery operations. The dataset was imported from CSV files into a relational SQLite database, where tables were structured with primary and foreign keys to reflect real-world relationships.

Using SQL queries, the analysis included data selection, filtering, aggregation, and table joins to answer key business questions. Queries were designed to examine order volume, average order value, repeat customer behavior, cuisine popularity, and delivery performance metrics such as delivery time and distance.

Throughout the project, SQL was used as the primary tool for data exploration and analysis, enabling the identification of trends, patterns, and operational insights. The results demonstrate how relational databases and SQL can be effectively applied to transform raw data into meaningful business intelligence.
## Enable foreign key enforcement in SQLite 

Foreign key constraints were enabled in SQLite using:


PRAGMA foreign_keys = ON;


This ensures that relationships between tables are enforced, maintaining data integrity and preventing invalid references between records such as customers, orders, and deliveries.
## Creation of database tables 

The database tables were created using SQL in SQLite to represent the core entities of a food delivery platform, including customers, restaurants, menu_items, drivers, orders, order_itmes, and deliveries. Each table was designed with a primary key to uniquely identify records, and foreign keys were used to establish relationships between related tables.

This structure allows the database to accurately model real-world interactions, such as customers placing orders, restaurants offering menu items, and drivers completing deliveries. Creating well-defined tables with clear relationships ensures data consistency and supports efficient querying for analysis purposes.
## Data validation and data import

Before importing the data, the SQLite database structure was validated to confirm that all required tables existed and were properly recognized by the system. This was done by querying the sqlite_master table, which lists all tables stored in the database. This step helped ensure that the schema was correctly created and ready to receive data.

Foreign key constraints were then enabled using PRAGMA foreign_keys = ON, which is necessary in SQLite to enforce referential integrity. After enabling this setting, foreign key relationships were verified for key tables such as orders, deliveries, order items, and menu items using PRAGMA foreign_key_list. This validation ensured that relationships between tables were correctly defined and consistent.

Once the database structure and relationships were confirmed, the data was imported from multiple CSV files into the corresponding SQLite tables using DBeaver. Each CSV file was carefully mapped to its target table, ensuring correct column alignment and data types. With the data successfully loaded, the database was fully prepared for SQL querying and analytical exploration.
## Database diagram 


After validating the database structure and importing the data, an entity-relationship diagram (ERD) was created to visualize the overall database design. The diagram illustrates how the tables are connected through primary and foreign key relationships, providing a clear representation of the data model.

The ERD highlights the core entities of the food delivery platform, such as customers, restaurants, orders, order items, menu items, drivers, and deliveries. By visualizing these relationships, the diagram helps clarify how transactional data flows across the system and how different entities interact with one another.

This diagram was especially useful for understanding the database structure before writing complex SQL queries, as it helped identify the correct join paths and ensured that relationships were used consistently during analysis.

![ER Diagram](https://raw.githubusercontent.com/marcelarodriguez182/SLQ_Final_Project/refs/heads/main/Visualizations/Final_Project_Diagram.png)







## Queries

1. Identify restaurants with the highest number of orders and total revenue.


The results of this query highlight the top 10 restaurants based on total revenue and order volume. The analysis shows that revenue generation is influenced not only by the number of orders but also by the average order value (AOV).

The restaurant Griffin, Davies and Mitchell Kitchen ranks first in total revenue, generating the highest income despite not having the highest number of orders. This indicates a strong performance driven by a relatively high average order value. Similarly, restaurants such as Jones Inc Kitchen stand out for having one of the highest average order values, suggesting a more premium pricing strategy with fewer but higher-value orders.

On the other hand, restaurants like Mckee-Lee Kitchen and Hale, Myers and Larson Kitchen show higher order volumes but lower average order values, which results in lower total revenue compared to restaurants with fewer but more expensive orders. This contrast demonstrates that higher order volume does not necessarily translate into higher revenue.

Overall, the results reveal two different performance patterns among top restaurants:

-Restaurants that generate revenue through high order volume, and

-Restaurants that rely on higher-value orders.
Understanding this distinction is key for evaluating restaurant performance and identifying opportunities to optimize pricing, promotions, and customer strategies.


![](https://raw.githubusercontent.com/marcelarodriguez182/SLQ_Final_Project/refs/heads/main/Visualizations/Q_1.png)


2. Identify customers with the highest total spending and order frequency.

This query identifies the top 10 customers based on total spending and order frequency, providing insight into customer value and purchasing behavior. The results show that high customer value is driven by a combination of order volume and average order value.

Michael Jordan and Julie Thornton lead in total spending, each placing a high number of orders with consistently strong average order values. Their purchasing patterns indicate loyal customers who contribute significantly to overall platform revenue. Similarly, customers such as David Lee and Veronica Torres stand out due to high order counts, even when their average order values are slightly lower.

Other customers, such as Mary Aguilar, demonstrate a different behavior pattern: fewer orders but a relatively high average order value. This suggests occasional but higher-value purchases, which still result in strong total spending.

Overall, the results highlight two key customer segments:

-High-frequency customers who generate value through repeated orders, and

-High-value customers who contribute through larger average purchases.

Understanding these segments can support targeted retention strategies, personalized promotions, and loyalty programs aimed at maximizing long-term customer value.


![](https://raw.githubusercontent.com/marcelarodriguez182/SLQ_Final_Project/refs/heads/main/Visualizations/Q_2.png)


3. Top 10 most ordered menu items.


The analysis of menu items shows clear patterns when considering cuisine type, item category, and order frequency. Certain cuisine types consistently appear among the most ordered items, indicating strong customer preferences tied to specific food styles.

Mexican cuisine stands out with the most frequently ordered item overall, particularly in the Drink category, suggesting that beverages play a significant role in customer orders for this cuisine. Similarly, Italian cuisine appears multiple times across different categories such as Dessert, Drink, and Side, which indicates a diversified demand where customers are not focused on a single type of product but instead order a variety of items.

In contrast, Chinese and Peruvian cuisines show strong performance in Side and Drink categories, highlighting that complementary items are an important part of customer purchasing behavior for these cuisines. Thai cuisine is primarily represented in the Dessert category, suggesting that customers may favor sweets when ordering Thai food.

Overall, the results suggest that order frequency is influenced by a combination of cuisine type and item category, not just by individual menu items. Categories such as Drinks and Sides consistently appear among the most ordered across multiple cuisines, indicating high cross-cuisine demand. These insights can help restaurants optimize their menus by emphasizing high-performing categories within each cuisine type and tailoring promotions accordingly


![ER Diagram](https://raw.githubusercontent.com/marcelarodriguez182/SLQ_Final_Project/refs/heads/main/Visualizations/Q_3.png)


4. Driver Performance Based on Delivery Volume, Time, and Distance.


This analysis examines driver performance across the complete dataset of 120 drivers, focusing on total deliveries, average delivery time (minutes), and average delivery distance (kilometers). The results show that delivery volume is unevenly distributed, with a small number of drivers completing a disproportionately high number of deliveries, while many drivers complete relatively few.

Drivers with higher delivery volumes tend to exhibit longer average delivery times, suggesting that increased workload may lead to greater operational complexity. However, this relationship is not strictly linear. Several drivers with lower delivery counts also display high average delivery times, indicating that delivery duration is influenced by factors beyond workload alone.

Average delivery distance remains relatively consistent across drivers, generally falling within a similar range regardless of delivery volume. This consistency suggests that distance alone does not account for variations in delivery time. Instead, longer delivery times are likely affected by external operational factors such as traffic conditions, restaurant preparation delays, route efficiency, and delivery zone characteristics.

Overall, considering all 120 drivers provides a more accurate and representative understanding of delivery performance. The findings indicate that delivery efficiency cannot be evaluated using a single metric. Effective performance assessment should account for delivery volume, time, and distance together, highlighting opportunities for workload balancing, route optimization, and operational improvements to enhance overall delivery efficiency.

5. Which cuisine types generate the highest order volume across the platform?

The analysis of order volume by cuisine type shows clear differences in customer demand across the platform. Italian cuisine generates the highest number of orders overall, indicating strong and consistent popularity among customers. This is followed by Peruvian, Japanese, and American cuisines, which also demonstrate high order volumes and represent core drivers of platform activity. Mid-tier cuisines such as Thai, Mexican, and Chinese show solid but comparatively lower demand, suggesting stable niche markets rather than dominant categories. Indian and Mediterranean cuisines record the lowest order volumes, indicating more limited customer reach or fewer participating restaurants. Overall, the results highlight that customer demand is concentrated around a small number of cuisine types, suggesting that expanding restaurant options or promotions within high-performing cuisines could further increase order volume, while targeted marketing or menu optimization may help improve performance for lower-demand cuisines.

![ER Diagram](https://raw.githubusercontent.com/marcelarodriguez182/SLQ_Final_Project/refs/heads/main/Visualizations/Q_5.png)


6. How frequently do customers place repeat orders over time?


The analysis of repeat ordering behavior shows that customer loyalty across the platform is generally low to moderate, with most repeat customers placing only two orders at the same restaurant. The results indicate that repeat orders are spread across a wide variety of restaurants rather than being concentrated in a small number of high-performing locations. This suggests that while customers do return, they tend to do so infrequently and selectively, rather than demonstrating strong long-term loyalty to a single restaurant.

Only a very small number of customer–restaurant pairs show three total orders, which highlights that higher-frequency repeat behavior is relatively rare. This pattern implies that customers are likely exploring different restaurants instead of consistently reordering from the same one. As a result, the platform appears to function more as a discovery-driven marketplace rather than one dominated by habitual repeat purchasing.

From a business perspective, this insight suggests an opportunity to improve customer retention strategies, such as loyalty programs, personalized promotions, or restaurant-specific incentives aimed at increasing repeat order frequency. Restaurants that already show repeat customers, even at low volumes, could be targeted for campaigns designed to convert occasional repeat buyers into more loyal, high-frequency customers. Overall, increasing repeat order frequency could significantly enhance customer lifetime value and stabilize demand across restaurants.


7. What is the average order value per restaurant?


This analysis examines the average order value (AOV) across all restaurants on the platform to understand differences in customer spending behavior and restaurant pricing strategies. The results reveal a wide range of average order values, indicating significant variation in how much customers spend depending on the restaurant.

Restaurants at the top of the list, such as Jones Inc Kitchen, Mendez and Sons Kitchen, and Combs Ltd Kitchen, show average order values above $100, suggesting that these establishments likely offer higher-priced menu items, larger portion sizes, premium ingredients, or bundled meals. These restaurants may rely on fewer but higher-value orders to generate revenue, which can be an effective strategy for profitability if operational costs are well managed.

In contrast, a large number of restaurants fall within a mid-range average order value (approximately $60–$80). This group represents the core of the platform’s marketplace and likely balances affordability with volume. These restaurants may benefit from steady demand and repeat customers, making them strong candidates for promotions, loyalty programs, or upselling strategies to gradually increase order value.

At the lower end of the spectrum, restaurants such as Burger Hub and Taco Fiesta report average order values below $30. These lower values may reflect fast-food or casual dining concepts focused on low prices and high order frequency. While individual orders generate less revenue, these restaurants may compensate through higher order volume and faster turnaround times.

Overall, the findings highlight that average order value varies significantly across restaurants, reflecting different business models and customer segments. Understanding these differences can help the platform tailor marketing strategies, recommend pricing optimizations, and identify restaurants that may benefit from upselling opportunities or menu redesigns to improve revenue performance.

8. Which restaurants have the highest number of repeat customers?

This analysis evaluates customer loyalty by identifying how many repeat customers each restaurant has. A repeat customer is defined as a customer who has placed two or more orders at the same restaurant.

The query first aggregates orders at the customer–restaurant level to count how many times each customer ordered from a specific restaurant. Then, it filters only those customers with at least two orders and counts them per restaurant. Key Insights:

-Several restaurants show two repeat customers, indicating a modest but measurable level of customer retention.

-Most restaurants have only one repeat customer, suggesting that while customers do return, repeat behavior is limited across the platform.

-No restaurant stands out with a significantly high number of repeat customers, which may indicate:

-High customer variety rather than strong loyalty, or

-Opportunities for restaurants to improve retention through promotions, loyalty programs, or service improvements.

-Overall, the results suggest that repeat ordering behavior exists but is relatively low. This insight is valuable for understanding customer engagement and highlights an opportunity for the platform and restaurants to focus on strategies that encourage repeat purchases.

![](https://raw.githubusercontent.com/marcelarodriguez182/SLQ_Final_Project/refs/heads/main/Visualizations/Q_8_1.png)

![](https://raw.githubusercontent.com/marcelarodriguez182/SLQ_Final_Project/refs/heads/main/Visualizations/Q_8_2.png)

## Conclusion

This project analyzed a food delivery platform by examining restaurants, customers, orders, cuisine types, and delivery performance. Through multiple SQL queries, the analysis uncovered meaningful patterns related to customer behavior, restaurant performance, and operational efficiency.

The results show that the platform supports diverse business models. Some restaurants generate higher revenue through high average order values, while others rely on higher order volume with lower-priced orders. Cuisine type plays a significant role in demand, with certain cuisines consistently attracting more orders across the platform. Additionally, delivery performance varies among drivers, highlighting differences in workload, delivery time, and distance that may impact customer satisfaction.

Customer behavior analysis revealed that repeat orders are common, but most customers place a limited number of orders per restaurant. This suggests opportunities for improved customer retention strategies, such as loyalty programs or personalized promotions. Overall, the dataset demonstrates how pricing, cuisine type, and delivery logistics collectively influence the platform’s performance.

These insights provide valuable guidance for improving revenue strategies, optimizing delivery operations, and enhancing the customer experience.

How Do the Insights Relate to the Original Questions?

The insights directly address the original questions posed at the beginning of the analysis. The investigation into restaurant performance answered which restaurants and cuisine types generate the highest demand and order value. The analysis of customer behavior clarified how frequently customers place repeat orders and how purchasing patterns vary across individuals and restaurants.

Questions related to delivery efficiency were answered by examining total deliveries, average delivery time, and distance, revealing that higher delivery volume often correlates with longer average delivery times. This highlights potential capacity and routing challenges as demand increases. Finally, by analyzing average order value, the project connected pricing strategies to revenue generation, showing that higher profitability is not solely dependent on order volume but also on the value of each transaction. 
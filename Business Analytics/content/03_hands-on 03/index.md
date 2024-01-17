## Hands-on 3 (Lawrence Barratt)

### 1) Creating Your Business Flow
1. Navigate to Apps
2. Find and click on Business Flow
3. Click '+ Business Flow'
4. Select 'Configuration' and give the Business Flow an identifiable name
5. Click on Step 1, and rename the step to 'Order Credit Card'
6. Drop down Events, select 'com.easytrade.order-credit-card'

### 2) Adding Subsequent Steps
1. Under the first step, click '+ Add Step'
2. Rename this step to 'Credit Card manufactured'
3. Drop down Events, select 'com.easytrade.update-credit-card-status.created'
4. Add a second Event, select 'com.easytrade.update-credit-card-status.error', and tick 'Business Exception'
5. Under the second step, click '+ Add Step'
6. Rename this step to 'Credit Card shipped'
7. Drop down Events, select 'com.easytrade.update-credit-card-status.shipped'
8. Under the third step, click '+ Add Step'
9. Rename this step to 'Credit Card delivered'
10. Drop down Events, select 'com.easytrade.update-credit-card-status.delivered'

### 3) Adding Configuration and KPIs
1. At the top, click 'Settings'
2. Change Select event to 'com.easytrade.order-credit-card'
3. Change correrlation ID to 'orderId'

### 4) View the Business Flow in the instructor's environment

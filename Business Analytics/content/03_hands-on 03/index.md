## Hands-on 3 (Lawrence Barratt)

### 1) Creating Your Business Flow
1. Navigate to Apps
2. Find and click on Business Flow
3. Click '+ Business Flow'
4. Select 'Configuration' and give the Business Flow an identifiable name
5. Click on Step 1, and rename the step to 'Deposit'
6. Drop down Events, select 'com.easytrade.deposit'

### 2) Adding Subsequent Steps
1. Under the first step, click '+ Add Step'
2. Rename this step to 'Quick Buy'
3. Drop down Events, select 'com.easytrade.quick-buy'
4. Under the second step, click '+ Add Step'
5. Rename this step to 'Quick Sell'
6. Drop down Events, select 'com.easytrade.quick-sell'
7. Under the third step, click '+ Add Step'
8. Rename this step to 'Withdrawal'
9. Drop down Events, select 'com.easytrade.withdraw'

### 3) Adding Configuration and KPIs
1. At the top, click 'Settings'
2. Change Select event to 'com.easytrade.withdraw'
3. Change select KPI to 'amount'
4. Change correrlation ID to 'accountId'

### 4) View the Business Flow in the instructor's environment
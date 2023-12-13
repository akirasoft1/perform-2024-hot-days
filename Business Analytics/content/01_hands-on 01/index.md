## Hands-on 1 (Gabriel Prioli)

### OneAgent capture rule

#### Configure
1. Open "Settings"
1. Open "Business Analytics" menu group
1. Click on "OneAgent"
1. Click on "Add new capture rule"
1. For field "Rule name", copy and paste "Asset purchase" 

#### Configure trigger
1. Click on "Add trigger"
1. For "Data source", select "Request - Path"
1. For "Operator", select "equals"
1. For "Value", copy and paste "/api/trade/BuyAssets"

#### Configure metadata
1. For "Event provider data source", select "Fixed value"
1. For "Event provider fixed value", copy and paste "online website"
1. For "Event type data source", select "Fixed value"
1. For "Event type fixed value", copy and paste "asset-purchase"
1. Leave "Event category" empty

#### Configure additional data
1. Click on "Add data field"
1. For "Field name", copy and paste "amount"
1. For "Data source", select "Request - Body"
1. For "Path", copy and paste "amount"
1. Click on "Add data field"
1. For "Field name", copy and paste "price"
1. For "Data source", select "Request - Body"
1. For "Path", copy and paste "price"
1. At the bottom of the screen, click "Save changes"

### RUM event ingestion

#### Send
1. Open the URL of your easyTrade application
1. You don't need to log in
1. Open the developer console in your browser
1. copy and paste    
    ```
    dynatrace.sendBizEvent("type-RUM", {"custom-attribute": 99})
    ```
1. You will see a line that says "undefined"

### Validate with Notebook

1. Open "Notebooks"
1. Create a new notebook

1. Click on the "+" to add a new section
1. Click on "Query Grail"
1. Copy and paste the query
```
fetch bizevents
| filter event.type=="asset-purchase"
```

1. Click on the "+" to add a new section
1. Click on "Query Grail"
1. Copy and paste the query
```
fetch bizevents
| filter event.type=="type-RUM"
```

### Processing rule

1. Open "Settings"
1. Click on "Business Analytics" menu group
1. Click on Processing
1. Click on "Add rule"
1. For "Rule name", copy and paste "Calculate revenue"
1. For "Matcher (DQL)", copy and paste 
```
event.type=="asset-purchase"
``` 

#### Fields
1. Under "Transformation fields", click on "Add item"
1. For "Type", select "double"
1. For "Name", copy and paste "price"
1. Leave toggles unchanged

#### Fields
1. Under "Transformation fields", click on "Add item"
1. For "Type", select "double"
1. For "Name", copy and paste "amount"
1. Leave toggles unchanged

#### Processor definition
1. For "Processor definition", copy and paste 
```
FIELDS_ADD(trading_volume:price*amount)
```

### Bucket assignment rule
1. Open "Settings"
1. Click on "Business Analytics" menu group
1. Click on "Bucket assignment"
1. Click on "Add rule"
1. For "Rule name", copy and paste "Asset Purchase"
1. For "Bucket", select "Business events (35 days) (default_bizevents)"
1. For "Matcher (DQL)", copy and paste 
```
event.type=="asset-purchase"
```


### Metric extraction rule
1. Open "Settings"
1. Click on "Business Analytics" menu group
1. Click on "Metric extraction"
1. Click on "Add business event metric"
1. For "Key", copy and paste "bizevents.easytrade.trading_volume"
1. For "Matcher (DQL)", copy and paste 
```
event.type=="asset-purchase"
```
1. For "Measure", select "Attribute value"
1. For "Attribute", copy and paste "trading_volume"

### Queries

#### Validate new attribute
1. From the menu, open "Notebooks"
1. Click on the "+" to add a new section
1. Click on "Query Grail"
1. Copy and paste the query
```
fetch bizevents
| filter event.type == "asset-purchase"
| fields price, amount, trading_volume
```
#### Validate metric

1. Click on the "+" to add a new section
1. Click on "Query Grail"
1. Copy and paste the query
``` 
timeseries avg(bizevents.easytrade.trading_volume)
```
1. Click on "Run query"
1. Wait for the first data points to appear

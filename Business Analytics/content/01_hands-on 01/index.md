## Hands-on 1 (Gabriel Prioli)

### OneAgent capture rule

#### Configure
1. In the main menu, open group "Manage"
1. Click on "Settings"
1. Open "Business Analytics" menu group
1. Click on "OneAgent"
1. Click on "Add new capture rule"
1. In rule name, type "Asset purchase" 

#### Configure trigger
1. Click on "Add trigger"
1. For "Data source", select "Request - Path"
1. For "Operator", select "equals"
1. For "Value", type "/broker/api/trade/BuyAssets"

#### Configure metadata
1. For "Event provider data source", select "Fixed value"
1. For "Event provider fixed value", type "online website"
1. For "Event type data source", select "Fixed value"
1. For "Event type fixed value", type "asset-purchase"

#### Configure additional data
1. Click on "Add data field"
1. For "Field name", type "amount"
1. For "Data source", select "Request - Body"
1. For "Path", type "amount"
1. Click on "Add data field"
1. For "Field name", type "price"
1. For "Data source", select "Request - Body"
1. For "Path", type "price"
1. At the bottom of the screen, click "Save changes"

### RUM event ingestion

#### Send
1. Open the URL of your easyTrade application
1. You don't need to log in
1. Open the developer console in your browser
1. Type    
    ```
    dynatrace.sendBizEvent("type-RUM", {"custom-attribute": 99})
    ```
1. You will see a line that says "undefined"

### Add to dashboard

1. In the main menu, open group "Business Analytics"
1. Click on "Explore business events"
1. Type the query
    ```
    fetch bizevents
    | filter event.type=="type-RUM"
    ```
1. Click on "Actions"
1. Click on "Pin to dashboard"
1. Type "Coming from RUM" in the tile title

### Add to dashboard

1. In the main menu, open group "Business Analytics"
1. Click on "Explore business events"
1. Type the query
```
fetch bizevents
| filter event.type=="asset-purchase"
```
1. Click on "Actions"
1. Click on "Pin to dashboard"
1. Type "Coming from OneAgent" in the tile title


### Processing rule
1. In the main menu, open group "Manage"
1. Click on "Settings"
1. Click on "Business Analytics" menu group
1. Click on Processing
1. Click on "Add rule"
1. For "Rule name", type "Calculate revenue"
1. For "Matcher (DQL)", type `event.type=="asset-purchase"`

#### Fields
1. Under "Transformation fields", click on "Add item"
1. For "Type", select "double"
1. For "Name", type "price"
1. Leave toggles unchanged

#### Fields
1. Under "Transformation fields", click on "Add item"
1. For "Type", select "double"
1. For "Name", type "amount"
1. Leave toggles unchanged

#### Processor definition
1. For "Processor definition", type `FIELDS_ADD(trading_volume:price*amount)`

### Bucket assignment rule
1. In the main menu, open group "Manage"
1. Click on "Settings"
1. Click on "Business Analytics" menu group
1. Click on "Bucket assignment"
1. Click on "Add rule"
1. For "Rule name", type "Asset Purchase"
1. For "Bucket", select "Business events (1 year)"
1. For "Matcher (DQL)", type `event.type=="asset-purchase"`


### Metric extraction rule
1. In the main menu, open group "Manage"
1. Click on "Settings"
1. Click on "Business Analytics" menu group
1. Click on "Metric extraction"
1. Click on "Add business event metric"
1. For "Key", type "bizevents.easyTrade.trading_volume"
1. For "Matcher (DQL)", type `event.type=="asset-purchase"`
1. For "Measure", select "Attribute value"
1. For "Attribute", type "trading_volume"

### Queries

#### Validate new attribute
1. In the main menu, open group "Business Analytics"
1. Click on "Explore business events"
1. Type the query

```
fetch bizevents
| filter event.type == "asset-purchase"
| fields price, amount, trading_volume
```
#### Validate metric

1. In the main menu, open group "Observe and explore"
1. Click on "Data explorer"
1. Type `bizevents.easyTrade.trading_volume` in "Select metric" field
1. Click on "Run query"
1. Wait for the first data points to appear
1. Click on "Pin to dashboard"
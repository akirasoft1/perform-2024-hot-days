## Hands-on 4 (Alistair Emslie)

### Automating Business Analytics

#### Creating a new Workflow
1. From the main Dynatrace UI click the "search" icon in the top-left.
1. Search for "Workflows" and click the Workflow app that appears in the search results.
1. Click the "+ Workflow" icon that appears in the top-right when you're in the app.

#### Choosing a trigger
1. When you open your new Workflow you'll be immediately presented with a list of triggers on the right-hand side.
1. Whilst you're building the Workflow, make sure that "On demand trigger" is selected.
1. Once the Workflow is finished, you may want to choose "Time interval trigger."
1. The values you could use are "60" for "Run every (mins)" and "Every day" for the "Rule."

#### Adding a Dynatrace Query Language (DQL) step
1. On the main canvas, hit the "+" icon underneath the "On demand trigger" you have created.
1. Select "Execute DQL Query" from the right-hand menu and enter in the query in the "DQL query" box that appears.
    ```
    fetch bizevents, from:now()-1h
    | filter Type == "CARD_ERROR"
    | parse Details, "JSON:errors"
    | fields `Order ID`, {errors[errorCode], alias:`Error code`}, {errors[errorType], alias:`Error type`}, {errors[errorMessage], alias:`Error message`}
    ```

#### Adding a Code step to format the results
1. On the main canvas, hit the "+" icon underneath the DQL step you have just created.
1. Copy the code below into the "Source code" box on the right-hand side.
    ```
    // optional import of sdk modules
    import { execution } from '@dynatrace-sdk/automation-utils';

    export default async function ({ execution_id }) {

    //Get the result of the previous step running DQL
    const r = await fetch(`/platform/automation/v1/executions/${execution_id}/tasks/<name of step>/result`);
    //Get the content being returned in a variable called "body"
    const body = await r.json();
    //Extract the list of orders affected by errors - "records" is the name of the list of results returned
    const orders = body["records"];
    
    //Loop through the orders and format nicely to send to Slack
    var niceOutput = ":warning: Orders failing to update credit card: \n";
    orders.forEach((order) =>  niceOutput = niceOutput + "\n" + ":credit_card: [*Order ID*]: " + order['Order ID'] + ", :1234: [*Error code*]: " + order['Error code'] + ", :hourglass_flowing_sand: [*Error type*]: " + order['Error type'] + ", :email: [*Error message*]: " + order['Error message'] + "\n");
    
    return { niceOutput };
    }
    ```
1. Make sure to replace the "\<name of step\>" with the name of the "Execute DQL query" step - which by default is "execute_dql_query_1".
1. To make your results easier to see - alter the initial message starting "Orders failing to update credit card" with your name!

#### Adding a step to send the results to Slack
1. On the main canvas, hit the "+" icon underneath the Code step you have just created.
1. Select the "Send message" tile under the "Slack for Workflows" section.
1. In the options that appear on the right-hand side, select "HOT day 2023" under the "Connection."
1. Choose "business-analytics-automation" as the channel (it should be the only option).
1. In the "Message" field, enter the below.
    ```
    {{ result('<name of previuous step>') }}
    ```
1. Make sure to replace "\<name of previous step\>" with the name of the Code step - which by default is "run_javascript_1".

#### Run the Workflow!
1. Once you've finished the steps above - hit the "Run" button at the top of the screen! If you have not previously saved the Workflow it may ask you to "Save and Run."


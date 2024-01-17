## Hands-on 4 (Alistair Emslie)

### Automating Business Analytics

#### Creating a new Workflow
1. From the main Dynatrace UI click the "search" icon in the top-left.
1. Search for "Workflows" and click the Workflow app that appears in the search results.
1. Click the "+ Workflow" icon that appears in the top-right when you're in the app.
1. (Optional) In the top-left give your Workflow a nice name!

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
    | filter type == "CARD_ERROR"
    | parse details, "JSON:errors"
    | fields orderId, {errors[errorCode], alias:`Error code`}, {errors[errorType], alias:`Error type`}, {errors[errorMessage], alias:`Error message`}
    ```

#### Adding a Code step to format the results
1. On the main canvas, hit the "+" icon underneath the DQL step you have just created.
1. Add a "Run JavaScript" step.
1. Copy the code below into the "Source code" box on the right-hand side.
    ```
    // optional import of sdk modules
    import { execution } from '@dynatrace-sdk/automation-utils';

    export default async function ({ execution_id }) {

    //Enter your details here!
    //------------------------
    const yourName = "Test user";
    const dqlStepName = "execute_dql_query_1";

    //Get the result of the previous step running DQL
    const r = await fetch(`/platform/automation/v1/executions/${execution_id}/tasks/${dqlStepName}/result`);
    //Get the content being returned in a variable called "body"
    const body = await r.json();
    //Extract the list of orders affected by errors - "records" is the name of the list of results returned
    const orders = body["records"];
    
    //Loop through the orders and format nicely to send to Slack
    var niceOutput = ":warning: [" + yourName + "] Orders failing to update credit card: \n";
    orders.forEach((order) =>  niceOutput = niceOutput + "\n" + ":credit_card: [*Order ID*]: " + order['orderId'] + ", :1234: [*Error code*]: " + order['Error code'] + ", :hourglass_flowing_sand: [*Error type*]: " + order['Error type'] + ", :email: [*Error message*]: " + order['Error message'] + "\n");
    
    return { niceOutput };
    }
    ```
1. Make sure to update the "yourName" and "dqlStepName" with the details you have used.
1. "yourName" will add an identifier into your Slack message so we can confirm it has worked! "dqlStepName" is the name given to the previous DQL step, which by default is "execute_dql_query_1".

#### Adding a step to send the results to Slack
1. On the main canvas, hit the "+" icon underneath the Code step you have just created.
1. Select the "Send message" tile under the "Slack for Workflows" section.
1. In the options that appear on the right-hand side, select "Create a new connection" which should open a new browser tab.
1. Before you fill in the Slack connection, go to "Preferences" > "Limit outbound connections" in the menu to the left.
1. Click "Add item" and enter "slack.com" > click "Save changes."
1. Whilst still in the "Settings" app, go back to "Dynatrace Apps" > "Slack Connections."
1. Click "Add item," and enter the following details.
   ```
   Connection name: HOT day 2024
   Bot token: xoxb-6050153798579-6035743974439-U9nUq1crfS5DKONk4KOQ9do6
   ```
1. Hit "Save changes" at the bottom.
1. Head back to your previous browser tab with the Workflow in, select the dropdown again and your new connection should appear.
1. Select the "business-analytics-automation" channel.
1. In the "Message" field, enter the below.
    ```
    {{ result('<name of previuous step>.niceOutput') }}
    ```
1. Make sure to replace "\<name of previous step\>" with the name of the Code step - which by default is "run_javascript_1".

#### Run the Workflow!
1. Once you've finished the steps above - hit the "Run" button at the top of the screen! If you have not previously saved the Workflow it may ask you to "Save and Run."


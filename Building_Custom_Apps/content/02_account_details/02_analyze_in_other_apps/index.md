## Analyze data in other apps

To give our app users the ability to dig deeper into the account details data, let's create a drilldown into other Dynatrace apps so they can freely analyze this data.

### 📌 Send an intent

#### 📖 Reminder

The easiest way to send an intent to other apps is to use Strato's `<IntentButton/>` component. It takes the intent payload in its `payload` property, and an optional label as a child. For example:

```JSX
return <IntentButton payload={myIntentPayload}>Analyze query</IntentButton>
```

Many Dynatrace apps are suitable for analysing Grail query results. All of these can handle an intent payload structure of:

```json
{  "dt.query": "fetch logs..."  }
```

#### 📄 Your Task

In the `app/components/AccountDetails.tsx` file, find the comment `{/* Exercise 3.2. Add intent button */}`.

1. Just under the comment add an `<IntentButton>` element.
2. Set the `payload` property of the `IntentButton` to `{ "dt.query": query }` and label the button as `Analyze further`

<details>
  <summary>
    <strong>💡 Need a hint? Expand for solution...</strong>
  </summary>

```JSX
<IntentButton payload={{ "dt.query": query }}>Analyze further</IntentButton>
```

</details>

## ✅ Verify your results

You have completed this section when the expanded row of your table displays a button labelled "Analyze further":

![analyze_further](../../assets/images/22_intent_button.png)

When clicking the button, you should be presented with apps that can handle this intent:

![apps](../../assets/images/22_apps_suggested.png)
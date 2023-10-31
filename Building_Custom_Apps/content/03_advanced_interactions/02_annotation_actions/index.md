## Drill down into trading activity data

Our EasyTrade Analytics app is nearly complete. The only thing missing is giving our users the ability to open the trading activity check data in a Notebook for further analysis and reporting.

### 📌 Annotations actions

#### 📖 Reminder

To add an action to our annotation, use the `annotationsActions` property of the `<TimeseriesChart.Annotations>` element. This property's value must be a function which takes the clicked `annotation` as input, and renders elements. Strato provides `<ChartSeriesAction>` and `<ChartSeriesAction.Item>` elements for implementing action logic (this is done as part of the `onSelect` property). For example:

```JSX
return (
    <TimeseriesChart data={myTimeseriesData}>
      <TimeseriesChart.Annotations
        annotationsActions={(annotation) => (
          <ChartSeriesAction>
            <ChartSeriesAction.Item onSelect={() => { /* Do something */ }}>
              Trigger action
            </ChartSeriesAction.Item>
          </ChartSeriesAction>
        )}
      >
    </TimeseriesChart>
)
```

We can send an intent payload that targets a specific app's intent by using the `sendIntent` function which takes 3 parameters: the intent payload, the target app ID, and the intent ID. For example:

```javascript
sendIntent({ "dt.query": "fetch ..." }, "dynatrace.notebooks", "view-query");
```

#### 📄 Your Task

In the `app/components/AccountDetails.tsx` file, modify the `<TimeseriesChart.Annotations>` element.

1. Add the `annotationsActions` property
2. Set this property's value to a function taking as input an object called `annotation` and returning a `<ChartSeriesAction>` element.
3. Add a `<ChartSeriesAction.Item>` child to the `<ChartSeriesAction>` element. Add the `onSelect` property and set its value to a function which invokes `sendIntent` with the following parameters:
    - The intent payload, which we'll build as `{ "dt.query": buildIntentQuery(account, annotation) }`
    - The recommended app ID - `"dynatrace.notebooks"`
    - The recommended intent ID - `"view-query"`
4. The child of this `<ChartSeriesAction.Item>` element should be the text "Drilldown to Notebooks"

<details>
  <summary>
    <strong>💡 Need a hint? Expand for solution...</strong>
  </summary>

```JSX
<TimeseriesChart.Annotations
  annotationsActions={(annotation) => (
    <ChartSeriesAction>
      <ChartSeriesAction.Item
        onSelect={() => {
          sendIntent({ "dt.query": buildIntentQuery(account, annotation) }, "dynatrae.notebooks", "view-query");
        }}
      >
        Drilldown to Notebooks
      </ChartSeriesAction.Item>
    </ChartSeriesAction>
  )}
>
  <TimeseriesAnnotations.Track>
    {markers.map((marker) => (
      <TimeseriesAnnotations.Marker
        key={marker.start.toISOString()}
        color={marker.color}
        symbol={marker.symbol}
        data={marker}
      />
    ))}
  </TimeseriesAnnotations.Track>
</TimeseriesChart.Annotations>
```

</details>

## ✅ Verify results

Your have completed this section when you can drill down by clicking your chart's annotations:

![drill_down](../../assets/images/32_annotation_action.png)

Clicking the button should prompt you to open the query in the Notebooks app:

![notebook](../../assets/images/32_trading_check_drilldown.png)
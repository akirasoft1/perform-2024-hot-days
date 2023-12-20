## Highlight suspicious trading activity

Now that we have an overview of accounts and the detailed view is showing us trading activity over time, we're going to annotate our charts by highlighting suspicious trading activity checks and their results. Our checks use a simple logic - they're triggered if more than 3 trades happened in half an hour, and if more than $500 were withdrawn it's considered suspicious.

### 📌 Chart annotations

#### 📖 Reminder

To enable annotations on a chart, the TimeseriesChart component must have a child element `<TimeseriesChart.Annotations>`. To have a visual effect, this element must be given a `<TimeseriesAnnotations.Track>` child where we can add `<TimeseriesAnnotations.Marker/>` elements. A simple example:

```JSX
return (
    <TimeseriesChart data={myTimeseriesData}>
      <TimeseriesChart.Annotations>
        <TimeseriesAnnotations.Track>
          {/* A red colored marker to signal an open problem */}
          <TimeseriesAnnotations.Marker
            symbol="⚠️"
            color="#ba1111"
            data={{
              start: new Date(Date.parse('02 Oct 2023 10:00:00 UTC')),
              end: new Date(Date.parse('02 Oct 2023 14:00:00 UTC')),
              title: "Problem detected",
              description: "Problem ongoing since 10 AM on Oct 2nd"
            }}
          />
        </TimeseriesAnnotations.Track>
      </TimeseriesChart.Annotations>
    </TimeseriesChart>
)
```

React will let you create elements from a variable array using the `map` function, but it expectes each of these to have an additional property called `key` which must be a unique string for each element. For example:

```JSX
<List>
  { myArray.map(item => <ListItem key={item.id} />)}
</List>
```

#### 📄 Your Task

In the `app/components/AccountDetails.tsx` file, find the comment `// Exercise 4.1. Create markers`.

1. Just below this comment, make a call to the `createMarkers` function, passing as input `accountDetails.data` which is the result of our DQL query. Store the result in a constant called `markers`.

2. Add a `<TimeseriesChart.Annotations>` child to the `<TimeseriesChart>` element
3. Add a `<TimeseriesAnnotations.Track>` child to the `<TimeseriesChart.Annotations>` element
4. Create a `<TimeseriesAnnotations.Marker>` element for each item in your `markers` array, adding all of these as children to the `<TimeseriesAnnotations.Track>` element (use the `.map()` function on the array).

    For each `<TimeseriesAnnotations.Marker>` element, set the `key` property to `marker.start.toISOString()`, `color` to `marker.color`, `symbol` to `marker.symbol`, and `data` to the actual `marker`.

<details>
  <summary>
    <strong>💡 Need a hint? Expand for solution...</strong>
  </summary>

```JSX
// Exercise 4.1. Create markers
const markers = createMarkers(accountDetails.data);

return (
  <Flex flexDirection="column">
    {/* Exercise 3.1. Visualize timeseries data */}
    <TimeseriesChart>
      <TimeseriesChart.YAxis label="Account balance" position="left" />
      <TimeseriesChart.YAxis label="Trades" position="right" />
      <TimeseriesChart.Line data={balanceTimeseries} />
      <TimeseriesChart.Bar data={tradesTimeseries} />
      <TimeseriesChart.Annotations>
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
    </TimeseriesChart>
    {/* Exercise 5.1. Add intent button */}
  </Flex>
);
```

</details>

## ✅ Verify your results

You have completed this section when your table's expanded row section displays a track above the chart. The track should how green & amber markers, each giving more info on hover:

![trading_checks](../../assets/images/41_trading_checks.png)
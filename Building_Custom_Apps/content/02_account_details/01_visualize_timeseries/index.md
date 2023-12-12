## Account Details

Now that the overview page is complete, it's time to work on a new component so that we can bring additional insights to each account's trading activity.

### 📌 Expandable rows

#### 📖 Reminder

Expandable rows are enabled by adding the `<DataTable.ExpandableRow />` component as a child to the `<DataTable />`. `ExpandableRow` must have a child which is a function taking the row data as input and returning the component that should be rendered in the expanded section. 

For example:

```JSX
<DataTable columns={myColumns} data={myData}>
  <DataTable.ExpandableRow>
    { ({ row }) => <SomeOtherComponent data={row} /> }
  </DataTable.ExpandableRow>
</DataTable>
```

#### 📄 Your Task

In the `app/pages/AccountOverview.tsx` file, modify the DataTable component:

1. Add an expandable row which renders the `<AccountDetails />` component (this has already been imported for you). `AccountDetails` requires a string property called `account` which you can access from the row's `accountId` attribute.

<details>
  <summary>
    <strong>💡 Need a hint? Expand for solution...</strong>
  </summary>

```JSX
<DataTable
  columns={columns}
  data={accounts.data?.records ?? []}
  sortable
  variant={{
    contained: true,
    rowSeparation: "zebraStripes",
    verticalDividers: true,
  }}
>
  <DataTable.Pagination defaultPageSize={20} />
  <DataTable.ExpandableRow>
    { ({row}) => <AccountDetails account={row.accountId} /> }
  </DataTable.ExpandableRow>
</DataTable>
```

</details>

### 📌 Chart the trades and balance

#### 📖 Reminder

Charts are created using Strato's `<TimeseriesChart/>` component which takes the timeseries data its `data` property. It's as simple as:

```JSX
// A chart where timeseries are represented as lines
return <TimeseriesChart data={myTimeseries} />
```

Mixed visualizations are supported through the use of `<TimeseriesChart.{type} />` components which must be added as children to the `<TimeseriesChart/>`. Here, `{type}` can be one of: `Line`, `Bar`, `Area`, or `Band`. For example:

```JSX
// A chart with timeseries shown as lines and bars
return (
  <TimeseriesChart>
    <TimeseriesChart.Line data={myFirstTimeseriesData} />
    <TimeseriesChart.Bar data={myOtherTimeseriesData} />
  </TimeseriesChart>
)
```

#### 📄 Your Task

In the `app/components/AccountDetails.tsx` file, find the comment `// Exercise 2.1 Convert account details to timeseries`. We've already prepared for you a function which takes as input the data from a DQL query result, and converts it into two timeseries - one for the number of trades, the other for the balance.

1. Below the comment, make a call to the `convertAccountTimeseries` function (already imported), passing in `accountDetails.data` as input. The result has two attributes: `balanceTimeseries` and `tradesTimeseries`. Extract these from the function return using the expression `const {balanceTimeseries, tradesTimeseries}`.
2. In the `return` statement (at the end of the file), replace the comment `{/* Exercise 2.1. Visualize timeseries data */}` with a `<TimeseriesChart>` component.
3. Add a line visualization to the Timeseries Chart, where the data is the `balanceTimeseries` from step 1.
4. Add a bar visualization to the Timeseries Chart, where the data is the `tradesTimeseries` from step 1.
5. Check that your table can expand rows and shows a chart with two series.

<details>
  <summary>
    <strong>💡 Need a hint? Expand for solution...</strong>
  </summary>

```JSX
// Exercise 2.1. Convert account details to timeseries
const { balanceTimeseries, tradesTimeseries } = convertAccountTimeseries(accountDetails.data);

return (
  <Flex flexDirection="column">
    {/* Exercise 2.1. Visualize timeseries data */}
    <TimeseriesChart>
      <TimeseriesChart.Line data={balanceTimeseries} />
      <TimeseriesChart.Bar data={tradesTimeseries} />
    </TimeseriesChart>
    {/* Exercise 2.2. Add intent button */}
  </Flex>
);
```

</details>

### 📌 Split chart axes

#### 📖 Reminder

To split the left and right Y Axes of a chart, we can add two `<TimeseriesChart.YAxis>` children to our chart. Each can take `label` and `position` properties to apply a label to the axis. For example:

```JSX
// A chart with timeseries shown as lines and bars, displayed on different Y axes
return (
  <TimeseriesChart>
    <TimeseriesChart.YAxis label="My first series" position="left" />
    <TimeseriesChart.YAxis label="My other series" position="right" />
    <TimeseriesChart.Line data={myFirstTimeseriesData} />
    <TimeseriesChart.Bar data={myOtherTimeseriesData} />
  </TimeseriesChart>
)
```

#### 📄 Your Task

In the `app/components/AccountDetails.tsx` file, make the following changes to the `TimeseriesChart`:

1. Add a YAxis child, with a `label` of "Account balance" and the `position` "left".
2. Add a YAxis child, with a `label` of "Trades" and the `position` "right".

<details>
  <summary>
    <strong>💡 Need a hint? Expand for solution...</strong>
  </summary>

```JSX
{/* Exercise 2.1. Visualize timeseries data */}
<TimeseriesChart>
  <TimeseriesChart.YAxis label="Account balance" position="left" />
  <TimeseriesChart.YAxis label="Trades" position="right" />
  <TimeseriesChart.Line data={balanceTimeseries} />
  <TimeseriesChart.Bar data={tradesTimeseries} />
</TimeseriesChart>
```

</details>

## ✅ Verify your results

You have completed this section when your table can expand its rows, displaying a timeseries chart with 2 series (line & bars):

![row_chart](../../assets/images/21_timeseries_chart.png)
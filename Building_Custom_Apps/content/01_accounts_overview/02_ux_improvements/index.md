## UX Improvements

Now that we have account data on our page, let's make some improvements to the user experience.

### 📌 Handle loading states

#### 📖 Reminder

A quick loading indicator can be added by using the `ProgressCircle` component.

```JSX
<ProgressCircle />
```

#### 📄 Your task

In the `app/pages/AccountOverview.tsx` file, find the comment `// Exercise 1.2. Show loading indicator`.

1. Below the comment add an `if (/* condition */) { /* effect*/ }` statement.
2. In the `if` statement's condition check if `accountQuery.status` is `"loading"` (use the `===` operator).
3. If so, the `if` statement should `return` a `<ProgressCircle />`

<details>
  <summary>
    <strong>💡 Need a hint? Expand for solution...</strong>
  </summary>

```JSX
// Exercise 1.2. Show loading indicator
if (accountQuery.status === "loading") {
  return <ProgressCircle />;
}
```

</details>

### 📌 Customize the data table

#### 📖 Reminder

Pagination can be added to a `DataTable` by adding `DataTable.Pagination` as a child element. Additional customizations are available by adding the `sortable` and `variant` properties.

```JSX
<DataTable
  columns={myColumns}
  data={myData}
  sortable
  variant={{
      contained: true,
      rowSeparation: "zebraStripes",
      verticalDividers: true,
  }}
>
  <DataTable.Pagination defaultPageSize={10} />
</DataTable>
```

#### 📄 Your task

In the `app/pages/AccountOverview.tsx` file, make the following changes to the `DataTable`:
- Make the table sortable
- Enable `zebraStripes` for row separation, and `verticalDividers` for cell separation.
- Add pagination with a `defaultPageSize` of 20

<details>
  <summary>
    <strong>💡 Need a hint? Expand for solution...</strong>
  </summary>

```JSX
// Exercise 1.2. Show loading indicator
if (accountQuery.status === "loading") {
  return <ProgressCircle />;
}

return (
  <Flex flexDirection="column">
    {/* Exercise 1.1. Visualize account data */}
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
    </DataTable>
  <Flex>
)
```

</details>

### ✅ Verify your results

You have completed this section when the loading indicator is displayed before the table data loads...

![loading](../../assets/images/12_table_loading.png)

... and the table looks similar to this one:

![table](../../assets/images/12_table_customized.png)
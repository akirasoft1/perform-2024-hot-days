## Accounts and Balances

Your first task is to create a simple table which will list out all the user accounts and their balances. You will use a predefined DQL query for this.

### 📌 Query account data

#### 📖 Reminder

To run a DQL query you can use the `useDqlQuery` like so:

```typescript
const myQuery = useDqlQuery({ body: { query: "fetch logs" }})
```

#### 📄 Your task

In the `app/pages/AccountOverview.tsx` file, you will see (on line 7) a DQL query already prepared which will extract all user accounts alongside their ID, and balance.

1. Find the line with the comment `// Exercise 1.1. Query account data` 
2. Just below it, invoke the `useDqlQuery` hook, giving it as parameter the query we prepared for you. Store the result in a new `constant` called `accountQuery`.

<details>
  <summary>
    <strong>💡 Need a hint? Expand for solution...</strong>
  </summary>

```typescript
const accountQuery = useDql({ body: { query }});
```

</details>

### 📌 Visualize account data

#### 📖 Reminder

Strato's DataTable component is the easiest way to show data in table format. The component takes columns and data which can both be converted from a DQL query result:

```JSX
const myQuery = useDqlQuery(queryParams);

<DataTable
  columns={convertToColumns(myQuery.data.types)}
  data={myQuery.data.records}
/>
```

#### 📄 Your task

In the `app/pages/AccountOverview.tsx` file, within the `return` statement at the very end, you will see a comment `{/* Exercise 1.1 Visualize account data */}` .

1. Just below it, add a `<DataTable/>` component
2. We have already prepared the table columns in a constant called `columns` - use this for the data table's `columns` property.
3. Use the `records` from your DQL query result for the table's `data` property.
    
**Note:** If you get an error, it's because `data` is not guaranteed to exist (e.g. if query fails or there is no data). To get around this you can add a fallback value to an empty array: `accountQuery.data?.records ?? []`. This tells TypeScript that `data` (and thus `records`) may not exist (using `?`) and in that case an empty array should be used. 

<details>
  <summary>
    <strong>💡 Need a hint? Expand for solution...</strong>
  </summary>

```JSX
<DataTable columns={columns} data={accounts.data?.records ?? []} />
```

</details>

### ✅ Verify your results

You have finished this section when your app displays a table with email addresses and account balances.

![account_list](../../assets/images/11_account_list.png)
## Display the balance in EUR

Our Account Overview page currently displays user accounts by email and their balance in USD. However, EasyTrade is an international platform, so it will be beneficial to also display the balance in EUR.

An online service (which you can access [here](https://dt-url.net/currencyrates)) gives us the daily currency rates for known pairs, one of which is USD/EUR. We can use this value to convert our USD balance into EUR.

### 📌 Create an app function

#### 📖 Reminder

To create a serverless function, first stop the app from running using <kbd>Ctrl + C</kbd> . Then, run the command:

```bash
npm run generate:function
```

Making a call to a URL using JavaScript's fetch API and returning the JSON data looks like:

```typescript
return fetch("https://my-url.com").then(response => response.json());
```

#### 📄 Your Task

1. Create a serverless function called `exchange-rates` (use the `npm run generate:function` command)
2. In the `api/exchange-rates.ts` file that was created, replace the function content with a call to the currency rates service, returning the JSON data.

<details>
  <summary>
    <strong>💡 Need a hint? Expand for solution...</strong>
  </summary>

```typescript
export default async function () {
  return fetch("https://dt-url.net/currencyrates").then(response => response.json());
}
```

</details>

### 📌 Call the function to fetch the data

#### 📖 Reminder

To call your function from within the app, use `functions.call`. Here's an example:

```typescript
functions
  .call("my-function")                    // first, call the function
  .then(response => response.json())      // then, extract the JSON
  .then(json => { /* Use the JSON */ });  // then, use the JSON data
```

#### 📄 Your Task

1. In the `app/hooks/useExchangeRates.ts` find the comment `// Exercise 1.3. Call the serverless function`
2. Bellow the comment, make a call to your serverless function, making sure to extract the JSON response. Once you extracted the JSON, use the `setData` function to store this.
3. Add another step to the function call using `.finally` and update the loading state to `false`.

    It will look something like this: `.finally(() => { setIsLoading(false); })`

<details>
  <summary>
    <strong>💡 Need a hint? Expand for solution...</strong>
  </summary>

```typescript
useEffect(() => {
  setIsLoading(true);

  // Exercise 1.3 Call the serverless function
  functions
    .call("get-currency-rates")
    .then(response => response.json())
    .then(json => setData(json))
    .finally(() => setIsLoading(false));

}, []);
```

</details>
  
### 📌 Display account balance in EUR

#### 📖 Reminder

To add a column which doesn't render table data directly, create it with an `id` and the `accessor` a function that takes in a row element and returns your calculated value. For example:

```javascript
const calculatedColumn = {
  id: "myColumnId",
  accessor: row => row.someAttribute * 10,
  columnType: "number"
}
```

#### 📄 Your Task

1. Find the comment `// Exercise 1.3. Get exchange rates`. Just below it, make a call to the `useExchangeRates` hook and store the result in a constant called `exchangeRates`.
2. In the `columns` constant, find the comment `// Exercise 1.3 Add a column`, and add another entry to the list.
3. Give this column an `id`, name it `Balance [€]`, set the column type to `number`, and give it a ratio width of 1. Calculate its value in the `accessor` by dividing the `balanceUsd` by the `EUR_USD` currency exchange rate (hint: this is in the `data` attribute of your hook).

<details>
  <summary>
    <strong>💡 Need a hint? Expand for solution...</strong>
  </summary>

```typescript
// Exercise 1.3 Get exchange rates
const exchangeRates = useExchangeRates();

const columns: TableColumn[] = [
  {
    header: "Account",
    accessor: "account",
    ratioWidth: 3,
  },
  {
    header: "Balance [$]",
    accessor: "balanceUsd",
    columnType: "number",
    ratioWidth: 1,
  },
  // Exercise 1.3 Add a column
  {
    header: "Balance [€]",
    id: "balanceEur",
    columnType: "number",
    accessor: (row) => row.balanceUsd / exchangeRates.data.EUR_USD,
  },
];
```

</details>

## ✅ Verify your results

You have completed this section when the table displays another column called "Balance [€]". Note that this amount should be lower than the one in "Balance [$]".

![balance_eur](../../assets/images/13_balance_in_EUR.png)
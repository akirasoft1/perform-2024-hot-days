## Lab 2: Extract information using DPL
Up to now we have mostly used Dynatrace Query Language (DQL) to filter the results based on simple conditions, like contains, to find interesting information in the log content. But this approach is limited and not very efficient. With Dynatrace Pattern Language (DPL) we parse the log content to extract interesting data and convert it to a specific format (string, number, IP, JSON, etc.).

#### Notebook Template
You can find the instructions and the template for the lab in this notebook: 
[https://sel18797.sprint.apps.dynatracelabs.com/ui/document/v0/#share=f9b72132-2972-473f-826b-7d3b4b8a7e7e](https://sel18797.sprint.apps.dynatracelabs.com/ui/document/v0/#share=f9b72132-2972-473f-826b-7d3b4b8a7e7e)

> - The notebook is read-only, duplicate it to create your own copy which you can use to work on the exercises. 


### 1. Extract URL and method
Use the parse command to extract the HTTP Method and URL from the content
> - Extract the HTTP Method and URL as separate fields


### 2. Filter and summarize
Now that we have the HTTP method and URL extracted as fields, we can use that information to filter and aggregate. 
> - Filter the query to get only the POST requests and count the number of requests for each URL.
>   -  **Which url has the most requests?**"

### 3. Extract additional details
Now lets improve the parse pattern to also extract further details.
> - Extract the HTTP Response Code and the IP address from the content

## Lab 2: Extract information using DPL
Up to now we have mostly used Dynatrace Query Language (DQL) to filter the results based on simple conditions, like contains, to find interesting information in the log content. But this approach is limited and not very efficient. With Dynatrace Pattern Language (DPL) we parse the log content to extract interesting data and convert it to a specific format (string, number, IP, JSON, etc.).

#### Notebook Template
You can find the instructions and the template for the lab in this notebook: 
https://vis62283.sprint.apps.dynatracelabs.com/ui/document/v0/#share=3c24dca9-76cb-494d-8583-0ec389709906
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

### 4. Find further evidence in spans

We found out that someone tried to login with many username/password combinations. As a net step, let's try to find out where these requests come from. Unfortunately the client IP address is no part of the log content, but we can use spans to find the client IP. Since know that the URL for the login is /user/login, we can filter the spans by that

### 5. Group by IP

Since there are a lot of request to the login page, this yields many results. Let's group them by IP to find the ones that generate a lot of requests.
> - Count the number of requests by IP
>   - Hint: use the summarize command
